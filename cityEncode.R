
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


