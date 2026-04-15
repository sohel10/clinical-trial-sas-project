/* ============================= */
/* Step 0: Setup Output */
/* ============================= */

ods _all_ close;

/* Tables output */
ods rtf file="/home/u64243044/clinical_project/outputs/tables.rtf";

/* Figures output (HTML + PNG files) */
ods html5 
    path="/home/u64243044/clinical_project/outputs"
    file="figures.html"
    gpath="/home/u64243044/clinical_project/outputs";

/* Enable graphics */
ods graphics on;


/* ============================= */
/* Step 1: Load Macros + Libraries */
/* ============================= */

%include "/home/u64243044/clinical_project/macros/summary.sas";

libname adam "/home/u64243044/clinical_project/data_adam";
libname sdtm "/home/u64243044/clinical_project/data_sdtm";


/* ============================= */
/* Step 2: Tables */
/* ============================= */

title "Demographic Summary";
proc freq data=adam.adsl;
    tables SEX RACE TRT01A;
run;

title "Age Summary";
proc means data=adam.adsl mean std min max;
    var AGE;
run;


/* ============================= */
/* Step 3: Statistical Models */
/* ============================= */

/* GLM */
title "GLM Model: Age by Disease Stage";
proc glm data=adam.adsl;
    class DISTAGE;
    model AGE = DISTAGE;
run;

/* Logistic */
title "Logistic Model: Event Prediction";
proc logistic data=adam.adsl;
    class DISTAGE SMKSTAT;
    model event(event='1') = AGE SEX DISTAGE SMKSTAT;
run;

/* Cox Model */
title "Cox Proportional Hazards Model";
proc phreg data=adam.adsl;
    class DISTAGE SMKSTAT;
    model time_to_event*event(0) = AGE SEX DISTAGE SMKSTAT;
run;


/* ============================= */
/* Step 4: Survival Analysis */
/* ============================= */

title "Kaplan-Meier Curve by Disease Stage";

/* Save KM plot as PNG */
ods graphics / reset imagename="fig_km" imagefmt=png;

proc lifetest data=adam.adsl plots=survival;
    time time_to_event*event(0);
    strata DISTAGE;
run;


/* ============================= */
/* Step 5: Visualization */
/* ============================= */

/* Scatter Plot */
title "Scatter Plot: Age vs Time";

ods graphics / reset imagename="fig_scatter" imagefmt=png;

proc sgplot data=adam.adsl;
    scatter x=AGE y=time_to_event;
run;


/* Boxplot */
title "Boxplot: Age by Disease Stage";

ods graphics / reset imagename="fig_boxplot" imagefmt=png;

proc sgplot data=adam.adsl;
    vbox AGE / category=DISTAGE;
run;


/* ============================= */
/* Step 6: AE Summary (MedDRA) */
/* ============================= */

title "Adverse Event Summary";
proc freq data=sdtm.ae;
    tables AEDECOD;
run;


/* ============================= */
/* Step 7: Macro Usage */
/* ============================= */

title "Macro Summary - SEX";
%summary(SEX);

title "Macro Summary - DISTAGE";
%summary(DISTAGE);


/* ============================= */
/* Step 8: Close Outputs */
/* ============================= */

ods rtf close;
ods html5 close;

title;
footnote;