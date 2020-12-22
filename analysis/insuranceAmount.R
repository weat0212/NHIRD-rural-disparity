month <- c("01","02","03","04","05","06","07","08","09","10","11","12")

#======FUNCTION======#




# @params dt = datatype {"opdte", "ipdte", "enrol"}
# @params mon = month
ruralFilter <- function(dt, mon) {
  
  # use string to get dataframe
  df <- get(paste(dt, mon, sep = ""))
  
  # divide dataset into two by rural & urban
  assign(paste(dt,"_rural", mon, sep = ""), 
         df[which(df$rural == 1),], envir = .GlobalEnv)
  assign(paste(dt,"_urban", mon, sep = ""), 
         df[which(df$rural == 0),], envir = .GlobalEnv)
}

#======MAIN======#

for (m in month) {
  
  ruralFilter("enrol", m)
}

rural_ins_amount <- 0
urban_ins_amount <- 0

for (m in month) {
  tmp1 <- get(paste("enrol_rural", m, sep = ""))
  tmp2 <- get(paste("enrol_urban", m, sep = ""))
  
  rural_ins_amount <- rural_ins_amount + sum(tmp1$ID1_AMT) 
  urban_ins_amount <- urban_ins_amount + sum(tmp2$ID1_AMT)
}

cat("rural insurance fee amount=", rural_ins_amount, "urban insurance fee amount =", urban_ins_amount)
#rural insurance fee amount= 1125673216 ; urban insurance fee amount = 24367464841
