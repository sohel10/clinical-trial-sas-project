# Designed to replicate real-world pharmaceutical clinical trial workflows.
## 📌 Overview
This project demonstrates an end-to-end clinical trial data workflow using SAS, following CDISC standards (SDTM → ADaM → TLF). The goal is to transform raw clinical data into analysis-ready datasets and perform statistical and survival analyses.

---

## 🔄 Data Pipeline

Raw Data → SDTM → ADaM → ADSL → Statistical Analysis → TLF Outputs

---

## 📂 Project Structure
```` text
clinical-trial-sas-project/
│
├── programs/
│ ├── sdtm/01_create_sdtm.sas
│ ├── adam/02_create_adam.sas
│ ├── tlf/03_analysis.sas
│
├── macros/
│ └── summary.sas
│
├── outputs/
│ ├── tables.rtf
│ ├── tables.pdf
│ ├── fig_km.png
│ ├── fig_scatter.png
│ ├── fig_boxplot.png
│
└── README.md
````

---

## 📊 CDISC Implementation

### SDTM (Study Data Tabulation Model)
- Created standard domains:
  - DM (Demographics)
  - AE (Adverse Events)
  - EX (Exposure)
- Standardized variables:
  - STUDYID, USUBJID, DOMAIN
- Applied MedDRA coding (AEDECOD)

---

### ADaM (Analysis Data Model)
- Developed subject-level dataset (ADSL)
- Key variables:
  - AGE, SEX, RACE
  - TRT01A (Treatment)
  - time_to_event
  - event (0=censored, 1=event)

---

## 📈 Statistical Analysis

The following statistical procedures were implemented:

- **PROC GLM** → Continuous outcome modeling  
- **PROC LOGISTIC** → Binary outcome modeling  
- **PROC GENMOD** → Generalized linear models  
- **PROC MIXED** → Mixed-effects modeling  
- **PROC LIFETEST** → Kaplan-Meier survival analysis  
- **PROC PHREG** → Cox proportional hazards model  

---

## ⏳ Survival Analysis

- Time-to-event variable derived from treatment dates  
- Event indicator correctly defined:
  - `event = 1` → event occurred  
  - `event = 0` → censored  
- Kaplan-Meier survival curves generated  
- Cox model used to estimate hazard ratios  

---

## 📉 Visualization

Generated using SAS ODS Graphics:

- Kaplan-Meier survival curves  
- Scatter plot (Age vs Time-to-event)  
- Boxplot (Age by Disease Stage)  

All figures exported as **PNG files**

---

## 📋 Tables, Listings, Figures (TLF)

- Demographic summary tables  
- Continuous summary statistics  
- Adverse event frequency tables  
- Listings (first 20 subjects)  

Outputs exported as:
- `tables.rtf` (clinical standard)
- `tables.pdf` (review-friendly)

---
## 📊 Key Findings (Clinical Interpretation)
- Baseline characteristics (Table 1) comparing demographic variables across disease stage
- Older age was associated with a slightly higher hazard of event occurrence.
- Disease stage (DISTAGE) showed variation in survival probabilities across groups.
- Smoking status (SMKSTAT) was included as a clinical risk factor in the model.

- Kaplan-Meier curves demonstrated differences in survival distributions by disease stage.

These results illustrate how survival analysis can be used in clinical trials to evaluate treatment and risk factors.

## ⚠️ Important Note

Treatment variable (TRT01A) contains only one level in this dataset, therefore:

- Used for **reporting only**
- Not used in statistical modeling

Modeling was performed using:
- Disease stage (DISTAGE)
- Smoking status (SMKSTAT)
- Demographic variables

---

## 🧠 Key Skills Demonstrated

- CDISC (SDTM & ADaM) data standards  
- Clinical trial data processing in SAS  
- Data manipulation and merging  
- Survival analysis and Cox modeling  
- Statistical modeling across multiple SAS procedures  
- TLF generation (tables, listings, figures)  
- SAS macro development  
- MedDRA-based adverse event reporting  

---

## 🚀 How to Run
1. Run SDTM creation:
programs/sdtm/01_create_sdtm.sas
2. Run ADaM creation:
## programs/adam/02_create_adam.sas
3. Run analysis:
# programs/tlf/03_analysis.sas

## 🎯 Purpose

This project is designed to demonstrate industry-level SAS programming skills for:

- Clinical SAS Programmer roles  
- Biostatistician positions  
- Pharmaceutical data science roles  

---

## 📬 Contact

For questions or collaboration opportunities, feel free to reach out.
https://www.linkedin.com/in/sohelcu06/

