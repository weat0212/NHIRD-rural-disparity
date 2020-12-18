#install.packages("sas7bdat")
#install.packages("haven")

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
  for (j in group) {
    infile <- paste(filepath,"Health-01/","h_nhi_opdte103",i,"_",j,".sas7bdat", sep = "")
    filename <- paste("h_nhi_opdte103",i,"_",j, sep = "")
    assign(filename, read.sas7bdat(infile)) 
  }
}


#IPDTE
infile <- paste(filepath,"Health-02/","h_nhi_ipdte103",".sas7bdat", sep = "")
assign("h_nhi_ipdte103", read.sas7bdat(infile)) 


#ENROL
for(i in month) {
  infile <- paste(filepath,"Health-07/","h_nhi_enrol103",i,".sas7bdat", sep = "")
  filename <- paste("h_nhi_enrol103",i, sep = "")
  assign(filename, read.sas7bdat(infile))
}


