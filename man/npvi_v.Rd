% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/npvi_v.R
\name{npvi_v}
\alias{npvi_v}
\title{nPVI V}
\usage{
npvi_v(df, v_label, utterance_id, cv_duration)
}
\arguments{
\item{df:}{a data frame containing cv_labels, utterance_id, and cv_duration values.}

\item{v_label:}{a string to filter the vowels, e.g. \code{v_label = 'V'} or \code{v_label = 'vowel'}}

\item{utterance_id:}{each unique utterance should have a unique id}

\item{cv_duration:}{the duration of C or V (only the values for vowels will be used)}
}
\value{
npvi_v: a data frame containing the mean values of npvi for vowels
}
\description{
This function loads a dataframe as input and returns a dataframe containing the mean values of nPVI of vowels
}
\details{
nPVI V is a rhythm metrics based on Grabe, E., & Low, E. L. (2002). Durational variability in speech and the rhythm class hypothesis. In Laboratory phonology 7 (pp. 515-546). De Gruyter Mouton.
It calculates the normalised sum of the absolute differences between pairs of consecutive vocalic intervals divided by the number of pairs in the speech sample.
}
\examples{
df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel"),
utterance_id = c("utt_1", "utt_1", "utt_1", "utt_1",
                 "utt_2", "utt_2", "utt_2", "utt_2",
                 "utt_3", "utt_3", "utt_3", "utt_3",
                 "utt_4", "utt_4", "utt_4", "utt_4"),
cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7,
                0.3, 0.88, 0.5, 0.9, 0.3, 0.57, 0.4, 0.97))

npvi_v(df, v_label="vowel", utterance_id, cv_duration)

}
\author{
Cong Zhang, \email{cong.zhang@ru.nl}
}
