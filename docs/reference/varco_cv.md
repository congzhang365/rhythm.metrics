# Varco C & Varco V

This function loads a dataframe as input and returns a dataframe
containing the mean values of Varco C and Varco V.

## Usage

``` r
varco_cv(df, cv_label, utterance_id, cv_duration)
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, and cv_duration
  values.

- cv_label:

  column name indicating whether a segment is a C(onsonant) or a
  V(owel).

- utterance_id:

  column name for unique utterance IDs.

- cv_duration:

  column name for the duration of C or V.

## Value

a data frame containing the results of Varco C and Varco V values.

## Details

Varco C and Varco V are rhythm metrics based on Dellwo, Volker (2006).
Rhythm and Speech Rate: A Variation Coefficient for deltaC. In:
Karnowski, P; Szigeti, I. Language and language-processing.
Frankfurt/Main: Peter Lang, 231-241.

`Varco C: Delta C / mean(C duration) * 100`
`Varco V: Delta V / mean(V duration) * 100`

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(cv_label = c("c", "v", "c", "v","c", "v", "c", "v"),
                      utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
                                       "utt_3", "utt_3", "utt_4", "utt_4"),
                      cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))

varco_cv(df_test, cv_label, utterance_id, cv_duration)
#> # A tibble: 2 × 2
#>   cv_label varco_cv
#>   <chr>       <dbl>
#> 1 c             NaN
#> 2 v             NaN
```
