
# divid data into rural and urban

month <- c("01","02","03","04","05","06","07","08","09","10","11","12")
group <- c("10","20","30")


#========function========#

# Merge every dataset with CITY to came up rural remark
# This is a funtion to merge every opdte file with city in rural
# @param mon : month 
# @param grp : group
mergeOpdte <- function(mon, grp) {
  file_name <- paste("opdte", mon, grp, sep = "")
  
  assign(file_name, merge(get(paste("h_nhi_opdte103", mon, "_", grp, sep = "")), 
                          city_code_flag, by = "CITY", all.x = TRUE), envir = .GlobalEnv)
  
}


# Divide dataset into rural and urban
# @param mon : month 
# @param grp : group
sepOpdte <- function(mon, grp) {
  
  # use string to get dataframe
  df <- get(paste("opdte", mon, grp, sep = ""))
  
  # divide dataset into two by rural & city
  assign(paste("opdte_rural", mon, "_", grp, sep = ""), 
         df[which(df$rural == 1),], envir = .GlobalEnv)
  assign(paste("opdte_urban", mon, "_", grp, sep = ""), 
         df[which(df$rural == 0),], envir = .GlobalEnv)
}

# Divide dataset into rural and urban
# @param mon : month 
# @param grp : group
sepEnrol <- function(mon) {
  
  # use string to get dataframe
  df <- get(paste("enrol", mon, sep = ""))
  
  # divide dataset into two by rural & city
  assign(paste("enrol_rural", mon, sep = ""), 
         df[which(df$rural == 1),], envir = .GlobalEnv)
  assign(paste("enrol_urban", mon, sep = ""), 
         df[which(df$rural == 0),], envir = .GlobalEnv)
}




#======Main======#

# See the form of data
summary(h_nhi_ipdte103)
# See the form of data
summary(h_nhi_opdte10301_10)

# backup & merge IPDTE
ipdte <- merge(h_nhi_ipdte103, city_code_flag, by = "CITY", all.x = TRUE)
which(is.na(ipdte$rural)) # 8 missing data

# Separate the data where the hospital are rural and urban IPDTE
ipdte_rural <- ipdte[which(ipdte$rural == 1),]
cat("IPDTE duplicate rural obs = ", length(which(duplicated(ipdte_rural$ID) == TRUE))) # 891

ipdte_urban <- ipdte[which(ipdte$rural == 0),] 
cat("IPDTE duplicate urban obs = ", length(which(duplicated(ipdte_urban$ID) == TRUE))) # 5068


# backup & merge OPDTE
# separate rural & urban
for (m in month) {
  for (g in group) {
    mergeOpdte(m, g)
    sepOpdte(m, g)
  }
}

names(city_code_flag) <- c("ID1_CITY","city_name","rural")

# backup ENROL datatset 
for(m in month){
  assign(paste("enrol", m, sep = ""), get(paste("h_nhi_enrol103", m, sep = "")))
}


# merge enrol & rural by CITY code
for(m in month){
  
  # flag {rural=1, urban=0}
  assign(paste("enrol", m, sep = ""), merge(get(paste("enrol", m, sep = "")), 
                                            city_code_flag, by="ID1_CITY", all.x = TRUE))
}

for (m in month) {
  sepEnrol(m)
}
