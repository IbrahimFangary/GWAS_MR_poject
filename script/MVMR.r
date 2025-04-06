############################################################
# Multivariable Mendelian Randomization (MVMR)
# Goal:
#   Estimate the *independent* effects of both T2D and BMI
#   on CAD while adjusting for each other.
############################################################

# Combine both exposures into one dataset
# Ensure columns are aligned properly using `fill = TRUE`
exposures_mv <- rbind(c_t2d_exp, c_bmi_exp, fill = TRUE)

# Harmonize exposures with the CAD outcome data
harmonised_data <- mv_harmonise_data(exposures_mv, cad_outcome_dat)

# Run MVMR and generate plots
res <- mv_multiple(harmonised_data, plots = TRUE)

# Display results
print(res)

