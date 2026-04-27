test_that("Core rhythm metrics return correct structures", {
  df_test <- data.frame(
    cv_label = rep(c("consonant", "vowel"), 8),
    utterance_id = rep(paste0("utt_", 1:4), each = 4),
    cv_duration = c(0.10, 0.80, 0.20, 0.50, 0.30, 0.30, 0.40, 0.70, 
                    0.30, 0.88, 0.50, 0.90, 0.30, 0.57, 0.40, 0.97),
    utterance_duration = rep(c(2.4, 2.7, 3.4, 1.8), each = 4)
  )

  # Check Delta CV
  res_delta <- delta_cv(df_test, cv_label, utterance_id, cv_duration)
  expect_s3_class(res_delta, "data.frame")
  # Check if there are at least 2 columns (utterance_id + at least one metric)
  expect_true(ncol(res_delta) >= 2) 

  # Check Percentage V
  res_pv <- percentage_v(df_test, v_label = "vowel", utterance_id, cv_duration, utterance_duration)
  expect_s3_class(res_pv, "data.frame")
  expect_true(ncol(res_pv) >= 2)
  
  # Check PVI calculations
  expect_no_error(rpvi_c(df_test, cv_label, label_name = "consonant", utterance_id, cv_duration))
  expect_no_error(npvi_v(df_test, cv_label, label_name = "vowel", utterance_id, cv_duration))
})