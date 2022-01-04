#' nPVI V
#'
#' This function loads a dataframe as input and returns a dataframe containing the mean values of nPVI of vowels
#'
#' nPVI V is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
#' It calculates the normalised sum of the absolute differences between pairs of consecutive vocalic intervals divided by the number of pairs in the speech sample.
#'
#' @author Cong Zhang, \email{cong.zhang@ru.nl}
#' @param
#' df: a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param
#' v_label: a string to filter the vowels, e.g. `v_label = 'V'` or `v_label = 'vowel'`
#' @param
#' utterance_id: each unique utterance should have a unique id
#' @param
#' cv_duration: the duration of C or V (only the values for vowels will be used)
#'
#' @return
#' npvi_v: a data frame containing the mean values of npvi for vowels
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#' utterance_id = c("utt_1", "utt_1", "utt_1", "utt_1",
#'                  "utt_2", "utt_2", "utt_2", "utt_2",
#'                  "utt_3", "utt_3", "utt_3", "utt_3",
#'                  "utt_4", "utt_4", "utt_4", "utt_4"),
#' cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7,
#'                 0.3, 0.88, 0.5, 0.9, 0.3, 0.57, 0.4, 0.97))
#'
#' npvi_v(df, v_label="vowel", utterance_id, cv_duration)
#'
#' @export
npvi_v <- function(df, v_label, utterance_id, cv_duration) {
  library(dplyr)

  npvi_v_pair <- df %>%
    dplyr::filter(cv_label==v_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(pairs=n()-1)

  npvi_v_sum1 <- df %>%
    dplyr::filter(cv_label==v_label) %>%
    dplyr::select(utterance_id, cv_label, cv_duration) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::mutate(npvi_sum = cv_duration + lag(cv_duration),
           seq = row_number() - 1)

  npvi_v_sum2 <- npvi_v_sum1 %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(sum = sum(npvi_sum, na.rm = T)/2)

  npvi_v_diff1 <- df %>%
    dplyr::filter(cv_label==v_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::mutate(diff = cv_duration - lag(cv_duration))

  npvi_v_diff2 <- npvi_v_diff1 %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(diff = sum(diff, na.rm = T))

  npvi_v1 <- left_join(npvi_v_diff2, npvi_v_pair, by=c('utterance_id', 'cv_label'))
  npvi_v2 <- left_join(npvi_v1, npvi_v_sum2, by=c('utterance_id', 'cv_label'))
  npvi_v3 <- npvi_v2 %>%
    dplyr::summarise(npvi_v=(abs(diff)/sum/pairs)*100)

  npvi_v <- npvi_v3 %>%
    dplyr::summarise(npvi=mean(npvi_v, na.rm=T))
  npvi_v
}
