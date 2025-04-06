# GWAS & Mendelian Randomization Project on Cardiovascular Disease

this repository documents a training project focused on Genome-Wide Association Studies (GWAS) and Mendelian Randomization (MR), specifically exploring genetic risk factors for **Coronary Artery Disease (CAD)**.

---

## 🧬 Overview

This project integrates two main components:

1. **GWAS Analysis Pipeline** – Using PLINK, R, and Bash to perform genome-wide association studies on synthetic genotype/phenotype data.
2. **Mendelian Randomization Analysis** – Investigating the causal effects of **Body Mass Index (BMI)** and **Type 2 Diabetes (T2D)** on **Coronary Artery Disease (CAD)** using MR and **Multivariable Mendelian Randomization (MVMR)** techniques.

The aim is to understand the relationship between cardiometabolic traits and CAD through modern genetic epidemiology tools.

---

## 📁 Repository Structure
- `Mendelian_Randomization/`
  - `script/` – R scripts for MR and MVMR analysis  
  - `figures/` – Generated plots  
  - `README.md` – Detailed report: BMI, T2D, and CAD MR study  
- `np_for_GWAS/`
  - `gwas_notebook.Rmd` – R notebook with GWAS steps using PLINK  
  - `scripts/` – Bash and R scripts used in GWAS pipeline  
  - `results/` – GWAS outputs and QC plots  
- `README.md` – You are here 

---

## 📖 Detailed Report

A comprehensive analysis titled:

**"BMI, Type 2 Diabetes, and Coronary Artery Disease: A Mendelian Randomization Study"**

is included in: Mendelian_Randomization/README.md

This report includes:
- Background & rationale
- Data sources
- Code walkthrough
- Results with plots
- Interpretation of findings
- Limitations & next steps

---

## 📊 Methods & Tools

### GWAS
- Software: **PLINK**, **R**, **Bash**
- Key steps:
  - Quality control (missingness, HWE, MAF)
  - Population stratification check
  - Association testing
  - Manhattan & QQ plot generation

### Mendelian Randomization
- Tools: **TwoSampleMR**, **MVMR**, **ggplot2**, **R Base**
- Sources:
  - GWAS summary statistics for BMI, T2D, and CAD (East Asian ancestry)
- Analyses:
  - Univariable MR
  - Multivariable MR
  - visualization of results
