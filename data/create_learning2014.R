#Tuomas Soila
#1.2.2017
# #Johdatus yhteiskuntatilastotieteeseen, syksy 2014
#(Introduction to Social Statistics, fall 2014 - in Finnish),
#international survey of Approaches to Learning
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(learning2014)
install.packages("dplyr")
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude","deep","stra","surf","Points")
learning2_2014 <- select(learning2014, one_of(keep_columns))
str(learning2_2014)

learning2_2014 <- subset(learning2_2014, Points>0)
str(learning2_2014)
getwd()

setwd("IODS-project/data/")
?write.csv  
write.csv(learning2_2014, file = "data1.csv")
