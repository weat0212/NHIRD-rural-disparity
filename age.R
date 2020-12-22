

# @params d = datatype {enrol, opdte, ipdte}
# @params loc = location {rural, city}
# @params m = month
getDf <- function(d, loc, m) {
  
  fileName <- paste(d, "_", loc, m, sep = "")
  df <- get(fileName)
  return(df)
}


# @params d = datatype {enrol, opdte, ipdte}
# @params loc = location {rural, city}
# @params m = month
calAge <- function(d, loc, m) {
  
  df <- getDf(d, loc, m)
  df$ID_BIRTH_Y <- as.integer(as.character(df$ID_BIRTH_Y))
  
  
  if(loc == "city"){
    df$age <- (2014 - df$ID_BIRTH_Y)
  }else{
    df$age <- (2014 - df$ID_BIRTH_Y)
  }
  return(df)
}

# @params d = datatype {enrol, opdte, ipdte}
# @params loc = location {rural, city}
# @params m = month
calMean <- function(dt, loc, m) {
  tmp <- get(paste(dt,"_",loc,m,sep = ""))
  return(mean(tmp$age))
}


# ===========MAIN=============

for (m in month) {
  
  assign(paste("enrol_city",m,sep = ""), calAge("enrol", "city", m))
  assign(paste("enrol_rural",m,sep = ""), calAge("enrol", "rural", m))
}

for (m in month) {
  
  cat("enrol_rural",m," = ",calMean("enrol", "rural", m),"\n")
  cat("enrol_city",m," = ",calMean("enrol", "city", m),"\n")
  
}
# rural mean age ~= 42
# city mean age ~= 39