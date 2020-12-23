# Use the dataset {opdte0110-opdte1210}

library(dplyr)


#====FUNCTION====#

# Divide by gender
# @param ds : dataset
divGender <- function(ds){
  opdte_m <<- ds[which(ds$ID_S == 1),] #m=male
  opdte_f <<- ds[which(ds$ID_S == 2),] #f=female
}

# Count the num of someone seeing the doctor 
# @param ds : dataset
freqOpdte <- function(ds){
  return(tally(group_by(ds, ID)))
}

# Separate rural and urban
sepRural <- function(ds, gender) {
  
  assign(paste("opdte_",gender,"_rural",sep = ""), ds[which(ds$rural==1),], .GlobalEnv)
  assign(paste("opdte_",gender,"_urban",sep = ""), ds[which(ds$rural==0),], .GlobalEnv)
  
}


#====MAIN====#

# Append all opdte
opdte_g10 <- opdte1010

for (m in month) {
  if(m!="01"){
    opdte_g10 <- rbind(opdte_g10, get(paste("opdte",m,"10",sep = "")))
  }
}

# divide dataset into 2 by gender
divGender(opdte_g10)
 
# conversion factor to char
opdte_f$ID <- as.character(opdte_f$ID)
opdte_m$ID <- as.character(opdte_m$ID)

# Separate rural and urban
# 4 datasets will came out
sepRural(opdte_m, "m")
sepRural(opdte_f, "f")

# Group by id and count the frequence of seeing doc
opdte_m_rural_freq <- freqOpdte(opdte_m_rural)
opdte_m_urban_freq <- freqOpdte(opdte_m_urban)
opdte_f_rural_freq <- freqOpdte(opdte_f_rural)
opdte_f_urban_freq <- freqOpdte(opdte_f_urban)

# Analysis the mean times of seeing doctor in a year (only western medicine:10)
mean(opdte_m_rural_freq$n)  # rural male = 7.918573
mean(opdte_m_urban_freq$n)  # urban male = 13.03914
mean(opdte_f_rural_freq$n)  # rural female = 7.921644
mean(opdte_f_urban_freq$n)  # urban female = 14.27477

# t-test 
t.test(opdte_m_rural_freq$n)
t.test(opdte_m_urban_freq$n)
t.test(opdte_f_rural_freq$n)
t.test(opdte_f_urban_freq$n)
