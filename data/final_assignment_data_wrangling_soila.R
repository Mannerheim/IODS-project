#Author: Tuomas Soila
#Date 01.03.2017
#Creating the dataset to be analysed in the final assignment. My dataset will be the student alchol consumption.

#readint the data from the source with ; as separator and headers. 
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
alc <- dplyr::select(mat_por, one_of(join_by)) #crea<tes a new dataframe
#choosing the columns that were not used for joining
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]


for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- dplyr::select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- dplyr::select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- dplyr::select(two_columns, 1)[1]
  }
}

glimpse(alc)
library(dplyr); library(ggplot2)

#looking into the dataframe

#saving the data 
setwd("IODS-project/data/")

write.table(alc, file = "alc_use_final_assignment.txt", sep = ",", col.names = TRUE)
