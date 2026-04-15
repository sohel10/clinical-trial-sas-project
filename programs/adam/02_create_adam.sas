

/* Step 0: Libraries */
libname sdtm "/home/u64243044/clinical_project/data_sdtm";
libname adam "/home/u64243044/clinical_project/data_adam";
libname raw  "/home/u64243044/clinical_project/data_raw";


/* ============================= */
/* Step 1: Subject-level dataset */
/* ============================= */
data adsl_base;
    set sdtm.dm;

    /* ADaM standard variables */
    TRT01A = TRT;   /* treatment */
    TRT01P = TRT;

run;


/* ============================= */
/* Step 2: Survival data */
/* ============================= */
data surv;
    set raw.final_data;

    keep USUBJID TTESTDT TTEENDT TTECENSFLG;
run;


/* ============================= */
/* Step 3: Merge */
/* ============================= */
proc sort data=adsl_base; by USUBJID; run;
proc sort data=surv; by USUBJID; run;

data adam.adsl;
    merge adsl_base(in=a) surv(in=b);
    by USUBJID;

    if a;

    /* Survival variables */
    time_to_event = TTEENDT - TTESTDT;

    if TTECENSFLG = 0 then event = 1;
    else if TTECENSFLG = 1 then event = 0;

run;


/* ============================= */
/* Step 4: Check */
/* ============================= */
proc means data=adam.adsl n nmiss;
    var time_to_event event;
run;


/* RETAIN example */
data retain_example;
    set adam.adsl;
    retain count 0;
    count + 1;
run;

/* CALL SYMPUT example */
data _null_;
    set adam.adsl(obs=1);
    call symput('first_id', USUBJID);
run;

/* PROC TRANSPOSE */
proc transpose data=adam.adsl out=adsl_t;
    var AGE;
run;



