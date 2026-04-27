test_that("Visualisation functions return ggplot objects", {
  df_test <- data.frame(
    cv_label = rep(c("consonant", "vowel"), 8),
    utterance_id = rep(paste0("utt_", 1:4), each = 4),
    cv_duration = c(0.10, 0.80, 0.20, 0.50, 0.30, 0.30, 0.40, 0.70, 
                    0.30, 0.88, 0.50, 0.90, 0.30, 0.57, 0.40, 0.97),
    utterance_duration = rep(c(2.4, 2.7, 3.4, 1.8), each = 4)
  )

  # Test that each plot function produces a ggplot object
  expect_s3_class(plot_delta_cv(df_test, cv_label, utterance_id, cv_duration), "ggplot")
  expect_s3_class(plot_rpvi(df_test, cv_label, label_name = "consonant", utterance_id, cv_duration), "ggplot")
  expect_s3_class(plot_npvi(df_test, cv_label, label_name = "vowel", utterance_id, cv_duration), "ggplot")
})