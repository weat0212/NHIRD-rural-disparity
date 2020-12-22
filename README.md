# nhird-rural-disparity
分析偏鄉地區醫療平等問題。利用醫療利用率、轉診率了解偏鄉地區醫療資源分配是否不均，並且採用健保投保總額依據地區分配來調查是否屬實。


## readwrite package
### readSAS7bdat.R
讀sas7dbat檔

### exportCsv.R
將NHIRD資料集輸出成csv檔

### cityEncode99_104
將城市編碼依正確的資料集分類

## ruralcity package
### divide.R
將OPDTE、IPDTE、ENROL檔依城市、偏鄉篩出兩個檔

### cityEncode.R
將資料集中的encode.csv整理為city_encode.csv檔，並與rural_area.csv做歸人合併

## dataset package
儲存所要用到的csv檔

## analysis package
### referralRate.R
OPDTE&IPDTE與偏鄉地區資料集以CITY鍵做歸人，計算出OPDTE&IPDTE的轉診率

###deathRate.R
檢測死亡率

###age.R
算出平均年齡層

###insuranceAmount.R
算出健保繳費金額

###admissonDays.R
住院天數計算

###seeDocFreq.R
計算看診次數
