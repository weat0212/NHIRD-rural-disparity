
# ***********************
# **** Referral Rate ****
# ***********************

month <- c("01","02","03","04","05","06","07","08","09","10","11","12")
group <- c("10","20","30")

# -------------
# IPDTE PART
# -------------
# RURAL
missing(ipdte) # FALSE

# See the form of data
summary(h_nhi_ipdte103)

# Left outer join
names(city_encode) <- c("CITY", "city_name", "rural")
ipdte <- merge(h_nhi_ipdte103, city_encode, by = "CITY", all.x = TRUE)
is.null(ipdte$city_name) # FALSE

# Filtering the data where the hospital are rural area
ipdte_rural <- ipdte[which(ipdte$rural == 1),] # 690 data
length(which(duplicated(ipdte_rural$ID) == TRUE))# duplicate 314
# Referral data
ipdte_rural_ref <- ipdte_rural[ipdte_rural$TRAN_CODE %in% c(6),] # 10
# UNIQUE
length(which(duplicated(ipdte_rural_ref$ID) == TRUE)) #duplicate 1

# SUMMARY: 10 / 690 = 0.015 or (10-1)/(690-314) = 0.024
# ---

# CITY 
ipdte_city <- ipdte[which(ipdte$rural == 0),] #8692
length(which(duplicated(ipdte_city$ID) == TRUE)) # duplicate 3694
ipdte_city_ref <- ipdte_city[ipdte_city$TRAN_CODE %in% c(6),] #102
length(which(duplicated(ipdte_city_ref$ID) == TRUE)) # duplicate 19

# SUMMARY: 102 / 8692 = 0.011 or (102-19)/(8692-3694) = 0.017
# ---




# -------------
# OPDTE PART
# -------------


# See the form of data
summary(h_nhi_opdte10301_10)

#======FUNCTION======#
# This is a funtion to merge every opdte file with city in rural
# @param mon : month 
# @param grp : group
loadOpdte <- function(mon, grp) {
  file_name <- paste("opdte", mon, grp, sep = "")
  
  assign(file_name, merge(get(paste("h_nhi_opdte103", mon, "_", grp, sep = "")), 
                          city_encode, by = "CITY", all.x = TRUE), envir = .GlobalEnv)

}

# function
# @param mon : month 
# @param grp : group
ruralFilter <- function(mon, grp) {
  
  # use string to get dataframe
  df <- get(paste("opdte", mon, grp, sep = ""))
  
  # divide dataset into two by rural & city
  assign(paste("opdte_rural", mon, "_", grp, sep = ""), 
         df[which(df$rural == 1),], envir = .GlobalEnv)
  assign(paste("opdte_city", mon, "_", grp, sep = ""), 
         df[which(df$rural == 0),], envir = .GlobalEnv)
}

# @param loc : location {rural, city}
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
    city_refer_count <<- city_refer_count + nrow(tmp)
  }
  
}


#======Main======#

# backup & merge
# rural & city separate
for (m in month) {
  for (g in group) {
    loadOpdte(m, g)
    ruralFilter(m, g)
  }
}

# Observing data type
str(opdte0110$PAT_TRAN_OUT) #factor

# count the referral num 
rural_refer_count <- 0
city_refer_count <- 0

for (m in month) {
  for (g in group) {
    countRefer("rural",m,g,"Y")
    countRefer("city",m,g,"Y")
  }
}
cat("rural & refer =",rural_refer_count,"; city & refer =", city_refer_count)

# count the no referral num 
rural_refer_count <- 0
city_refer_count <- 0

for (m in month) {
  for (g in group) {
    countRefer("rural",m,g,"N")
    countRefer("city",m,g,"N")
  }
}

cat("rural & refer =",rural_refer_count,"; city & refer =", city_refer_count)

# rural & refer = 148
# city & refer = 1246
# rural population = 66270 + 148 = 66418
# city population = 1023009 + 1246 = 1024255
# rural referral rate = 0.002228
# city referral rate = 0.0012164


