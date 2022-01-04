#' Plot Percentage V
#'
#' This function loads a dataframe as input and returns a box plot for %V values.
#'
#' @author Cong Zhang, \email{cong.zhang@ru.nl}
#' @param
#' df: a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param
#' v_label: a string to filter the vowels, e.g. `v_label = 'V'` or `v_label = 'vowel'`
#' @param
#' utterance_id: each unique utterance should have a unique id
#' @param
#' cv_duration: the duration of C or V
#' @param
#' save_fig: the default value is set to `FALSE`. Change to `TRUE` to save the plot.
#' @param
#' fig_path: the default value is set to `NULL`. If `save_fig` is set to `TRUE`, the path to save the figure is needed.
#'
#' @return
#' A boxplot for %V values.
#' @examples
#' df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
#'                                 "consonant", "vowel", "consonant", "vowel"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7),
#'                   utterance_duration = c(2.4, 2.4, 2.7, 2.7, 2.4, 2.4, 2.7, 2.7))
#'
#' # Saving the plot
#' plot_percentage_v(df, v_label="vowel", utterance_id, cv_duration, save_fig=T, fig_path='C:/Users/congzhang/Desktop/')
#' # Not saving the plot
#' plot_percentage_v(df, v_label="vowel", utterance_id, cv_duration, save_fig=FALSE)
#'
#' @export
plot_percentage_v <- function(df, v_label, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
  plot_df <- df %>%
    dplyr::filter(cv_label==v_label) %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(v = sum(cv_duration_ms, na.rm = T))

  utt_dur <- df %>%
    dplyr::select(utterance_id, utterance_duration_ms)

  plot_df <- left_join(plot_df, utt_dur)
  plot_df <- plot_df %>%
    dplyr::group_by(utterance_id, cv_label) %>%
    dplyr::summarise(percent_v = v/utterance_duration_ms)

  plot <- ggplot2::ggplot(plot_df,
                          aes(x=plot_df$cv_label,
                              y=percent_v,
                              fill=plot_df$cv_label)) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y= '%V', x = 'Vowel')

  if (save_fig==TRUE){
    plot
    ggplot2::ggsave(paste0(fig_path, '/percent_v.png'))
    plot
  } else{
    plot
  }
}


