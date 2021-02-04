#######################################
## Test for Normality : Shapiro Test ##
#######################################

# Please make sure your csv file contains only numeric variables with headers for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data at " # Test for Normality " below

# To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below

# Shapiro-Wilk Test Result in R :

# * If W is very small then distribution is probably not normal
# * p-value > 0.05 implies that the distribution of the data are not significantly different from normal distribution.

# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Loading Data Set

print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_matrix <- read.csv(data, header = TRUE, sep = ',')

# Test for Normality

for (i in 1:NCOL(data_matrix)) {
  print(shapiro.test(data_matrix[,i]))
}

# Normalization does not change the distribution of a variable. If a variable did not pass test for normality
# before normalization, it would not even after normalization
############################################################################