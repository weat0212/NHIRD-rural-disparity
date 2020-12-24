
# if or not referral
# Rural
# Urban


chisq.test(ipdte[which(ipdte$TRAN_CODE==6),],ipdte[which(ipdte$rural==1),], ipdte[which(ipdte$rural==0),])
