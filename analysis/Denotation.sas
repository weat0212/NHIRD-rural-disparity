/* 1�G�v���X�| 2�G�~���| 3�G����E�v�� 4�G���` 5�G�@��۰ʥX�| 6�G��| */
data Term.ipdte_3;
 set Term.ipdte_2;
 TRAN_STATUS = "";
 if TRAN_CODE = "6" then TRAN_STATUS = 1;
 else if TRAN_CODE = "4" then TRAN_STATUS = 2;
 else if TRAN_CODE  in ("1""2","3","5") then TRAN_STATUS = 3;
 else  delete;
run;

/* ��ʯf�I�� */
proc means data =  Term.ipdte_3;
 var EB_APPL30_DOT;
 output out = Term.EBoutlier p25 = p25  p75 = p75;
run;

data Term.EBdatainfo;
 set Term.EBoutlier;
 IQR3=3*(p75-p25);
 call symputx('IQR3',IQR3); 
 call symputx('p75',p75);
 call symputx('p25',p25);
run;

data Term.ipdte_4;
 set Term.ipdte_3;
 if EB_APPL30_DOT > 113118 then delete;
run;

data Term.ipdte_5;
 set Term.ipdte_4;
 DOT_LEVEL = .;
 if EB_APPL30_DOT < 14853 then DOT_LEVEL = 1;
 else if EB_APPL30_DOT >14853 and EB_APPL30_DOT<46278 then DOT_LEVEL = 2;
 else if EB_APPL30_DOT >46278 and EB_APPL30_DOT<52559 then DOT_LEVEL = 3;
 else if EB_APPL30_DOT >52559 then DOT_LEVEL = 4;
run;

proc freq data = Term.ipdte_5;
 tables RURAL*DOT_LEVEL/chisq;
run;