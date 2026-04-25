#' Plot rPVI C
#'
#' This function loads a dataframe as input and returns a box plot for rPVI C values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param c_label a string to filter the consonants, e.g. `c_label = 'consonant'`
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for rPVI C values.
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 10),
#'                       utterance_id = rep(paste0("utt_", 1:10), each = 2),
#'                       cv_duration = runif(20, 0.1, 0.5))
#'
#' # Not saving the plot
#' plot_rpvi(df_test, c_label="consonant", utterance_id, cv_duration, save_fig=FALSE)
#'
#' @export
plot_rpvi <- function(df, c_label, utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL) {
  
  # 1. Calculate rPVI per utterance
  plot_df <- df %>%
    dplyr::filter({{ cv_label }} == c_label) %>%
    dplyr::group_by({{ utterance_id }}, {{ cv_label }}) %>%
    dplyr::mutate(
      pair_diff = abs({{ cv_duration }} - dplyr::lead({{ cv_duration }}))
    ) %>%
    dplyr::summarise(
      rpvi_val = sum(pair_diff, na.rm = TRUE) / (dplyr::n() - 1),
      .groups = "drop"
    )

  # 2. Create the plot
  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, 
                                       y = .data$rpvi_val, 
                                       fill = {{ cv_label }})) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = 'rPVI-C Value', x = 'Segment Type') +
    ggplot2::theme_minimal()

  # 3. Save and Return logic
  if (save_fig) {
    if (is.null(fig_path)) {
      stop("You must provide a 'fig_path' to save the figure.")
    }
    full_path <- file.path(fig_path, "rpvi_c.png")
    ggplot2::ggsave(full_path, plot = plot, width = 6, height = 4)
  }

  return(plot)
}
