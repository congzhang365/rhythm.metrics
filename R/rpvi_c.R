#' rPVI C
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of rPVI of consonants.
#'
#' rPVI C is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
#' It calculates the sum of the absolute differences between pairs of consecutive consonantal intervals divided by the number of pairs in the speech sample.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param c_label a string to filter the consonants, e.g. `c_label = 'consonant'`
#' @param utterance_id column name for unique utterance IDs
#' @param cv_duration column name for the duration of C or V
#'
#' @return a data frame containing the mean rPVI for consonants
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 4),
#'                       utterance_id = rep(c("utt_1", "utt_2"), each = 4),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' rpvi_c(df_test, c_label="consonant", utterance_id, cv_duration)
#'
#' @export
rpvi_c <- function(df, c_label, utterance_id, cv_duration) {
  
  # 1. Filter for consonants and calculate rPVI per utterance
  rpvi_data <- df %>%
    dplyr::filter({{ cv_label }} == c_label) %>%
    dplyr::group_by({{ utterance_id }}) %>%
    dplyr::mutate(
      # Calculate absolute difference between consecutive intervals
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }}))
    ) %>%
    dplyr::summarise(
      # Count pairs (m-1)
      m_minus_1 = dplyr::n() - 1,
      # Sum of absolute differences divided by number of pairs
      rpvi_utt = sum(pair_diff, na.rm = TRUE) / m_minus_1,
      .groups = "drop"
    )

  # 2. Return the mean across all utterances
  result <- rpvi_data %>%
    dplyr::summarise(rpvi = mean(rpvi_utt, na.rm = TRUE))

  return(result)
}
