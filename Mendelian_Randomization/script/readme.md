# BMI, Type 2 Diabetes, and Coronary Artery Disease: A Mendelian Randomization Study

## 📁 About This Repository

This repository contains a Mendelian Randomization (MR) analysis investigating the potential causal relationships between Body Mass Index (BMI), Type 2 Diabetes (T2D), and Coronary Artery Disease (CAD). The study includes:

- Univariable MR of BMI on CAD.
- Univariable MR of T2D on CAD.
- Multivariable MR (MVMR) of BMI and T2D on CAD.
- Plots showing MR estimates and SNP-level effects.
- Interpretation of findings and biological considerations.

Data used in this analysis were derived from GWAS summary statistics from East Asian populations.

---

## 📊 MR Results and Interpretation

### 1. Univariable MR: BMI → CAD

**Summary**:  
This analysis estimates the causal effect of BMI on CAD using genetic variants as instrumental variables. Multiple MR methods (IVW, MR Egger, Weighted Median, Mode-based) were applied.

**Visual**:  
*Figure 1: MR estimates for BMI on CAD using different methods*  
![BMI on CAD]![BMI on CAD](https://github.com/user-attachments/assets/552a62b2-8144-48cf-94d7-45c5b483424f)


**Interpretation**:  
All MR methods showed a small, slightly positive slope, indicating a potential causal relationship between higher BMI and increased CAD risk. However, the slope is close to zero and visually the SNPs are densely clustered around the null, suggesting limited evidence for a strong effect.

This result is partially consistent with previous research suggesting that elevated BMI is associated with increased cardiovascular risk, potentially via mechanisms like dyslipidemia, hypertension, and systemic inflammation [1]. However, genetic-based causal inference in this setting is still prone to bias due to pleiotropy or weak instruments.

---

### 2. Univariable MR: T2D → CAD

**Summary**:  
This analysis examines whether genetic predisposition to T2D increases the risk of CAD.

**Visual**:  
*Figure 2: MR estimates for T2D on CAD using different methods*  
![T2D on CAD]![T2D on CAD](https://github.com/user-attachments/assets/7c79938a-051b-44fe-b9f9-8cd25e5a93c3)


**Interpretation**:  
The results suggest a slight positive association, with MR slopes from different methods being modestly aligned in the positive direction. Still, effect sizes are small and most SNPs show large confidence intervals.

Epidemiological evidence supports a link between T2D and CAD, likely due to chronic hyperglycemia leading to endothelial dysfunction and atherogenesis [2]. However, these MR results do not strongly support a causal effect, due to weak instrument strength or population-specific factors in the East Asian cohort.

---

### 3. Multivariable MR: BMI + T2D → CAD

**Summary**:  
MVMR was conducted to estimate the independent causal effects of BMI and T2D on CAD, adjusting for their mutual confounding.

**Results**:
| Exposure | b (Estimate) | SE | p-value |
|----------|--------------|----|---------|
| BMI      | 0.4342       | 2.0111 | 0.8290 |
| T2D      | -0.1001      | 1.3345 | 0.9402 |

**Interpretation**:  
After adjusting for each other, neither BMI nor T2D showed statistically significant independent effects on CAD (p > 0.8 for both). The estimates are imprecise with large standard errors, likely due to limited SNP overlap and low instrument strength in the MVMR setting.

These results raise uncertainty about the independent contribution of each trait. It's possible that shared biological pathways (e.g., insulin resistance, inflammation) confound the simple interpretation of their individual effects on CAD risk.

---

## ⚠️ Limitations

- Small number of SNPs in MVMR reduces statistical power.
- Population specificity (East Asian GWAS) may limit generalizability.
- Possible horizontal pleiotropy and residual confounding.
- Figures suggest weak instruments with wide SNP confidence intervals.

---

## 🔬 Biological Considerations

- **BMI and CAD**: Obesity contributes to metabolic syndrome, which is a known risk factor for CAD. Adipose tissue may promote atherogenesis through secretion of pro-inflammatory cytokines [3].
- **T2D and CAD**: T2D accelerates atherosclerosis and increases CAD risk via hyperglycemia-induced vascular damage and pro-inflammatory states.
- **Shared pathways**: Both exposures may act through overlapping mechanisms such as insulin resistance and systemic inflammation, which complicates causal disentanglement in MVMR [4].

---

## 📌 Conclusions

While observational studies suggest both BMI and T2D increase CAD risk, this MR study did not find strong genetic evidence supporting direct, independent causal effects, especially in the multivariable context. These findings should be interpreted with caution due to limited power and potential bias. Further investigation with stronger instruments, larger sample sizes, and more robust models is warranted.

---

## 📚 References

1. Powell-Wiley, T. M. et al. (2021). Obesity and cardiovascular Disease: A scientific statement from the American Heart Association. *Circulation*.
2. Nakagami, H. et al. (2005). Endothelial dysfunction in hyperglycemia as a trigger of atherosclerosis. *Current Diabetes Reviews*.
3. Coppack, S. W. et al. (2001). Pro-inflammatory cytokines and adipose tissue. *Proceedings of the Nutrition Society*
4. Lotta, L. A. et al. (2016). Integrative genomic analysis implicates limited peripheral adipose storage capacity in the pathogenesis of human insulin resistance. *Nature Genetics*.

---

