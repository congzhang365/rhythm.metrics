# nPVI V

This function loads a dataframe as input and returns a dataframe
containing the mean values of nPVI of vowels.

## Usage

``` r
npvi_v(df, cv_label, label_name, utterance_id, cv_duration)
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, and cv_duration
  values.

- cv_label:

  column name for the segment labels (e.g., cv_label).

- label_name:

  a string to filter the vowels, e.g. `label_name = 'vowel'`.

- utterance_id:

  column name for unique utterance IDs.

- cv_duration:

  column name for the duration of C or V.

## Value

a data frame containing the mean nPVI for vowels.

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 8),
                      utterance_id = rep(c("utt_1", "utt_2", "utt_3", "utt_4"), each = 4),
                      cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7,
                                       0.3, 0.88, 0.5, 0.9, 0.3, 0.57, 0.4, 0.97))

npvi_v(df_test, cv_label = cv_label, label_name = "vowel",
       utterance_id = utterance_id, cv_duration = cv_duration)
#> # A tibble: 1 × 1
#>    npvi
#>   <dbl>
#> 1  45.1
```
