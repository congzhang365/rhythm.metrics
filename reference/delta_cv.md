# Delta C & Delta V

This function loads a dataframe as input and returns a dataframe
containing the mean values and mean standard deviations of Delta C and
Delta V.

## Usage

``` r
delta_cv(df, cv_label, utterance_id, cv_duration)
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, and cv_duration
  values.

- cv_label:

  the column name for whether a segment is a C(onsonant) or a V(owel)

- utterance_id:

  the column name where each unique utterance has a unique id

- cv_duration:

  the column name for the duration of C or V

## Value

a data frame containing the results of Delta C and Delta V values

## Details

Delta C and Delta V are rhythm metrics based on Ramus, F., Nespor, M., &
Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal.
Cognition, 73(3), 265-292.

`Delta C: SD of total C duration` `Delta V: SD of total V duration`

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(cv_label  = c("c", "v", "c", "v","c", "v", "c", "v"),
                      utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
                                       "utt_1", "utt_1", "utt_2", "utt_2"),
                      cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))

delta_cv(df_test, cv_label, utterance_id, cv_duration)
#> # A tibble: 2 × 3
#>   cv_label mean_delta sd_delta
#>   <chr>         <dbl>    <dbl>
#> 1 c             0.141 2.78e-17
#> 2 v             0.247 1.5 e- 1
```
