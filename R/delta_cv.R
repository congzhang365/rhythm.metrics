#' Delta C & Delta V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values and mean standard deviations of Delta C and Delta V.
#'
#' Delta C and Delta V are rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal. Cognition, 73(3), 265-292.
#'
#' `Delta C: SD of total C duration`
#' `Delta V: SD of total V duration`
#'
#' @author Cong Zhang, \email{cong.zhang@ru.nl}
#' @param
#' df: a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param
#' cv_label: whether a segment is a C(onsonant) or a V(owel)
#' @param
#' utterance_id: each unique utterance should have a unique id
#' @param
#' cv_duration: the duration of C or V
#'
#' @return
#' delta_cv: a data frame containing the results of Delta C and Delta V values
#' @examples
#' df <- data.frame (cv_label  = c("c", "v", "c", "v","c", "v", "c", "v"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' delta_cv(df, df$cv_label, df$utterance_id, df$cv_duration)
#'
#' @export
delta_cv <- function(df, cv_label, utterance_id, cv_duration) {
  delta_cv <- df %>%
    dplyr::group_by(cv_label, utterance_id) %>%
    dplyr::summarise(mean_d = sd(cv_duration, na.rm = T))

  delta_cv <- delta_cv %>%
    dplyr::group_by(cv_label) %>%
    dplyr::summarise(mean_delta = mean(mean_d, na.rm = T),
                     sd_delta = sd(mean_d, na.rm = T))

  delta_cv
}
