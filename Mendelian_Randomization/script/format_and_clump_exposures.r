############################################################
# Script: format_and_clump_exposures.R
# Description:
#   This script prepares two exposures—Type 2 Diabetes (T2D) 
#   and Body Mass Index (BMI)—for Mendelian Randomization (MR) 
#   analysis. It loads summary statistics, filters by 
#   significance, formats the data, and performs LD clumping 
#   using EAS population reference.
############################################################

# -------- Step 1: Install and load necessary packages --------

install.packages('ieugwasr')  # For interacting with GWAS databases

library(data.table)           # Fast file reading
library(TwoSampleMR)          # Core MR analysis package

# -------- Step 2: Load and prepare exposure datasets --------

# Load T2D GWAS summary stats (Japanese population)
t2d <- fread("/kaggle/working/hum0197.v3.BBJ.T2D.v1/GWASsummary_T2D_Japanese_SakaueKanai2020.auto.txt.gz")
t2d <- data.frame(t2d)

# Load BMI GWAS summary stats (Korean population)
bmi <- fread("koges_bmi.txt.gz")
bmi <- data.frame(bmi)

# Remove problematic variant from BMI data
bmi <- bmi[!bmi$effect_allele.exposure == 'GGTGT',]

# -------- Step 3: Filter significant SNPs --------

# Keep only BMI variants with p-value < 1e-6
bmi <- subset(bmi, bmi$pval < 1e-6)

# Format BMI data for MR analysis
bmi <- format_data(bmi,
    type = "exposure",
    snp_col = "rsids",
    beta_col = "beta",
    se_col = "sebeta",
    effect_allele_col = "alt",
    other_allele_col = "ref",
    eaf_col = "af",
    pval_col = "pval"
)

# Keep only T2D variants with p-value < 1e-6
t2d <- subset(t2d, t2d$p.value < 1e-6)

# Format T2D data for MR analysis
t2d <- format_data(t2d,
    type = "exposure",
    snp_col = "SNPID",
    beta_col = "BETA",
    se_col = "SE",
    effect_allele_col = "Allele2",
    other_allele_col = "Allele1",
    eaf_col = "AF_Allele2",
    pval_col = "p.value",
    pos_col = 'POS'
)

# -------- Step 4: Explore the formatted data --------

dim(t2d); sort(colnames(t2d))  # Check structure of T2D data
dim(bmi); sort(colnames(bmi))  # Check structure of BMI data

head(bmi)
head(t2d)

unique(t2d$id.exposure)  # Verify exposure name auto-assigned

# -------- Step 5: Perform LD clumping (if needed) --------

# Clump SNPs to ensure independence (based on LD) using EAS population reference
c_bmi_exp <- clump_data(bmi, pop = 'EAS')
c_t2d_exp <- clump_data(t2d, pop = 'EAS')

# Optionally, skip clumping and use full list of SNPs (overwrite)
c_bmi_exp <- bmi
c_t2d_exp <- t2d

# Assign meaningful exposure names
c_t2d_exp$exposure <- "CUisng_T2D"
c_bmi_exp$exposure <- "f1j5gq_BMI"
