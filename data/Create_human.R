gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
summary(hd)
summary(gii)
glimpse(gii)
glimpse(hd)
str(gii)
str(hd)

#renaming the variables in hd
library(plyr)
hd <- rename(hd, c("Human.Development.Index..HDI."="HDI", "Life.Expectancy.at.Birth"="expe_age","Expected.Years.of.Education"= "exp_education","Mean.Years.of.Education" ="mean_education", "Gross.National.Income..GNI..per.Capita"="GNI","GNI.per.Capita.Rank.Minus.HDI.Rank" ="adj_GNI"  ))
gii <- rename(gii, c("Maternal.Mortality.Ratio"="deaths_mom", "Percent.Representation.in.Parliament"= "women_parliament", "Population.with.Secondary.Education..Female." = "female_secedcu", "Population.with.Secondary.Education..Male."="male_secedu", "Labour.Force.Participation.Rate..Female." = "female_labor", "Labour.Force.Participation.Rate..Male." = "male_labor"))
str(hd)

# Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary 
#education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each 
#country (i.e. labF / labM). (1 point)

#mutating gii data and creating two new variables 1 =  edu2F / edu2M 2 = labF / labM)

gii <- mutate(gii, f2m_ratio_edu = (female_secedcu/male_secedu))
gii <- mutate(gii, f2m_labor = (female_labor/male_labor))
gii$f2m_ratio_edu
gii$f2m_labor

#part 6
#Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). 
#Call the new joined data human and save it in your data folder. (1 point)
# access the dplyr library
library(dplyr)

# choosing the variables by which the joining will be done. 
join_by <- c("Country")

# joingin gii and hd by country
human <- inner_join(suffix = c(".gii",".hd"), gii, hd, b =join_by)

str(human)
getwd()
setwd("IODS-project/data/")
?write.table() 
write.table(human, file = "human.txt", sep = ",", col.names = TRUE)

