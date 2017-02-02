learning2014 <- read.csv("/Users/Tuomassoila/IODS-project/data/data1.csv")
learning2014
str(learning2014)


library(ggplot2)
library(GGally)

str(learning2014$age)
p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower =  list(combo =wrap("facethist",bins =20)))
p


my_model <- lm(Points ~ stra + Attitude + Age, data = learning2014 )
summary(my_model)


par(mfrow = c(2,2))
plot(my_model, which=c(1,2,5))