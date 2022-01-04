#' Varco C & Varco V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of Varco C and Varco V.
#'
#' Varco C and Varco V are rhythm metrics based on Dellwo, Volker (2006). Rhythm and Speech Rate: A Variation Coefficient for deltaC. In: Karnowski, P; Szigeti, I. Language and language-processing. Frankfurt/Main: Peter Lang, 231-241.
#'
#' `Varco C: Delta C / mean(C duration) * 100`
#' `Varco V: Delta V / mean(V duration) * 100`
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
#' varco_cv: a data frame containing the results of Varco C and Varco V values
#' @examples
#' df <- data.frame (cv_label  = c("c", "v", "c", "v","c", "v", "c", "v"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' varco_cv(df, df$cv_label, df$utterance_id, df$cv_duration)
#'
#' @export
varco_cv <- function(df, cv_label, utterance_id, cv_duration) {
  varco_cv <- df %>%
    dplyr::group_by(cv_label, utterance_id) %>%
    dplyr::summarise(mean_var = sd(cv_duration, na.rm = T)/mean(cv_duration)*100)

  varco_cv <- varco_cv %>%
    dplyr::group_by(cv_label) %>%
    dplyr::summarise(varco_cv = mean(mean_var, na.rm = T))
  varco_cv
}

