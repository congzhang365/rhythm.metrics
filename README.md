# rhythm.metrics
### Author: Cong Zhang  

The `rhythm.metrics` package is designed for calculating and visualising speech rhythm metrics. This package provides the calculation of Delta C / Delta V, VarcoC / VarcoV, %V, rPVI_C, nPVI_V. More metrics will be added in the future.

### Citation  

Zhang, C. (2022). A Guide for the R Package "rhythm_metrics". Retrieved from https://osf.io/kfnzt/. 

```
@article{zhang2022,
  title={A Guide for the R Package "rhythm_metrics"},
  author={Zhang, Cong},
  url={https://osf.io/kfnzt/},
  year={2022}
 }
```

## List of Functions 

### Calculations
+ delta_cv
+ varco_cv
+ percentage_v
+ rpvi_c 
+ npvi_v

### Plotting
+ plot_delta_cv
+ plot_npvi        
+ plot_percentage_v
+ plot_rpvi
+ plot_varco_cv
 
 
## Installation
```
install.packages("devtools")
devtools::install_github("congzhang365/rhythm.metrics")
```

## Import packages
```
library(rhythm.metrics)
library(dplyr)
```

## Examples

### Create dataframe

```
df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel"),
                  utterance_id = c("utt_1", "utt_1", "utt_1", "utt_1",
                                   "utt_2", "utt_2", "utt_2", "utt_2",
                                   "utt_3", "utt_3", "utt_3", "utt_3",
                                   "utt_4", "utt_4", "utt_4", "utt_4"),
                  cv_duration = c(0.1, 0.8, 0.2, 0.5, 
                                  0.3, 0.3, 0.4, 0.7,
                                  0.3, 0.88, 0.5, 0.9, 
                                  0.3, 0.57, 0.4, 0.97),
                  utterance_duration = c(2.4, 2.4, 2.4, 2.4,
                                         2.7, 2.7, 2.7, 2.7,
                                         3.4, 3.4, 3.4, 3.4,
                                         1.8, 1.8, 1.8, 1.8))
```


### delta_cv

Delta C and Delta V are rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal. Cognition, 73(3), 265-292.

`Delta C: SD of total C duration`  
`Delta V: SD of total V duration`


```
delta_cv(df, cv_label, utterance_id, cv_duration)
```


```
plot_delta_cv(df, cv_label, utterance_id, cv_duration)
```


### varco_cv

Varco C and Varco V are rhythm metrics based on Dellwo, Volker (2006). Rhythm and Speech Rate: A Variation Coefficient for deltaC. In: Karnowski, P; Szigeti, I. Language and language-processing. Frankfurt/Main: Peter Lang, 231-241.

`Varco C: Delta C / mean(C duration) * 100`  
`Varco V: Delta V / mean(V duration) * 100`


```
varco_cv(df)
```


```
plot_varco_cv(df, cv_label, utterance_id, cv_duration)
```


### percentage_v

%V is a rhythm metrics based on Ramus, F., Nespor, M., & Mehler, J. (1999). Correlates of linguistic rhythm in the speech signal. Cognition, 73(3), 265-292. It calculates the ratio of vocalic material to the total duration of an utterance.

`% V: total V duration / total utterance duration`


```
percentage_v(df, v_label="vowel")
```


```
plot_percentage_v(df, v_label="vowel", utterance_id, cv_duration)
```


### rpvi_c

rPVI C is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.

It calculates the sum of the absolute differences between pairs of consecutive consonantal intervals divided by the number of pairs in the speech sample.


```
rpvi_c(df, c_label="consonant")
```


```
plot_rpvi(df, c_label="consonant", utterance_id, cv_duration)

```


### npvi_v

nPVI V is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.

It calculates the normalised sum of the absolute differences between pairs of consecutive vocalic intervals divided by the number of pairs in the speech sample.


```
npvi_v(df, v_label="vowel")
```


```
plot_npvi(df, v_label="vowel", utterance_id, cv_duration)

```