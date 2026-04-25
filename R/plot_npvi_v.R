#' Plot nPVI V
#'
#' This function loads a dataframe as input and returns a box plot for nPVI V values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name for the segment labels (e.g., cv_label).
#' @param label_name a string to filter the vowels, e.g. `label_name = 'vowel'`.
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for nPVI V values.
#' @examples
#' # plot_npvi(df, cv_label = cv_label, label_name = "vowel", 
#' #           utterance_id = utterance_id, cv_duration = cv_duration)
#'
#' @export
plot_npvi <- function(df, cv_label, label_name, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
  
  # 1. Calculate nPVI per utterance
  plot_df <- df %>%
    dplyr::filter({{ cv_label }} == label_name) %>%
    dplyr::group_by({{ utterance_id }}, {{ cv_label }}) %>%
    dplyr::mutate(
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }})),
      pair_mean = ({{ cv_duration }} + dplyr::lead({{ cv_duration }})) / 2,
      pair_norm = pair_diff / pair_mean
    ) %>%
    dplyr::summarise(
      npvi_val = (sum(pair_norm, na.rm = TRUE) / (dplyr::n() - 1)) * 100,
      .groups = "drop"
    )

  # 2. Create the plot
  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, 
                                       y = .data$npvi_val, 
                                       fill = {{ cv_label }})) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = 'nPVI-V Value', x = 'Segment Type') +
    ggplot2::theme_minimal()

  # 3. Save and Return logic
  if (save_fig) {
    if (is.null(fig_path)) {
      stop("You must provide a 'fig_path' to save the figure.")
    }
    full_path <- file.path(fig_path, "npvi_v.png")
    ggplot2::ggsave(full_path, plot = plot, width = 6, height = 4)
  }

  return(plot)
}
