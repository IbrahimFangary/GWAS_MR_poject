############################################################
# Script: setup_and_download_GWAS.R
# Description:
#   This script is designed for use in a Kaggle environment. 
#   It sets up a custom R package library, installs the 
#   TwoSampleMR package from GitHub, and downloads several 
#   GWAS summary statistics from different populations 
#   (Korean and Japanese) for downstream Mendelian Randomization (MR) analysis.
############################################################

# -------- Step 1: Setup R package environment in Kaggle --------

# Define custom library path (uploaded as a Kaggle dataset)
custom_lib <- "/kaggle/input/library-data/my_r_libs"  
# Define the default R library path in Kaggle
default_lib <- .libPaths()[1] 

# Get list of packages from the custom library
packages <- list.dirs(custom_lib, full.names = TRUE, recursive = FALSE)

# Move each package to the default library path if not already installed
for (pkg in packages) {
  pkg_name <- basename(pkg)  # Extract package name
  target_path <- file.path(default_lib, pkg_name)
  
  if (!dir.exists(target_path)) {
    file.copy(pkg, default_lib, recursive = TRUE)
  } else {
    message(paste("Package already exists in default library:", pkg_name))
  }
}

print('-----------------All packages are moved----------------------')

# -------- Step 2: Install TwoSampleMR from GitHub --------

# Install TwoSampleMR package for MR analysis
devtools::install_github("MRCIEU/TwoSampleMR")

# -------- Step 3: Download GWAS Summary Statistics --------

# Download BMI GWAS summary statistics from KoGES (Korean population)
download.file('https://koges.leelabsg.org/download/KoGES_BMI', 'koges_bmi.txt.gz')

# Increase timeout to allow large file downloads
options(timeout = 700)

# Download Type 2 Diabetes (T2D) GWAS summary stats from BBJ (Japanese population)
download.file('https://pheweb.jp/download/T2D', 'bbj_t2d.zip')
unzip("bbj_t2d.zip")

# Download Coronary Artery Disease (CAD) GWAS summary stats from BBJ (Japanese population)
download.file('https://humandbs.dbcls.jp/files/hum0014/hum0014_v20_gwas_v1.zip', 'hum0014_v20_gwas_v1.zip')
unzip('hum0014_v20_gwas_v1.zip')

# -------- Step 4: Set Environment Variable for OpenGWAS --------

# Set JWT token for OpenGWAS API access (replace "my_taken" with your actual token)
Sys.setenv(OPENGWAS_JWT = "my_taken")
