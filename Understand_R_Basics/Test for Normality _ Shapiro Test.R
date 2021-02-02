#######################################
## Test for Normality : Shapiro Test ##
#######################################

# Please make sure your csv file contains only numeric variables for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data at " # Test for Normality " below

# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Loading Data Set

print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

# Creating a Data Matrix

data_matrix <- as.numeric(unlist(data_csv))
data_matrix <- as.data.frame(data_csv)

# Test for Normality

for (i in 1:NCOL(data_matrix)) {
  print(shapiro.test(data_matrix[,i]))
}

# Normalization does not change the distribution of a variable. If a variable did not pass test for normality
# before normalization, it would not even after normalization
############################################################################