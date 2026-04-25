#' Varco C & Varco V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of Varco C and Varco V.
#'
#' Varco C and Varco V are rhythm metrics based on Dellwo, Volker (2006). Rhythm and Speech Rate: A Variation Coefficient for deltaC. In: Karnowski, P; Szigeti, I. Language and language-processing. Frankfurt/Main: Peter Lang, 231-241.
#'
#' `Varco C: Delta C / mean(C duration) * 100`
#' `Varco V: Delta V / mean(V duration) * 100`
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name indicating whether a segment is a C(onsonant) or a V(owel).
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#'
#' @return a data frame containing the results of Varco C and Varco V values.
#' @examples
#' df_test <- data.frame(cv_label = c("c", "v", "c", "v","c", "v", "c", "v"),
#'                       utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                        "utt_3", "utt_3", "utt_4", "utt_4"),
#'                       cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' varco_cv(df_test, cv_label, utterance_id, cv_duration)
#'
#' @export
varco_cv <- function(df, cv_label, utterance_id, cv_duration) {
  
  # 1. Calculate Varco per utterance per category (C/V)
  varco_data <- df %>%
    dplyr::group_by({{ cv_label }}, {{ utterance_id }}) %>%
    dplyr::summarise(
      # Varco = (SD / Mean) * 100
      cv_val = (stats::sd({{ cv_duration }}, na.rm = TRUE) / 
                mean({{ cv_duration }}, na.rm = TRUE)) * 100,
      .groups = "drop"
    )

  # 2. Return the mean across all utterances
  result <- varco_data %>%
    dplyr::group_by({{ cv_label }}) %>%
    dplyr::summarise(
      varco_cv = mean(cv_val, na.rm = TRUE),
      .groups = "drop"
    )
    
  return(result)
}
