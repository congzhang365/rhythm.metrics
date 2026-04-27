#' rPVI C
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of rPVI of consonants.
#'
#' rPVI C is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
#' It calculates the sum of the absolute differences between pairs of consecutive consonantal intervals divided by the number of pairs in the speech sample.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label the column name that contains the labels (consonant/vowel).
#' @param utterance_id column name for unique utterance IDs
#' @param cv_duration column name for the duration of C or V
#' @param label_name a string to filter the consonants, e.g. 'consonant'
#'
#' @return a data frame containing the mean rPVI for consonants
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 4),
#'                       utterance_id = rep(c("utt_1", "utt_2"), each = 4),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' rpvi_c(df_test, cv_label="consonant", utterance_id, cv_duration)
#'
#' @export
  rpvi_c <- function(df, cv_label, utterance_id, cv_duration, label_name = "consonant") {

  # Use label_name to distinguish the value from the column cv_label
  rpvi_data <- df %>%
    dplyr::filter({{ cv_label }} == label_name) %>%
    dplyr::group_by({{ utterance_id }}) %>%
    dplyr::mutate(
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }}))
    ) %>%
    dplyr::summarise(
      m_minus_1 = dplyr::n() - 1,
      rpvi_utt = sum(pair_diff, na.rm = TRUE) / m_minus_1,
      .groups = "drop"
    )

  result <- rpvi_data %>%
    dplyr::summarise(rpvi = mean(rpvi_utt, na.rm = TRUE))

  return(result)
}
