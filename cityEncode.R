<<<<<<< HEAD

# *********************
# **** CITY Encode ****
# *********************

# City Encoding Code

library(dplyr)
library(stringr)

city_encode <- read.csv(file.choose(), header = FALSE, encoding = "UTF-8")

# substring
city_encode <- str_split_fixed(city_encode$V1, " ", 4)
city_encode <- city_encode[,c(1:2)]

# Add rural dataset
rural <- read.csv(file.choose(), header = FALSE, encoding = "BIG5")


=======

# *********************
# **** CITY Encode ****
# *********************

# City Encoding Code

library(dplyr)
library(stringr)

city_encode <- read.csv(file.choose(), header = FALSE, encoding = "UTF-8")

# substring 1.code  2.city 3.post_code 4.some code num
city_encode <- str_split_fixed(city_encode$V1, " ", 4)
city_encode <- city_encode[,c(1:2)]
city_encode <- as.data.frame(city_encode)

# Add rural dataset
rural <- read.csv(file.choose(), header = FALSE, encoding = "BIG5")

# Change encoding
for (col in colnames(rural)){
  Encoding(rural[[col]]) <- "UTF-8"
}


# ---
# flag for rural area
str(rural)  #factor
str(city_encode) #factor

rural <- data.frame(lapply(rural, as.character), stringsAsFactors=FALSE)
city_encode <- data.frame(lapply(city_encode, as.character), stringsAsFactors=FALSE)

area<- city_encode$V2
city_encode$rural <- 0 # default 0

# Overriding
for (r in rural$V2) {
  city_encode$rural[which(grepl(substr(r,0,2), area)==TRUE)] <- 1
}

# num of rarul
length(city_encode$V2) #num = 395
length(which(city_encode$rural==1)) #num = 91

#PROBLEM::Two dataset city name are diff from Area & Town where Government Strategy made

#FIX::Artifical Recongized (臺北市信義區、臺北市大同區、基隆縣信義區、基隆市仁愛區)
city_encode$rural[which(city_encode$V2=="臺北市信義區")] <- 0
city_encode$rural[which(city_encode$V2=="臺北市大同區")] <- 0
city_encode$rural[which(city_encode$V2=="基隆縣信義區")] <- 0
city_encode$rural[which(city_encode$V2=="基隆市仁愛區")] <- 0
# 91 - 3 = 88

names(city_encode) <- c("CITY","city_name","rural")

write.csv(city_encode,"D:/SAS/TermPaper/dataset/city_encode.csv", row.names = FALSE)


>>>>>>> a1643b6 (IPDTE analysis)
