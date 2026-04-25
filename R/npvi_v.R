#' nPVI V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of nPVI of vowels
#'
#' nPVI V is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
#' It calculates the normalised sum of the absolute differences between pairs of consecutive vocalic intervals divided by the number of pairs in the speech sample.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param v_label a string to filter the vowels, e.g. `v_label = 'vowel'`
#' @param utterance_id column name for unique utterance IDs
#' @param cv_duration column name for the duration of C or V
#'
#' @return a data frame containing the mean nPVI for vowels
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 8),
#'                       utterance_id = rep(c("utt_1", "utt_2", "utt_3", "utt_4"), each = 4),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7,
#'                                        0.3, 0.88, 0.5, 0.9, 0.3, 0.57, 0.4, 0.97))
#'
#' npvi_v(df_test, v_label="vowel", utterance_id, cv_duration)
#'
#' @export
npvi_v <- function(df, v_label, utterance_id, cv_duration) {
  
  # 1. Filter for vowels and calculate nPVI per utterance
  npvi_data <- df %>%
    dplyr::filter({{ cv_label }} == v_label) %>%
    dplyr::group_by({{ utterance_id }}) %>%
    dplyr::mutate(
      # Calculate |(d1 - d2) / ((d1 + d2) / 2)| for each pair
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }})),
      pair_mean = ({{ cv_duration }} + dplyr::lead({{ cv_duration }})) / 2,
      pair_norm = pair_diff / pair_mean
    ) %>%
    dplyr::summarise(
      # Sum the normalized differences and divide by (m-1) pairs
      # m-1 is achieved because lead() creates an NA at the end which sum(na.rm=T) ignores
      # but we must explicitly count pairs as n() - 1
      m_minus_1 = dplyr::n() - 1,
      npvi_utt = (sum(pair_norm, na.rm = TRUE) / m_minus_1) * 100,
      .groups = "drop"
    )

  # 2. Return the mean across all utterances
  result <- npvi_data %>%
    dplyr::summarise(npvi = mean(npvi_utt, na.rm = TRUE))

  return(result)
}
