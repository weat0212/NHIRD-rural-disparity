

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
    
  }else{
    
  }
  
}

