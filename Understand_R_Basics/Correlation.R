#################
## Correlation ##
#################

# Please make sure your csv file contains only numeric variables for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data at " # Plotting QQ Plots " below

# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Loading Data Set

print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

# Correlation

# method can be "kendall", "pearson" or "spearman"

MethodforCorTest <- readline(prompt = "Enter the method you want to use: kendall, pearson or spearman: ")

print(MethodforCorTest)

# use = "complete.obs" when you have missing values
# use = "all.obs" when you DO NOT have missing values
Correlation_Test <- cor(data_csv, method = MethodforCorTest, use = "all.obs")

View(Correlation_Test)

#################################################################################
