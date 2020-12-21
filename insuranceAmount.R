month <- c("01","02","03","04","05","06","07","08","09","10","11","12")

# backup enrol datatset 
for(m in month){

  assign(paste("enrol", m, sep = ""), get(paste("h_nhi_enrol103", m, sep = "")))
}

# for merge use
names(city_encode) <- c("ID1_CITY", "city_name", "rural")

# merge enrol & rural by CITY code
for(m in month){

  # flag {rural=1, city=0}
  assign(paste("enrol", m, sep = ""), merge(get(paste("enrol", m, sep = "")), city_encode, by="ID1_CITY"))
}


#======FUNCTION======#

# @params dt = datatype {"opdte", "ipdte", "enrol"}
# @params mon = month
ruralFilter <- function(dt, mon) {
  
  # use string to get dataframe
  df <- get(paste(dt, mon, sep = ""))
  
  # divide dataset into two by rural & city
  assign(paste(dt,"_rural", mon, sep = ""), 
         df[which(df$rural == 1),], envir = .GlobalEnv)
  assign(paste(dt,"_city", mon, sep = ""), 
         df[which(df$rural == 0),], envir = .GlobalEnv)
}

#======MAIN======#

for (m in month) {
  
  ruralFilter("enrol", m)
}

rural_ins_amount <- 0
city_ins_amount <- 0

for (m in month) {
  tmp1 <- get(paste("enrol_rural", m, sep = ""))
  tmp2 <- get(paste("enrol_city", m, sep = ""))
  
  rural_ins_amount <- rural_ins_amount + sum(tmp1$ID1_AMT) 
  city_ins_amount <- city_ins_amount + sum(tmp2$ID1_AMT)
}

cat("rural insurance fee amount=", rural_ins_amount, "city insurance fee amount =", city_ins_amount)
#rural insurance fee amount= 1125673216 ; city insurance fee amount = 24367464841
