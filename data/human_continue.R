#Data wrangling exercise week 5. 
#accessing the data 
#Author: Tuomas Soila 
#Data soure : http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
  
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",", header = T)
str(human$GNI)
library(dplyr); library(ggplot2);library(stringr)

# Mutating the data: transforming the Gross National Income (GNI) variable to numeric (Using string manipulation.
str_replace(human$gni, pattern=",", replace="") %>% as.numeric
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric )
str(human)

#Excluding unneeded variables: keeping only the columns matching the following variable names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F".
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
#Only keepeing the aforementioned variables and observations with data in them.  
human <- select(human, one_of(keep))
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human) == TRUE)
str(human_)
human_

#Removing the observations which relate to regions instead of countries. (1 point)
last <- nrow(human_) - 7
human_
# choose everything until the last 7 observations
human_ <- human_[1:last, ]

#Defining the row names of the data by the country names and removing the country name column from the data. 
# add countries as rownames
rownames(human_) <- human_$Country
human_ <- select(human_, -Country)
str(human_)
write.table(human_, file = "human.txt", sep = ",", col.names = TRUE)
