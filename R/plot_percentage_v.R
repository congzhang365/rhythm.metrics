#' Plot Percentage V
#'
#' This function loads a dataframe as input and returns a box plot for %V values.
#'
#' @author Cong Zhang, \email{cong.zhang@newcastle.ac.uk}
#' @param df a data frame containing cv_labels, utterance_id, cv_duration, and utterance_duration values.
#' @param v_label a string to filter the vowels, e.g. `v_label = 'vowel'`
#' @param utterance_id column name for unique utterance IDs.
#' @param cv_duration column name for the duration of C or V.
#' @param utterance_duration column name for the duration of entire utterances.
#' @param save_fig default is `FALSE`. Change to `TRUE` to save the plot.
#' @param fig_path default is `NULL`. Required if `save_fig = TRUE`.
#'
#' @return A boxplot for %V values.
#' @examples
#' df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 10),
#'                       utterance_id = rep(paste0("utt_", 1:10), each = 2),
#'                       cv_duration = runif(20, 0.1, 0.8),
#'                       utterance_duration = rep(runif(10, 2, 3), each = 2))
#'
#' # Not saving the plot
#' plot_percentage_v(df_test, v_label="vowel", utterance_id, cv_duration, 
#'                   utterance_duration, save_fig = FALSE)
#'
#' @export
plot_percentage_v <- function(df, v_label, utterance_id, cv_duration, utterance_duration, save_fig=FALSE, fig_path=NULL) {
  
  # 1. Calculate %V per utterance
  # We use distinct() on the duration to avoid duplicates during the join
  v_sum <- df %>%
    dplyr::filter({{ cv_label }} == v_label) %>%
    dplyr::group_by({{ utterance_id }}, {{ cv_label }}) %>%
    dplyr::summarise(v_total = sum({{ cv_duration }}, na.rm = TRUE), .groups = "drop")

  utt_dur <- df %>%
    dplyr::select({{ utterance_id }}, {{ utterance_duration }}) %>%
    dplyr::distinct()

  plot_df <- dplyr::left_join(v_sum, utt_dur, by = rlang::as_label(rlang::enquo(utterance_id))) %>%
    dplyr::mutate(percent_v = v_total / {{ utterance_duration }})

  # 2. Create the plot
  plot <- ggplot2::ggplot(plot_df, 
                          ggplot2::aes(x = {{ cv_label }}, 
                                       y = .data$percent_v, 
                                       fill = {{ cv_label }})) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggsci::scale_fill_jco() +
    ggplot2::labs(y = '%V Value', x = 'Segment Type') +
    ggplot2::theme_minimal()

  # 3. Save and Return logic
  if (save_fig) {
    if (is.null(fig_path)) {
      stop("You must provide a 'fig_path' to save the figure.")
    }
    full_path <- file.path(fig_path, "percent_v.png")
    ggplot2::ggsave(full_path, plot = plot, width = 6, height = 4)
  }

  return(plot)
}
