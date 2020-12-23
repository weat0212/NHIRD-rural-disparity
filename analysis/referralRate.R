
# ***********************
# **** Referral Rate ****
# ***********************

month <- c("01","02","03","04","05","06","07","08","09","10","11","12")
group <- c("10","20","30")

# -------------
# IPDTE PART
# -------------

# Referral data
ipdte_rural_ref <- ipdte_rural[ipdte_rural$TRAN_CODE %in% c(6),]  #37

# UNIQUE
length(which(duplicated(ipdte_rural_ref$ID) == TRUE)) #dup : 5

# SUMMARY: 37/2506 = 0.0147(referral rate)
# ---


ipdte_urban_ref <- ipdte_urban[ipdte_urban$TRAN_CODE %in% c(6),] #157
length(which(duplicated(ipdte_urban_ref$ID) == TRUE)) #dup : 36

# SUMMARY: 157/11783 = 0.0133(referral rate)
# ---




# -------------
# OPDTE PART
# -------------


#======FUNCTION======#



# @param loc : location {rural, urban}
# @param mon : month 
# @param grp : group
# @param ref : referral {"Y","N"}
countRefer <- function(loc, mon, grp, ref) {
  df <- get(paste("opdte_", loc, mon, "_",grp, sep = ""))
  
  # 46 PAT_TRAN_OUT :: if patient trans out {Y:N}
  tmp <- df[which(df$PAT_TRAN_OUT == ref),]
  
  # count the num if rural & referral
  if(loc=="rural"){
    rural_refer_count <<- rural_refer_count + nrow(tmp)
  }else{
    urban_refer_count <<- urban_refer_count + nrow(tmp)
  }
  
}


#======Main======#


# Observing data type
str(opdte0110$PAT_TRAN_OUT) #factor

# count the referral num 
rural_refer_count <- 0
urban_refer_count <- 0

for (m in month) {
  for (g in group) {
    countRefer("rural",m,g,"Y")
    countRefer("urban",m,g,"Y")
  }
}
cat("rural & refer =",rural_refer_count,"; urban & refer =", urban_refer_count)
# rural & refer = 375 ; urban & refer = 1712

# count the no referral num 
rural_refer_count <- 0
urban_refer_count <- 0

for (m in month) {
  for (g in group) {
    countRefer("rural",m,g,"N")
    countRefer("urban",m,g,"N")
  }
}

cat("rural & refer =",rural_refer_count,"; urban & refer =", urban_refer_count)

# rural & refer = 327490 ; urban & refer = 1335906
# rural & refer rate =  0.0011; urban & refer rate = 0.0012  


