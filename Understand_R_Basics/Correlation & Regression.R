
##############################
## Correlation & Regression ##
##############################


# Cleaning the workspace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Creating a data matrix

data_matrix <- as.data.frame(iris)
data_matrix


#-------------------------------------------------------------------------------
" Correlation"
#-------------------------------------------------------------------------------


# and converts the factors into numeric value

cor(data_matrix$Sepal.Length, data_matrix$Sepal.Width, method = c("pearson"))        # checks the correlation between columns based on  "Pearson" method.

cor(data_matrix$Petal.Length, data_matrix$Petal.Width, method = c("pearson"))


#-------------------------------------------------------------------------------
" Regression"
#-------------------------------------------------------------------------------


m1 <- lm(data_matrix$Sepal.Length ~ data_matrix$Sepal.Width)                      # function "lm" creates the regression line
# based on the passed value (age ~ height)
summary(m1)


m2 <- lm(data_matrix$Petal.Length ~ data_matrix$Petal.Width) 
summary(m2)

#-------------------------------------------------------------------------------
"Installing necessary packages to visualize"
#-------------------------------------------------------------------------------

if(!require("ggplot2")) install.packages("ggplot2")         # For visualization
library("ggplot2")


#-------------------------------------------------------------------------------
"Visualization : Correlation + Regression"
#-------------------------------------------------------------------------------

ggplot(data_matrix, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point() + geom_smooth()    # scatter plot with local regression
ggplot(data_matrix, aes(x=Petal.Length, y=Petal.Width)) + geom_point() + geom_smooth(method = lm)    # scatter plot with linear regression & confidence interval


#################################################################################











