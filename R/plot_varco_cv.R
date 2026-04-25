#' Plot Varco C & Varco V
#'
#' This function loads a dataframe as input and returns a box plot for Varco C and Varco V values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, and cv_duration values.
#' @param cv_label column name for segment type (C or V).
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for Varco C and Varco V values.
#' @examples
#' df_test <- data.frame(cv_label = rep(c("c", "v"), 10),
#'                       utterance_id = rep(paste0("utt_", 1:10), each = 2),
#'                       cv_duration = runif(20, 0.1, 0.8))
#'
#' # Not saving the plot
#' plot_varco_cv(df_test, cv_label, utterance_id, cv_duration, save_fig = FALSE)
#'
#' @export
plot_varco_cv <- function(df, cv_label, utterance_id, cv_duration, save_fig = FALSE, fig_path = NULL) {
  
  # 1. Calculate Varco per utterance
  plot_df <- df %>%
    dplyr::group_by({{ cv_label }}, {{ utterance_id }}) %>%
    dplyr::summarise(
      mean_var = (stats::sd({{ cv_duration }}, na.rm = TRUE) / 
                  mean({{ cv_duration }}, na.rm = TRUE)) * 100,
      .groups = "drop"
    )

  # 2. Build the plot
  # We use the curly-curly {{ }} inside aes() via tidy evaluation
  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, 
                                       y = .data$mean_var, 
                                       fill = {{ cv_label }})) +
    ggplot2::geom_boxplot() +
    # Ensure ggsci is in your DESCRIPTION/NAMESPACE if using jco
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = 'Varco value', x = 'Segment Type', fill = 'Segment Type') +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "top")

  # 3. Saving logic
  if (save_fig) {
    if (is.null(fig_path)) {
      stop("You must provide a 'fig_path' to save the figure.")
    }
    # Ensure file path is constructed correctly
    full_path <- file.path(fig_path, "varco_cv.png")
    ggplot2::ggsave(full_path, plot = plot, width = 7, height = 5)
  }

  return(plot)
}
