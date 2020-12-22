
# flag for rural area
str(rural)  #factor
str(city_code) #factor

# factor to string type
rural <- data.frame(lapply(rural, as.character), stringsAsFactors=FALSE)
city_code <- data.frame(lapply(city_code, as.character), stringsAsFactors=FALSE)


city_code_flag <- city_code

area<- city_code_flag$city_name
city_code_flag$rural <- 0 # default set 0

# Overriding -> if rarual then set 1
for (r in rural$V2) {
  city_code_flag$rural[which(grepl(substr(r,0,2), area)==TRUE)] <- 1
}

# num of rarul
length(city_code_flag$city_name) #num = 373
length(which(city_code_flag$rural==1)) #num = 90

#PROBLEM::Two dataset city name are diff from Area & Town where Government Strategy made

#FIX::Artifical Recongized (臺北市信義區、臺北市大同區、基隆縣信義區、基隆市仁愛區)
city_code_flag$rural[which(city_code_flag$city_name=="臺北市信義區")] <- 00
city_code_flag$rural[which(city_code_flag$city_name=="臺北市大同區")] <- 0
city_code_flag$rural[which(city_code_flag$city_name=="基隆縣信義區")] <- 0
city_code_flag$rural[which(city_code_flag$city_name=="基隆市仁愛區")] <- 0

# Rename column
names(city_code_flag) <- c("CITY","city_name","rural")

write.csv(city_code_flag,"D:/SAS/TermPaper/dataset/city_code_flag.csv", row.names = FALSE)
