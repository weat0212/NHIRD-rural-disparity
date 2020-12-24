month <- c("01","02","03","04","05","06","07","08","09","10","11","12")

#======FUNCTION======#




#======MAIN======#


rural_ins_amount <- 0
urban_ins_amount <- 0

for (m in month) {
  tmp1 <- get(paste("enrol_rural", m, sep = ""))
  tmp2 <- get(paste("enrol_urban", m, sep = ""))
  
  rural_ins_amount <- rural_ins_amount + sum(tmp1$ID1_AMT) 
  urban_ins_amount <- urban_ins_amount + sum(tmp2$ID1_AMT)
}

cat("rural insurance fee amount=", rural_ins_amount, "urban insurance fee amount =", urban_ins_amount)
# rural insurance fee amount in a year = 7,598,215,831 ; urban insurance fee amount in a year = 26,448,210,780
# ---


# Average amount of insurance fee per person comparison between Rural and Urban
for (m in month) {
  
}

