#' Plot Delta C & Delta V
#'
#' This function loads a dataframe as input and returns a box plot for Delta C and Delta V values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name for segment type (C or V).
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for Delta C and Delta V values.
#' @examples
#' df_test <- data.frame(cv_label = rep(c("c", "v"), 10),
#'                       utterance_id = rep(paste0("utt_", 1:10), each = 2),
#'                       cv_duration = runif(20, 0.05, 0.5))
#'
#' # Not saving the plot
#' plot_delta_cv(df_test, cv_label, utterance_id, cv_duration, save_fig = FALSE)
#'
#' @export
plot_delta_cv <- function(df, cv_label, utterance_id, cv_duration, save_fig = FALSE, fig_path = NULL) {
  
  # 1. Calculate Delta (SD) per utterance
  plot_df <- df %>%
    dplyr::group_by({{ cv_label }}, {{ utterance_id }}) %>%
    dplyr::summarise(
      mean_d = stats::sd({{ cv_duration }}, na.rm = TRUE),
      .groups = "drop"
    )

  # 2. Build the plot
  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, 
                                       y = .data$mean_d, 
                                       fill = {{ cv_label }})) +
    ggplot2::geom_boxplot() +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = expression(Delta * " value"), 
                  x = 'Segment Type', 
                  fill = 'Segment Type') +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "top")

  # 3. Saving logic
  if (save_fig) {
    if (is.null(fig_path)) {
      stop("You must provide a 'fig_path' to save the figure.")
    }
    full_path <- file.path(fig_path, "delta_cv.png")
    ggplot2::ggsave(full_path, plot = plot, width = 7, height = 5)
  }

  return(plot)
}
