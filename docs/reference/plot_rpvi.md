# Plot rPVI C

This function loads a dataframe as input and returns a box plot for rPVI
C values.

## Usage

``` r
plot_rpvi(
  df,
  cv_label,
  label_name,
  utterance_id,
  cv_duration,
  save_fig = FALSE,
  fig_path = NULL
)
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, and cv_duration
  values.

- cv_label:

  column name for the segment labels (e.g., cv_label).

- label_name:

  a string to filter the segments, e.g. `label_name = 'consonant'`.

- utterance_id:

  column name for unique utterance IDs.

- cv_duration:

  column name for the duration of C or V.

- save_fig:

  default is `FALSE`. Change to `TRUE` to save the plot.

- fig_path:

  default is `NULL`. Required if `save_fig = TRUE`.

## Value

A boxplot for rPVI values.

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(
  cv_label = rep(c("consonant", "vowel"), 8),
  utterance_id = rep(paste0("utt_", 1:4), each = 4),
  cv_duration = c(
    0.10, 0.80, 0.20, 0.50,
    0.30, 0.30, 0.40, 0.70,
    0.30, 0.88, 0.50, 0.90,
    0.30, 0.57, 0.40, 0.97
  )
)

plot_rpvi(
  df_test,
  cv_label = cv_label,
  label_name = "consonant",
  utterance_id = utterance_id,
  cv_duration = cv_duration
)

```
