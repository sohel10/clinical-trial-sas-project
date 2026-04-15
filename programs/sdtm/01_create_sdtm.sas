/* Step 0: Define libraries */
libname raw  "/home/u64243044/clinical_project/data_raw";
libname sdtm "/home/u64243044/clinical_project/data_sdtm";


/* 1. DM (Demographics) */
data sdtm.dm;
    set raw.subjinfo;

    /* CDISC standard variables */
    STUDYID = SDYID;
    DOMAIN  = "DM";
    USUBJID = USUBJID;
    SUBJID  = put(SUBJID, best.);

    /* Demographics */
    AGE  = AGEYR;
    SEX  = SEX;
    RACE = RACE;
    COUNTRY = COUNTRY;

run;

/* 2. AE (Adverse Events) */

data sdtm.ae;
    set raw.events;

    STUDYID = SDYID;
    DOMAIN  = "AE";
    USUBJID = USUBJID;

    /* Example AE mapping */
    AEDECOD = AEDECOD;  /* MedDRA coded term */

run;


/* 3. EX (Exposure) */

data sdtm.ex;
    set raw.exsum;

    STUDYID = SDYID;
    DOMAIN  = "EX";
    USUBJID = USUBJID;

    TRT = TRT;
run;



