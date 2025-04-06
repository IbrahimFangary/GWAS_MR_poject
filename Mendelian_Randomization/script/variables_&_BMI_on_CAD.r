############################################################
# Script: mr_bmi_t2d_to_cad.R
# Description:
#   This script performs a two-sample Mendelian Randomization (MR)
#   to investigate the causal effects of BMI and T2D (exposures) 
#   on Coronary Artery Disease (CAD) (outcome) using GWAS summary 
#   statistics from East Asian populations.
#
# Steps:
#   1. Load and clean GWAS summary data
#   2. Harmonize SNPs across exposures and outcome
#   3. Perform MR and sensitivity analyses
#   4. Generate plots (scatter, forest, leave-one-out, funnel)
############################################################

# -------- Step 1: Load required data --------

# CAD GWAS summary stats (BBJ)
cad_dat <- fread("BBJCAD_2020.sumstats")

# T2D summary stats
t2d <- fread("/kaggle/working/hum0197.v3.BBJ.T2D.v1/GWASsummary_T2D_Japanese_SakaueKanai2020.auto.txt.gz")
t2d <- data.frame(t2d)

# Optional: Explore column names (preview only)
colnames_only <- fread("/kaggle/working/hum0197.v3.BBJ.T2D.v1/GWASsummary_T2D_Japanese_SakaueKanai2020.auto.txt.gz", nrows = 0)
print(colnames_only)

colnames_only <- fread("koges_bmi.txt.gz", nrows = 0)
print(colnames_only)

# -------- Step 2: Merge common SNPs between datasets --------

# Extract SNP info from T2D and BMI for merging
snp1 <- fread('hum0197.v3.BBJ.T2D.v1/GWASsummary_T2D_Japanese_SakaueKanai2020.auto.txt.gz', 
              select = c('POS','CHR','SNPID'))
snp2 <- fread('koges_bmi.txt.gz', 
              select = c('pos','chrom','rsids'))

# Standardize column names for merging
setnames(snp2, old = c("pos", 'chrom', "rsids"), 
               new = c("pos", 'chr', "SNP"))
setnames(snp1, old = c("POS", 'CHR', "SNPID"), 
               new = c("pos", 'chr', "SNP"))

# Ensure integer data types
snp1$pos <- as.integer(snp1$pos)
snp1$chr <- as.integer(snp1$chr)

# Merge SNPs found in both BMI and T2D datasets
snped <- merge(snp1, snp2, by = c("pos", 'chr', "SNP"))
dim(snped)  # Show number of overlapping SNPs

# Standardize CAD dataset column names for merging
setnames(cad_dat, old = c("POS", 'CHR'), 
                   new = c("pos", 'chr'))

# -------- Step 3: Merge with CAD outcome data --------

# Merge CAD data with shared SNPs
cad_merged <- merge(snped, cad_dat, by = c("chr", "pos"))
head(cad_merged)

# -------- Step 4: Format CAD as outcome --------

cad_outcome_dat <- format_data(data.frame(cad_merged),
                               type = "outcome",
                               snp_col = 'SNP',
                               beta_col = 'BETA',
                               se_col = 'SE',
                               eaf_col = 'AAF',
                               effect_allele_col = 'ALT',
                               other_allele_col = 'REF',
                               pval_col = 'P')

# -------- Step 5: Harmonize exposure and outcome --------

# Assume c_bmi_exp has been prepared already from previous steps
# exposures_data <- exposures_dat  # unused here
exposures_data$mr_keep <- TRUE    # Mark all exposures as valid (optional)

harmonized_data <- harmonise_data(
  exposure_dat = c_bmi_exp,
  outcome_dat = cad_outcome_dat
)

# -------- Step 6: Perform Mendelian Randomization --------

res <- mr(harmonized_data)
head(res)

# -------- Step 7: Sensitivity Analyses --------

# Cochran's Q test for heterogeneity
mr_heterogeneity(harmonized_data)

# MR-Egger intercept test for directional pleiotropy
mr_pleiotropy_test(harmonized_data)

# MR using each SNP individually
res_single <- mr_singlesnp(harmonized_data)
head(res_single)

# Leave-one-out analysis
res_loo <- mr_leaveoneout(harmonized_data)
head(res_loo)

# -------- Step 8: Plotting Results --------

# Scatter plot of MR estimates
p1 <- mr_scatter_plot(res, harmonized_data)
p1[[1]]

# Forest plot of individual SNP effects
res_single <- mr_singlesnp(harmonized_data)
p2 <- mr_forest_plot(res_single)
p2[[1]]

# Leave-one-out plot
res_loo <- mr_leaveoneout(harmonized_data)
p3 <- mr_leaveoneout_plot(res_loo)
p3[[1]]

# Funnel plot to detect bias
res_single <- mr_singlesnp(harmonized_data)
p4 <- mr_funnel_plot(res_single)
p4[[1]]
