#' Plot nPVI V
#'
#' This function loads a dataframe as input and returns a box plot for nPVI V values.
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
#' A boxplot for nPVI V values.
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' # Saving the plot
#' plot_npvi(df, c_label="vowel", utterance_id, cv_duration, save_fig=T, fig_path='C:/Users/congzhang/Desktop/')
#' # Not saving the plot
#' plot_npvi(df, c_label="vowel", utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL)
#'
#' @export
plot_npvi <- function(df, v_label, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
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
    dplyr::mutate(npvi_v=(abs(diff)/sum/pairs)*100)

  plot <- ggplot2::ggplot(npvi_v3,
                          aes(x=cv_label,
                              y=npvi_v,
                              fill=cv_label)) +
    ggplot2::geom_boxplot(show.legend = F) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y= 'nPVI-V', x = 'Vowel')

  if (save_fig==TRUE){
    plot
    ggplot2::ggsave(paste0(fig_path, '/npvi_v.png'))
    plot
  } else{
    plot
  }
}

