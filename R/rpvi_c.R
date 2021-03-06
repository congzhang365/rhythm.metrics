#' rPVI C
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of rPVI of consonants.
#'
#' rPVI C is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
#' It calculates the sum of the absolute differences between pairs of consecutive consonantal intervals divided by the number of pairs in the speech sample.
#'
#' @author Cong Zhang, \email{cong.zhang@ru.nl}
#' @param
#' df: a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param
#' c_label: a string to filter the consonants, e.g. `c_label = 'C'` or `c_label = 'consonant'`
#' @param
#' utterance_id: each unique utterance should have a unique id
#' @param
#' cv_duration: the duration of C or V (only the values for vowels will be used)
#'
#' @return
#' rpvi_c: a data frame containing the mean values of rpvi for consonants
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' rpvi_c(df, c_label="consonant", utterance_id, cv_duration)
#'
#' @export
rpvi_c <- function(df, c_label, utterance_id, cv_duration) {
  rpvi_c_pair <- df %>%
    dplyr::filter(cv_label==c_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(pairs=n()-1)

  rpvi_c_diff1 <- df %>%
    dplyr::filter(cv_label==c_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::mutate(diff = cv_duration - lag(cv_duration))

  rpvi_c_diff2 <- rpvi_c_diff1 %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(diff = sum(diff, na.rm = T))

  rpvi_c1 <- left_join(rpvi_c_diff2, rpvi_c_pair, by=c('utterance_id', 'cv_label'))

  rpvi_c2 <- rpvi_c1 %>%
    dplyr::summarise(rpvi_c=abs(diff)/pairs)

  rpvi_c <- rpvi_c2 %>%
    dplyr::summarise(rpvi=mean(rpvi_c, na.rm=T))
  rpvi_c
}
