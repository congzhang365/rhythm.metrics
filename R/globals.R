if (getRversion() >= "2.15.1") {
  utils::globalVariables(
    c(
      "cv_label", "cv_val", "m_minus_1", "mean_d",
      "npvi_utt", "pair_diff", "pair_mean", "pair_norm",
      "percent_v", "rpvi_utt", "v_total"
    )
  )
}
