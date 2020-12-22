outputdir <- "D:/SAS/Termpaper/"
fileformat <- ".csv"

exportCsv <- function(dt,loc, m, g) {
  
  if(dt == "enrol"){
    fileName <- paste(dt, "_", loc, m, sep = "")
    write.csv(get(fileName), paste(outputdir,fileName,fileformat, sep = ""), row.names = FALSE)
  }else if(dt == "opdte"){
    fileName <- paste(dt, "_", loc, m, "_", g, sep = "")
    write.csv(get(fileName), paste(outputdir,fileName,fileformat, sep = ""), row.names = FALSE)
  }
}


for (m in month) {
  for (g in group) {
    exportCsv("opdte", "urban", m, g)
    exportCsv("opdte", "rural", m, g)
    
    exportCsv("enrol", "urban", m)
    exportCsv("enrol", "rural", m)
  }
}



write.csv(ipdte_urban, "D:/SAS/Termpaper/ipdte_urban.csv", row.names = FALSE)
write.csv(ipdte_rural, "D:/SAS/Termpaper/ipdte_rural.csv", row.names = FALSE)
