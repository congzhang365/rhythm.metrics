#' nPVI V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of nPVI of vowels.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name for the segment labels (e.g., cv_label).
#' @param label_name a string to filter the vowels, e.g. `label_name = 'vowel'`.
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#'
#' @return a data frame containing the mean nPVI for vowels.
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 8),
#'                       utterance_id = rep(c("utt_1", "utt_2", "utt_3", "utt_4"), each = 4),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7,
#'                                        0.3, 0.88, 0.5, 0.9, 0.3, 0.57, 0.4, 0.97))
#'
#' npvi_v(df_test, cv_label = cv_label, label_name = "vowel", 
#'        utterance_id = utterance_id, cv_duration = cv_duration)
#'
#' @export
npvi_v <- function(df, cv_label, label_name, utterance_id, cv_duration) {
  
  # 1. Filter for vowels and calculate nPVI per utterance
  npvi_data <- df %>%
    dplyr::filter({{ cv_label }} == label_name) %>%
    dplyr::group_by({{ utterance_id }}) %>%
    dplyr::mutate(
      # Calculate |(d1 - d2) / ((d1 + d2) / 2)| for each pair
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }})),
      pair_mean = ({{ cv_duration }} + dplyr::lead({{ cv_duration }})) / 2,
      pair_norm = pair_diff / pair_mean
    ) %>%
    dplyr::summarise(
      m_minus_1 = dplyr::n() - 1,
      npvi_utt = (sum(pair_norm, na.rm = TRUE) / m_minus_1) * 100,
      .groups = "drop"
    )

  # 2. Return the mean across all utterances
  result <- npvi_data %>%
    dplyr::summarise(npvi = mean(npvi_utt, na.rm = TRUE))

  return(result)
}
