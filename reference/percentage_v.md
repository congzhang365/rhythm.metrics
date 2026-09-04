# Percentage V

This function loads a dataframe as input and returns a dataframe
containing the mean values and mean standard deviations of %V.

## Usage

``` r
percentage_v(df, v_label, utterance_id, cv_duration, utterance_duration)
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, cv_duration, and
  utterance_duration values.

- v_label:

  a string to filter the vowels, e.g. `v_label = 'vowel'`

- utterance_id:

  column name for unique utterance IDs

- cv_duration:

  column name for the duration of C or V

- utterance_duration:

  column name for the duration of entire utterances

## Value

a data frame containing the mean values and standard deviation of %V

## Details

%V is a rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J.
(1999). Correlates of linguistic rhythm in the speech signal. Cognition,
73(3), 265-292. It calculates the percentage of an utterance occupied by
vocalic material.

`%V: (total V duration / total utterance duration) * 100`

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(cv_label = c("consonant", "vowel", "consonant", "vowel"),
                      utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2"),
                      cv_duration = c(0.1, 0.8, 0.2, 0.5),
                      utterance_duration = c(2.4, 2.4, 2.7, 2.7))

percentage_v(df_test, v_label="vowel", utterance_id, cv_duration, utterance_duration)
#> # A tibble: 1 × 3
#>   cv_label mean_percent_v sd_percent_v
#>   <chr>             <dbl>        <dbl>
#> 1 vowel              25.9         10.5
```
