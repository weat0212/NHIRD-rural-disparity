libname Term "C:\Users\Han\Desktop\course\HW2\Health-02";


/* -------------IPDTE ��ƳB�z ------------- */

/* -------------CITY �аO���m RURAL------------- */
/* -------------RENAME CITY  FOR ���m����------------- */
data Term.rurallist;
	set rurallist;
	rename ID1_CITY=CITY;
run;
/* -------------SORT ------------- */
proc sort data = Term.rurallist;
	by city;
run;
/* -------------MERGE ------------- */
data Term.ipdte_rural;
	set Term.ipdte;
	merge Term.ipdte Term.rurallist;
	by CITY;
run;

/*  -------------TRAN_CODE   ------------- */
/*  -------------1:�v���X�| 2�G�~���| 3�G����E�v�� 4�G���` 5�G�@��۰ʥX�| 6�G��|7�G�����ܧ� 8�G��k 9�G�۱� 0�G�䥦 A�G�f�M�۰ʥX�|�C B:��| 30 �餺�]�����ܧ���b�ӳ���A�ର�פ��I�ΥN�줧�D Tw-DRGs �ץ� ------------- */
/* --------------�ư��D�����欰�A�е���|�H�Φ��` ------------- */

/*  -------------��| ------------- */
data Term.iprural;
	set Term.ipdte_rural;
	Referral = "";
	if TRAN_CODE = "6" then Referral =  "Y";
	else Referral = "N";
run;

/*  -------------���` ------------- */
data Term.iprural;
	set Term.iprural;
	Death = "";
	if TRAN_CODE = "2" then Death=  "Y";
	else Death = "N";
run;

/*  -------------�d���˩w(��|) ------------- */
title "���m����E�v�t��";
proc freq data = Term.iprural;
	tables RURAL*Referral/chisq;
run;

/*  -------------�d���˩w(���`)   ------------- */
title "���m�����`�v�t��";
proc freq data = Term.iprural;
	tables RURAL*Death/chisq;
run;

/* ------------------------------------------------------�䥦����------------------------------------------------------*/
/*  -------------��N�I�Ƥ��R ------------- */
title "���m��N�I�Ʈt��";
proc means data =  Term.iprural;
	var SGRY_DOT;
	output out = Term.SGRYoutlier p25 = p25  p75 = p75;
run;

data Term.SGRYdatainfo;
	set Term.SGRYoutlier;
	IQR3=3*(p75-p25);
	call symputx('IQR3',IQR3); 
	call symputx('p75',p75);
	call symputx('p25',p25);
run;

/* -------------�R�����s�� ------------- */
data Term.iprural2;
	set Term.iprural;
	if SGRY_DOT > 34995 then delete;
run;

proc univariate data = Term.iprural2 normal;var SGRY_DOT ;run;

proc ttest data = Term.iprural2  H0 = 4561 ; CLASS RURAL;var SGRY_DOT;run;

/* -------------�R����N�I�Ƭ�0 ��� ------------- */
data Term.iprural3;
	set Term.iprural2;
	if SGRY_DOT = 0 then delete;
run;

proc univariate data = Term.iprural3 normal;var SGRY_DOT ;run;

/* -------------T TEST ------------- */
proc ttest data = Term.iprural3  H0 = 15304 ; CLASS RURAL;var SGRY_DOT;run;


/* �f�w�ӷ� 14�Ѥ��A�׬ݶE */
title "���m���A�E�v�t��";
data Term.iprural_14;
	set Term.iprural;
	AGAIN = "";
	if PAT_SOURCE = "4" then AGAIN = "Y";
	else AGAIN = "N";
run;

proc freq data = Term.iprural_14;
	tables RURAL*AGAIN/chisq;
run;

/* �S������I��*/
title "���m���S���I�Ʈt��";
proc means data =  Term.iprural;
	var METR_DOT;
	output out = Term.METRoutlier p25 = p25  p75 = p75;
run;

data Term.METRdatainfo;
	set Term.METRoutlier;
	IQR3=3*(p75-p25);
	call symputx('IQR3',IQR3); 
	call symputx('p75',p75);
	call symputx('p25',p25);
run;

/* -------------�R�����s�� ------------- */
data Term.ipruralMETR;
	set Term.iprural;
	if METR_DOT > 3246 then delete;
run;

/* -------------�R����N�I�Ƭ�0 ��� ------------- */
data Term.ipruralMETR2;
	set Term.ipruralMETR;
	if SGRY_DOT = 0 then delete;
run;

proc means data =  Term.ipruralMETR;
	var METR_DOT;
run;

proc univariate data = Term.ipruralMETR normal;var METR_DOT ;run;

/* -------------T TEST ------------- */
proc ttest data = Term.ipruralMETR  H0 = 405 ; CLASS RURAL;var METR_DOT;run;
