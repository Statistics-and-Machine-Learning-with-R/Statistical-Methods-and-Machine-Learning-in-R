######################################
## QQ Plot : Quantile-Quantile Plot ##
######################################

# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Creating a data matrix

data_matrix <- as.data.frame(iris)
data_matrix

## Q-Q Plot (Quantile-Quantile Plot) : To check for Normal Distribution
qqnorm(data_matrix$Sepal.Length)                            # plots the points
qqline(data_matrix$Sepal.Length, col = "blue")              # plots the line

qqnorm(data_matrix$Sepal.Width)                            # plots the points
qqline(data_matrix$Sepal.Width, col = "blue")              # plots the line

qqnorm(data_matrix$Petal.Length)                            # plots the points
qqline(data_matrix$Petal.Length, col = "blue")              # plots the line

qqnorm(data_matrix$Petal.Width)                            # plots the points
qqline(data_matrix$Petal.Width, col = "blue")              # plots the line

##############################################################################