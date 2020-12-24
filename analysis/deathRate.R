

# find the death data 
length(which(ipdte_rural$TRAN_CODE == 4))

# num of death in rural = 58
# 58/2506=0.0231

length(which(ipdte_urban$TRAN_CODE == 4))

# num of death in urban = 232
# 232/11783=0.0196



# Diagram 
# **NOT COMPLETE**
tmp <- data.frame(c("Rural", "Urban"), c(58, 232))
names(tmp) <- c("type", "number")


