# rhythm.metrics v1.1.0
**Installation:**
```r
remotes::install_github("congzhang365/rhythm.metrics")
```


### What's New
* **Standardized Syntax:** This version introduces minor syntax changes to argument names (e.g., `c_label` and `v_label` are now standardised to `label_name` or `cv_label` consistently).
* **R 4.6.0 Ready:** Major update for **R 4.6.0** compatibility and improved stability.

### Available Calculation Functions:
- `delta_cv(df, cv_label, utterance_id, cv_duration)`
- `varco_cv(df, cv_label, utterance_id, cv_duration)`
- `percentage_v(df, v_label = "vowel", utterance_id, cv_duration, utterance_duration)`
- `rpvi_c(df, cv_label, label_name = "consonant", utterance_id, cv_duration)`
- `npvi_v(df, cv_label, label_name = "vowel", utterance_id, cv_duration)`

### Available Visualisation Functions:
- `plot_delta_cv(df, cv_label, utterance_id, cv_duration)`
- `plot_varco_cv(df, cv_label, utterance_id, cv_duration)`
- `plot_percentage_v(df, cv_label, label_name = "vowel", 
                  utterance_id, cv_duration, utterance_duration)`
- `plot_rpvi(df, cv_label, label_name = "consonant", utterance_id, cv_duration)`
- `plot_npvi(df, cv_label, label_name = "vowel", utterance_id, cv_duration)`



# rhythm.metrics v1.0.0 (Legacy)

Initial beta release. Published in 2022. No change up until April 2026.

**Installation:**
```r
# Install remotes if you haven't already
install.packages("remotes")

# Install the legacy v1.0.0 version
remotes::install_github("congzhang365/rhythm.metrics@v1.0.0")
```

### Available Calculation Functions:
- `delta_cv(df, cv_label, utterance_id, cv_duration)`
- `varco_cv(df, cv_label, utterance_id, cv_duration)`
- `percentage_v(df, v_label, utterance_id, cv_duration)`
- `rpvi_c(df, c_label, utterance_id, cv_duration)`
- `npvi_v(df, v_label, utterance_id, cv_duration)`

### Available Visualisation Functions:
- `plot_delta_cv(df, cv_label, utterance_id, cv_duration)`
- `plot_varco_cv(df, cv_label, utterance_id, cv_duration)`
- `plot_percentage_v(df, v_label, utterance_id, cv_duration)`
- `plot_rpvi(df, c_label, utterance_id, cv_duration)`
- `plot_npvi(df, v_label, utterance_id, cv_duration)`

