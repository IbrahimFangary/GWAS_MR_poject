# GWAS pipeline bash script

# Set working directory
cd GWASTutorial/sample_data || exit

# Define variables
genotypeFile="sample_data.clean"   # PLINK dataset
phenotypeFile="/kaggle/working/GWASTutorial/01_Dataset/1kgeas_binary.txt" # Phenotype file
covariateFile="plink_results_projected.sscore" # PC score file
colName="B1"
threadnum=2

# Run PLINK2 GWAS
plink2 \
  --bfile ${genotypeFile} \
  --pheno ${phenotypeFile} \
  --pheno-name ${colName} \
  --maf 0.01 \
  --covar ${covariateFile} \
  --covar-col-nums 6-10 \
  --glm hide-covar firth firth-residualize single-prec-cc \
  --threads ${threadnum} \
  --out 1kgeas

# Preview results
head 1kgeas.${colName}.glm.firth

# Run Python GWASLab analysis
python3 <<'EOF'
import gwaslab as gl

# Load summary statistics
sumstats = gl.Sumstats("1kgeas.B1.glm.firth", fmt="plink2")

# Extract lead SNPs
sumstats.get_lead(sig_level=5e-8)

# Manhattan & QQ plots
sumstats.plot_mqq(skip=2, anno=True)

# Basic QC
sumstats.basic_check()

# Regional plot (build 19)
sumstats.plot_mqq(mode="r", anno=True, region=(2,54513738,56513738),
                  region_grid=True, build="19")

# Download reference panel for annotation
gl.download_ref("1kg_eas_hg19")

# Regional plot with VCF reference
sumstats.plot_mqq(mode="r", anno=True, region=(2,54531536,56731536),
                  region_grid=True, vcf_path=gl.get_path("1kg_eas_hg19"),
                  build="19")
EOF
