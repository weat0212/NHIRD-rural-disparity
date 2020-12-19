
#Export NHIRD dataframe into csv file

month <- c("01","02","03","04","05","06","07","08","09","10","11","12")
group <- c("10","20","30")

outputdir <- "D:/SAS/"
fileformat <- ".csv"

#OPDTE 
for(i in month) {
  for (j in group) {
    filename <- paste("h_nhi_opdte103",i,"_",j, sep = "")
    write.csv(get(filename), paste(outputdir,"OPDTE_CSV/",filename,fileformat, sep = ""), row.names = FALSE)
  }
}


#IPDTE
write.csv(h_nhi_ipdte103, paste(outputdir,"IPDTE_CSV/","h_nhi_ipdte103",fileformat, sep = ""), row.names = FALSE)


#ENROL
for(i in month) {
  filename <- paste("h_nhi_enrol103",i, sep = "")
  write.csv(get(filename), paste(outputdir,"ENROL_CSV/",filename,fileformat, sep = ""), row.names = FALSE)
}


