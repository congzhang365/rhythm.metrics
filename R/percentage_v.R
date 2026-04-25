#' Percentage V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values and mean standard deviations of %V.
#'
#' %V is a rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal. Cognition, 73(3), 265-292. It calculates the ratio of vocalic material to the total duration of an utterance.
#'
#' `% V: total V duration / total utterance duration`
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, cv_duration, and utterance_duration values.
#' @param v_label a string to filter the vowels, e.g. `v_label = 'vowel'`
#' @param utterance_id column name for unique utterance IDs
#' @param cv_duration column name for the duration of C or V
#' @param utterance_duration column name for the duration of entire utterances
#'
#' @return a data frame containing the mean values and standard deviation of %V
#' @examples
#' df_test <- data.frame(cv_label = c("consonant", "vowel", "consonant", "vowel"),
#'                       utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2"),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5),
#'                       utterance_duration = c(2.4, 2.4, 2.7, 2.7))
#'
#' percentage_v(df_test, v_label="vowel", utterance_id, cv_duration, utterance_duration)
#'
#' @export
percentage_v <- function(df, v_label, utterance_id, cv_duration, utterance_duration) {
  
  # 1. Calculate total vowel duration per utterance
  v_sum <- df %>%
    dplyr::filter(cv_label == v_label) %>%
    dplyr::group_by({{ utterance_id }}, cv_label) %>%
    dplyr::summarise(v_total = sum({{ cv_duration }}, na.rm = TRUE), .groups = "drop")

  # 2. Get unique utterance durations (distinct to avoid row duplication)
  utt_dur <- df %>%
    dplyr::select({{ utterance_id }}, {{ utterance_duration }}) %>%
    dplyr::distinct()

  # 3. Join and calculate %V
  percent_v_data <- dplyr::left_join(v_sum, utt_dur, by = rlang::as_label(rlang::enquo(utterance_id))) %>%
    dplyr::mutate(percent_v = v_total / {{ utterance_duration }})

  # 4. Final Summary
  result <- percent_v_data %>%
    dplyr::group_by(cv_label) %>%
    dplyr::summarise(
      mean_percent_v = mean(percent_v, na.rm = TRUE),
      sd_percent_v = stats::sd(percent_v, na.rm = TRUE),
      .groups = "drop"
    )

  return(result)
}
