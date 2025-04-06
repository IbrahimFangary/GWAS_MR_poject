# 🧬 MVMR Analysis: Investigating the Independent Effects of BMI and Type 2 Diabetes on Coronary Artery Disease (CAD)

This repository explores whether **Body Mass Index (BMI)** and **Type 2 Diabetes (T2D)** independently influence the risk of developing **Coronary Artery Disease (CAD)**, using **Multivariable Mendelian Randomization (MVMR)** based on GWAS data from **East Asian populations**.

---

## 📂 Repository Contents

- `data/`: Harmonized GWAS summary statistics for BMI, T2D, and CAD  
- `scripts/`: R scripts for harmonization, instrument selection, and MVMR analysis  
- `figures/`: Visualizations of MVMR results  
  - `MVMR_Scatter_BMI_T2D_CAD.png`
  - `MVMR_Funnel_Plot.png`
  - `MVMR_Single_SNP_Analysis.png`
  - `MVMR_Leave_One_Out.png`
- `results/`: Output tables (effect estimates, p-values, standard errors)
- `README.md`: This file – report and interpretation

---

## 🧪 Objective

To assess whether BMI and T2D have **independent causal effects** on CAD when analyzed simultaneously in an MVMR framework.

---

## 🧬 Methodology

We performed a Multivariable Mendelian Randomization (MVMR) analysis using:

- GWAS summary statistics for:
  - **BMI** (East Asian)
  - **Type 2 Diabetes (T2D)** (East Asian)
  - **Coronary Artery Disease (CAD)** (East Asian)

### Steps Taken:
1. **Instrument Selection**:
   - SNPs associated with either BMI or T2D at genome-wide significance (p < 5×10⁻⁸)
   - LD-clumping to ensure independence
2. **Harmonization** of effect alleles across datasets
3. **MVMR estimation** using `TwoSampleMR` and `MVMR` R packages

---

## 📊 Results Summary

| Exposure | Outcome | SNPs | Effect (β) | SE     | p-value |
|----------|---------|------|------------|--------|---------|
| BMI      | CAD     | 3    | 0.434      | 2.011  | 0.829   |
| T2D      | CAD     | 1    | -0.100     | 1.334  | 0.940   |

<sub>Table 1: MVMR effect estimates for BMI and T2D on CAD</sub>

These results suggest **no statistically significant evidence** that either BMI or T2D has an independent causal effect on CAD in this analysis.

---

## 🖼️ Figures

- **Figure 1: MVMR_Scatter_BMI_T2D_CAD.png**  
  Scatter plot of SNP-exposure vs SNP-outcome effects. No clear causal trend observed.

- **Figure 2: MVMR_Funnel_Plot.png**  
  Funnel plot shows symmetrical distribution, suggesting no strong evidence of directional pleiotropy.

- **Figure 3: MVMR_Single_SNP_Analysis.png**  
  Forest plot of individual SNP estimates reveals large confidence intervals.

- **Figure 4: MVMR_Leave_One_Out.png**  
  Leave-one-out analysis indicates no single SNP is driving the results.

---

## 📌 Interpretation and Biological Context

Despite the lack of statistical significance, these findings **should not be interpreted as evidence of no effect**. Instead, they may reflect limitations of the dataset and instrument strength.

### Potential Explanations:

1. **Limited SNPs**: Only 3 instruments for BMI and 1 for T2D → **low power**
2. **High Standard Errors**: Wide confidence intervals indicate considerable uncertainty
3. **Overlapping Pathways**: BMI and T2D may influence CAD via shared mechanisms (e.g. inflammation, insulin resistance)

### Biological Plausibility:

- **BMI and Obesity** are well-documented risk factors for CAD via mechanisms like systemic inflammation, dyslipidemia, and hypertension [1][2].
- **T2D** increases CAD risk through **endothelial dysfunction**, **glycation**, and **oxidative stress** [3][4].
- The interplay between **adiposity and insulin resistance** complicates the isolation of their individual effects on CAD.

Thus, while this MVMR analysis does not confirm independent causal effects, **observational and mechanistic studies suggest strong biological plausibility**.

---

## ⚠️ Limitations

- ⚠️ **Small number of instruments**: Reduces statistical power and robustness
- ⚠️ **Potential weak instrument bias**
- 🌍 **Population-specific results**: GWAS datasets are limited to East Asian ancestries
- 🔁 **Sample overlap**: Not accounted for; could bias effect estimates

---

## 🧭 Future Directions

- Expand to **larger GWAS datasets** with more SNPs
- Perform **multivariable MR-Egger** to check for pleiotropy
- Explore **longitudinal MR** or **multi-ethnic** designs
- Investigate **mediation** via other risk factors (e.g., lipid profiles, blood pressure)

---

## 📚 References

1. Lavie CJ, et al. (2009). *Obesity and cardiovascular disease: risk factor, paradox, and impact of weight loss.* J Am Coll Cardiol. https://doi.org/10.1016/j.jacc.2008.11.050  
2. Powell-Wiley TM, et al. (2021). *Obesity and cardiovascular disease: a scientific statement.* Circulation. https://doi.org/10.1161/CIR.0000000000000973  
3. Brownlee M. (2005). *The pathobiology of diabetic complications: a unifying mechanism.* Diabetes. https://doi.org/10.2337/diabetes.54.6.1615  
4. Low Wang CC, et al. (2016). *Diabetes and cardiovascular disease: a statement for healthcare professionals.* Circulation. https://doi.org/10.1161/CIR.0000000000000354

---

## 🧠 Conclusion

This project attempted to untangle the effects of BMI and T2D on CAD using MVMR. While results did not support independent causal effects, **this may reflect insufficient power** rather than true absence of effect. Further studies with stronger instruments and larger datasets are essential to clarify these complex relationships.

