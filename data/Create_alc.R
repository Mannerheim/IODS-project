# Name: Tuomas Soila 
# Date: 08.02.2017
# Creating the dataset for Studying alcohol consumption by using logistic regression. Data is taken from https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION 

#reading the data from data-folder
por <- read.csv("/Users/Tuomassoila/IODS-project/data/student-por.csv", sep = ";" , header=TRUE)
mat <- read.csv("/Users/Tuomassoila/IODS-project/data/student-mat.csv", sep = ";" , header=TRUE)

#printing summaries
str(mat)
str(por)
colnames(mat)
colnames(por)

#choosing the columbs by which the data will be put together
library(dplyr)
join_by <- c("sex","age","address","famsize", "Pstatus","Medu", "Fedu", "Mjob","Fjob","reason", "nursery", "internet")
#creating the new data object mat_por, which includes both data
mat_por <- inner_join(suffix=c(".mat",".por"), mat, por, by = join_by)
#overviewing the data
colnames(mat_por)
glimpse(mat_por)

#removing the duplicates
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by)) #crea<tes a new dataframe
#choosing the columns that were not used for joining
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]


for (column_name in notjoined_columns){                   # for every column name not used for joining.
  two_columns <- select(mat_por, starts_with(column_name)) #create new variable with the two columns with the same name
  first_column <- select(two_columns, 1)[[1]]         #select the first column vector of these columns 
  if (is.numeric(first_column)){                      # if it is numeric
    alc[column_name] <- round(rowMeans(two_columns))  # take rounded average of the two and it do alc data frame
  }else { 
    alc[column_name]<-select(two_columns, 1)[1]       # if not add the first columng vector to alc data frame 
  }
}

glimpse(alc)
library(dplyr); library(ggplot2)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)
high_use

glimpse(alc)
setwd("IODS-project/data/")
?write.table() 
write.table(alc, file = "alc_use_por_mat.txt", sep = ",", col.names = TRUE)
