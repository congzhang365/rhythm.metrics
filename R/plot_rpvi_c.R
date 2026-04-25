#' Plot rPVI C
#'
#' This function loads a dataframe as input and returns a box plot for rPVI C values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name for the segment labels (e.g., cv_label).
#' @param label_name a string to filter the segments, e.g. `label_name = 'consonant'`.
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for rPVI values.
#' @examples
#' # plot_rpvi(df, cv_label = cv_label, label_name = "consonant", 
#' #           utterance_id = utterance_id, cv_duration = cv_duration)
#'
#' @export
plot_rpvi <- function(df, cv_label, label_name, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
  
  plot_df <- df %>%
    dplyr::filter({{ cv_label }} == label_name) %>%
    dplyr::group_by({{ utterance_id }}, {{ cv_label }}) %>%
    dplyr::mutate(pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }}))) %>%
    dplyr::summarise(
      rpvi_val = sum(pair_diff, na.rm = TRUE) / (dplyr::n() - 1),
      .groups = "drop"
    )

  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, y = .data$rpvi_val, fill = {{ cv_label }})) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = 'rPVI Value', x = 'Segment Type') +
    ggplot2::theme_minimal()

  if (save_fig) {
    if (is.null(fig_path)) stop("Provide 'fig_path' to save.")
    ggplot2::ggsave(file.path(fig_path, "rpvi_c.png"), plot = plot, width = 6, height = 4)
  }

  return(plot)
}
