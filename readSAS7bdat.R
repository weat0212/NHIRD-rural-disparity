install.packages("sas7bdat")
install.packages("haven")

library("sas7bdat")
library("haven")


#Dataset : OPDTE、IPDTE、ENROL、衛福部資料集

month <- c("01","02","03","04","05","06","07","08","09","10","11","12")
group <- c("10","20","30")

filepath <- "D:/SAS/"

#*****************
#****Read File****
#*****************

#OPDTE 
for(i in month) {
  infile <- paste("D:/SAS/Health-01/","h_nhi_opdte103",i,"_10",".sas7bdat", sep = "")
  filename <- paste("h_nhi_opdte103",i,"_10", sep = "")
  assign(filename, read.sas7bdat(infile))
}

#IPDTE
h_nhi_ipdte103 <- paste("D:/SAS/Health-02/","h_nhi_ipdte103",".sas7bdat", sep = "")

#ENROL
for(i in month) {
  infile <- paste("D:/SAS/Health-07/","h_nhi_enrol103",i,".sas7bdat", sep = "")
  filename <- paste("h_nhi_enrol103",i, sep = "")
  assign(filename, read.sas7bdat(infile))
}

