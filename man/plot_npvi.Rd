% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_npvi_v.R
\name{plot_npvi}
\alias{plot_npvi}
\title{Plot nPVI V}
\usage{
plot_npvi(
  df,
  v_label,
  utterance_id,
  cv_duration,
  save_fig = FALSE,
  fig_path = NULL
)
}
\arguments{
\item{df:}{a data frame containing cv_labels, utterance_id, and cv_duration values.}

\item{v_label:}{a string to filter the vowels, e.g. \code{v_label = 'V'} or \code{v_label = 'vowel'}}

\item{utterance_id:}{each unique utterance should have a unique id}

\item{cv_duration:}{the duration of C or V (only the values for vowels will be used)}
}
\value{
A boxplot for nPVI V values.
}
\description{
This function loads a dataframe as input and returns a box plot for nPVI V values.
}
\examples{
df <- data.frame (cv_label  = c("consonant", "vowel", "consonant", "vowel",
                                "consonant", "vowel", "consonant", "vowel"),
                  utterance_id = c("utt_1", "utt_1", "utt_2", "utt_2",
                                   "utt_1", "utt_1", "utt_2", "utt_2"),
                  cv_duration = c(0.1, 0.8, 0.2, 0.5, 0.3, 0.3, 0.4, 0.7))

# Saving the plot
plot_npvi(df, c_label="vowel", utterance_id, cv_duration, save_fig=T, fig_path='C:/Users/congzhang/Desktop/')

# Not saving the plot
plot_npvi(df, c_label="vowel", utterance_id, cv_duration, save_fig=FALSE, fig_path=NULL)

}
\author{
Cong Zhang, \email{cong.zhang@ru.nl}
}
