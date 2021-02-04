################
## Regression ##
################

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Please make sure your csv file contains only numeric variables with headers for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data  below

# To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below

#### Loading Data Set ####

print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

# Linear Regression

lm1 <- lm(data_csv)

summary(lm1)
print(lm1)
####################################