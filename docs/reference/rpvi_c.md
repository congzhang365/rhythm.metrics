# rPVI C

This function loads a dataframe as input and returns a dataframe
containing the mean values of rPVI of consonants.

## Usage

``` r
rpvi_c(df, cv_label, utterance_id, cv_duration, label_name = "consonant")
```

## Arguments

- df:

  a data frame containing cv_labels, utterance_id, and cv_duration
  values.

- cv_label:

  the column name that contains the labels (consonant/vowel).

- utterance_id:

  column name for unique utterance IDs

- cv_duration:

  column name for the duration of C or V

- label_name:

  a string to filter the consonants, e.g. 'consonant'

## Value

a data frame containing the mean rPVI for consonants

## Details

rPVI C is a rhythm metrics based on Grabe, E., & Low, E. L. (2002).
Durational variability in speech and the rhythm class hypothesis. In
Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton. It calculates
the sum of the absolute differences between pairs of consecutive
consonantal intervals divided by the number of pairs in the speech
sample.

## Author

Cong Zhang, <cong.zhang@newcastle.ac.uk>

## Examples

``` r
df_test <- data.frame(cv_label = rep(c("consonant", "vowel"), 4),
                      utterance_id = rep(c("utt_1", "utt_2"), each = 4),
                      cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))

rpvi_c(
  df_test,
  cv_label = cv_label,
  utterance_id = utterance_id,
  cv_duration = cv_duration,
  label_name = "consonant"
)
#> # A tibble: 1 × 1
#>    rpvi
#>   <dbl>
#> 1   0.1
```
