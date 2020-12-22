
# flag for rural area
str(rural)  #factor
str(city_code) #factor

# factor to string type
rural <- data.frame(lapply(rural, as.character), stringsAsFactors=FALSE)
city_code <- data.frame(lapply(city_code, as.character), stringsAsFactors=FALSE)

area<- city_code$V2
city_code$rural <- 0 # default set 0

# Overriding -> if rarual then set 1
for (r in rural$V2) {
  city_code$rural[which(grepl(substr(r,0,2), area)==TRUE)] <- 1
}

# num of rarul
length(city_code$V2) #num = 395
length(which(city_code$rural==1)) #num = 91

#PROBLEM::Two dataset city name are diff from Area & Town where Government Strategy made

#FIX::Artifical Recongized (臺北市信義區、臺北市大同區、基隆縣信義區、基隆市仁愛區)
city_code$rural[which(city_code$V2=="臺北市信義區")] <- 0
city_code$rural[which(city_code$V2=="臺北市大同區")] <- 0
city_code$rural[which(city_code$V2=="基隆縣信義區")] <- 0
city_code$rural[which(city_code$V2=="基隆市仁愛區")] <- 0

# Rename column
names(city_code) <- c("CITY","city_name","rural")

write.csv(city_code,"D:/SAS/TermPaper/dataset/city_code.csv", row.names = FALSE)