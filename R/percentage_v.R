#' Percentage V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values and mean standard deviations of %V.
#'
#' %V is a rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal. Cognition, 73(3), 265-292. It calculates the ratio of vocalic material to the total duration of an utterance.
#'
#' `% V: total V duration / total utterance duration`
#'
#' @author Cong Zhang, \email{cong.zhang@ru.nl}
#' @param
#' df: a data frame containing cv_labels, utterance_id, cv_duration, and utterance_duration values.
#' @param
#' v_label: a string to filter the vowels, e.g. `v_label = 'V'` or `v_label = 'vowel'`
#' @param
#' utterance_id: each unique utterance should have a unique id
#' @param
#' cv_duration: the duration of C or V (only the values for vowels will be used)
#' @param
#' utterance_duration: the duration of entire utterances
#'
#' @return
#' percent_v: a data frame containing the mean values and standard deviation of %
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7),
#'                   utterance_duration = c(2.4, 2.4, 2.7, 2.7, 2.4, 2.4, 2.7, 2.7))
#'
#' percentage_v(df, v_label="vowel", utterance_id, cv_duration, utterance_duration)
#'
#' @export
percentage_v <- function(df, v_label, utterance_id, cv_duration, utterance_duration) {
  percent_v_1 <- df %>%
    dplyr::filter(cv_label==v_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(v = sum(cv_duration, na.rm = T))
  utt_dur <- df %>%
    dplyr::select(utterance_id, utterance_duration)

  percent_v_1 <- left_join(percent_v_1, utt_dur)
  percent_v_1 <- percent_v_1 %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(percent_v = v/utterance_duration)

  percent_v <- percent_v_1 %>%
    dplyr::group_by(cv_label) %>%
    dplyr::summarise(mean_percent_v = mean(percent_v, na.rm = T),
              sd_pecent_v = sd(percent_v, na.rm = T))
  percent_v
}

