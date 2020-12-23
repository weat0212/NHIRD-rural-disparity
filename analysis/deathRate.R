

# find the death data 
length(which(ipdte_rural$TRAN_CODE == 4))

# num of death in rural = 58

length(which(ipdte_urban$TRAN_CODE == 4))

# num of death in urban = 232


# Diagram 
# **NOT COMPLETE**
tmp <- data.frame(c("Rural", "Urban"), c(58, 232))
names(tmp) <- c("type", "number")


