libname Term "C:\Users\Han\Desktop\course\HW2\Health-02\SAS_CODE";
libname opdte "C:\Users\Han\Desktop\course\HW2\Health-01";
libname ipdte "C:\Users\Han\Desktop\course\HW2\Health-02";



/* -------------IPDTE 資料處理 ------------- */
/* -------------CITY 標記偏鄉 RURAL------------- */
/* -------------RENAME CITY  FOR 偏鄉串檔------------- */
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

/*  ------------------------------------------------- Part of IPDTE -------------------------------------------------  */
/*  ------------- TRAN_CODE ------------- */
/*  ------------- 1:治療出院 2：繼續住院 3：改門診治療 4：死亡 5：一般自動出院 6：轉院7：身份變更 8：潛逃 9：自殺 0：其它 A：病危自動出院。 B:住院 30 日內因身分變更切帳申報後，轉為論日支付或代辦之非 Tw-DRGs 案件 ------------- */
/* -------------- 排除非醫療行為，標註轉院以及死亡 ------------- */

/*  ------------- 轉院 ------------- */
data Term.iprural;
	set Term.ipdte_rural;
	Referral = "";
	if TRAN_CODE = "6" then Referral =  "Y";
	else Referral = "N";
run;

/*  -------------死亡 ------------- */
data Term.iprural;
	set Term.iprural;
	Death = "";
	if TRAN_CODE = "2" then Death=  "Y";
	else Death = "N";
run;

/*  -------------卡方檢定(轉院) ------------- */
title "城鄉間轉診率差異";
proc freq data = Term.iprural;
	tables RURAL*Referral/chisq;
run;

/*  -------------卡方檢定(死亡)   ------------- */
title "城鄉間死亡率差異";
proc freq data = Term.iprural;
	tables RURAL*Death/chisq;
run;



/* ------------------------------------------------- Part of OPDTE ------------------------------------------------- */
data year;
	input year $ @@;
	cards;
	103
	;
run;

data month;
	input month $ @@;
	cards;
	01 02 03 04 05 06 07 08 09 10 11 12
	;
run;

data group;
	input group $ @@;
	cards;
	10 20 30
	;
run;

proc sql;
	create table ym as
	select * from year, month, group;
quit;

data aa;
	set ym;
	no +1;
run;

%macro mv(x);

data _null_;
set aa;
text = 'opdte.h_nhi_opdte'||trim(year)||trim(month)||'_'||trim(group);
if no = &x then call symput('source',text);
run;

data opdte&x;
set &source;

%mend;

%macro loop;
%do x = 1 %to 36;
%mv(&x);
%end;
%mend;
%loop

data Term.opdte_all;
	set opdte1-opdte36;
run;

proc sort data = term.opdte_all;
	by CITY;
run;

data Term.opdte_rural;
	set Term.opdte_all;
	merge Term.opdte_all Term.rurallist;
	by CITY;
run;

/*  ------------- 轉診城鄉差異 ------------- */
data Term.opdte_rural_keep;
	set Term.opdte_rural;
	keep ID PAT_TRAN_OUT RURAL;
run;

title "門診轉診城鄉差異";
proc freq data = Term.opdte_rural_keep;
	tables RURAL*PAT_TRAN_OUT/chisq;
run;

/*  ------------- 看診次數分析 ------------- */
/* --- MALE --- */
title "看診次數城鄉差異(男性)";
data Term.male;
	set Opdte_m_rural_freq Opdte_m_urban_freq;
run;
	 
proc univariate data = Term.male normal;var n ;run; /* 找出平均看診 */
proc ttest data = Term.male  H0 = 11 ; CLASS RURAL;var n;run; /* H0 = 平均看診 */

/* --- FEMALE --- */
title "看診次數城鄉差異(女性)";
data Term.female;
	set Opdte_f_rural_freq Opdte_f_urban_freq;
run;
	 
proc univariate data = Term.female normal;var n ;run; /* 找出平均看診 */
proc ttest data = Term.female  H0 = 12 ; CLASS RURAL;var n;run; /* H0 = 平均看診 */












/* ------------------------------------------------------其它嘗試------------------------------------------------------*/
/*  -------------手術點數分析 ------------- */
title "城鄉手術點數差異";
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

/* -------------刪除離群值 ------------- */
data Term.iprural2;
	set Term.iprural;
	if SGRY_DOT > 34995 then delete;
run;

proc univariate data = Term.iprural2 normal;var SGRY_DOT ;run;

proc ttest data = Term.iprural2  H0 = 4561 ; CLASS RURAL;var SGRY_DOT;run;

/* -------------刪除手術點數為0 資料 ------------- */
data Term.iprural3;
	set Term.iprural2;
	if SGRY_DOT = 0 then delete;
run;

proc univariate data = Term.iprural3 normal;var SGRY_DOT ;run;

/* -------------T TEST ------------- */
proc ttest data = Term.iprural3  H0 = 15304 ; CLASS RURAL;var SGRY_DOT;run;


/* 病患來源 14天內再度看診 */
title "城鄉間再診率差異";
data Term.iprural_14;
	set Term.iprural;
	AGAIN = "";
	if PAT_SOURCE = "4" then AGAIN = "Y";
	else AGAIN = "N";
run;

proc freq data = Term.iprural_14;
	tables RURAL*AGAIN/chisq;
run;

/* 特殊材料點數*/
title "城鄉間特殊點數差異";
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

/* -------------刪除離群值 ------------- */
data Term.ipruralMETR;
	set Term.iprural;
	if METR_DOT > 3246 then delete;
run;

/* -------------刪除手術點數為0 資料 ------------- */
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
