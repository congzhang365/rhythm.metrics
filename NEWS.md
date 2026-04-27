# rhythm.metrics 1.1.0
* **Breaking Change:** Standardized `v_label` and `c_label` to `label_name`.
* **Fix:** Added Tidy Evaluation to plotting functions to prevent "object not found" errors.
* **Feature:** Added automated figure saving logic to all plots.


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

