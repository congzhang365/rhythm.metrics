#' Plot Delta C & Delta V
#'
#' This function loads a dataframe as input and returns a box plot for Delta C and Delta V values.
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
#' @param
#' save_fig: the default value is set to `FALSE`. Change to `TRUE` to save the plot.
#' @param
#' fig_path: the default value is set to `NULL`. If `save_fig` is set to `TRUE`, the path to save the figure is needed.
#'
#' @return
#' A boxplot for Delta C and Delta V values.
#' @examples
#' df <- data.frame (cv_label  = c("c", "v", "c", "v","c", "v", "c", "v"),
#'                   utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
#'                                    "utt_1", "utt_1", "utt_2", "utt_2"),
#'                   cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))
#'
#' # Saving the plot
#' plot_delta_cv(df=data, cv_label, utterance_id, cv_duration, save_fig=T, fig_path='C:/Users/congzhang/Desktop/')
#' # Not saving the plot
#' plot_delta_cv(df=data, cv_label, utterance_id, cv_duration, save_fig=F)
#'
#' @export
plot_delta_cv <- function(df, cv_label, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
  plot_df <- df %>%
    dplyr::group_by(cv_label,utterance_id) %>%
    dplyr::summarise(mean_d = sd(cv_duration, na.rm = T))

  plot <- ggplot2::ggplot(plot_df,
                          aes(x=cv_label,
                              y=plot_df$mean_d,
                              fill=plot_df$cv_label)) +
    ggplot2::geom_boxplot() +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y= 'Δ C / Δ V', x = 'Segment Type', fill = 'Segment Type') +
    ggplot2::theme(legend.position = "top")
  # geom_text(data=df, aes(label=round(mean_delta, 1)),
  # size=2, position=position_dodge(width=0.8))
  if (save_fig==TRUE){
    plot
    ggplot2::ggsave(paste0(fig_path, '/delta_cv.png'))
    plot
  } else{
    plot
  }
}
