
# for dataset between 99th-104th year of the "Republic Era"

library(stringr)

city_code <- read.csv("D:/SAS/TermPaper/dataset/cityCode.csv", header = FALSE, encoding = "BIG5")

# Add two col for odd even value
city_code$CITY <- city_code[c(FALSE,TRUE),]  # odd rows
city_code <- city_code[c(TRUE,FALSE),]  # odd rows

# rename
names(city_code) <- c("CITY", "city_name")

# Padding code with 0 in the front of CITY
city_code$CITY <- str_pad(city_code$CITY, 4, pad = "0")

city_code <- city_code[which(!duplicated(city_code$CITY)),]
