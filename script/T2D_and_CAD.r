############################################################
# Step: MR Analysis - T2D → CAD
# Description:
#   Tests whether genetically predicted liability to T2D
#   increases risk of CAD using Two-Sample MR.
############################################################

# -------- Harmonize exposure (T2D) with outcome (CAD) --------
harmonized_data <- harmonise_data(
  exposure_dat = c_t2d_exp,
  outcome_dat  = cad_outcome_dat
)

# -------- Run MR Analysis --------
res <- mr(harmonized_data)
head(res)

# -------- Sensitivity Analyses --------

# Cochran’s Q-test for heterogeneity
mr_heterogeneity(harmonized_data)

# MR-Egger intercept test for horizontal pleiotropy
mr_pleiotropy_test(harmonized_data)

# MR for individual SNPs
res_single <- mr_singlesnp(harmonized_data)
head(res_single)

# Leave-one-out analysis
res_loo <- mr_leaveoneout(harmonized_data)
head(res_loo)

# -------- Plotting --------
options(repr.plot.width = 15, repr.plot.height = 10)

# 1. Scatter plot
p1 <- mr_scatter_plot(res, harmonized_data)
p1[[1]]

# 2. Forest plot (single SNP effects)
p2 <- mr_forest_plot(res_single)
p2[[1]]

# 3. Leave-one-out plot
p3 <- mr_leaveoneout_plot(res_loo)
p3[[1]]

# 4. Funnel plot for bias assessment
p4 <- mr_funnel_plot(res_single)
p4[[1]]
