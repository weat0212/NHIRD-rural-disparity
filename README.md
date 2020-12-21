# nhird-rural-disparity
分析偏鄉地區醫療平等問題。利用醫療利用率、轉診率了解偏鄉地區醫療資源分配是否不均，並且採用健保投保總額依據地區分配來調查是否屬實。

### readSAS7bdat.R
讀sas7dbat檔

### exportCsv.R
將NHIRD資料集輸出成csv檔

### cityEncode.R
將資料集中的encode.csv整理為city_encode.csv檔，並與rural_area.csv做歸人合併

### referralRate.R
OPDTE&IPDTE與偏鄉地區資料集以CITY鍵做歸人，計算出OPDTE&IPDTE的轉診率

