#' Plot rPVI C
#'
#' This function loads a dataframe as input and returns a box plot for rPVI C values.
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
#' A boxplot for rPVI C values.
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' # Saving the plot
#' plot_rpvi(df, c_label="consonant", utterance_id, cv_duration, save_fig=T, fig_path='C:/Users/congzhang/Desktop/')
#' # Not saving the plot
#' plot_rpvi(df, c_label="consonant", utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL)
#'
#' @export
plot_rpvi <- function(df, c_label, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
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
    dplyr::mutate(rpvi_c=abs(diff)/pairs)

  plot <- ggplot2::ggplot(rpvi_c2,
                          aes(x=cv_label,
                              y=rpvi_c,
                              fill=cv_label)) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y= 'rPVI-C', x = 'Consonant')

  if (save_fig==TRUE){
    plot
    ggplot2::ggsave(paste0(fig_path, '/rpvi_c.png'))
    plot
  } else{
    plot
  }

}
