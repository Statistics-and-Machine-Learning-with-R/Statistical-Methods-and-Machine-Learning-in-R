#################
## Correlation ##
#################

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Please make sure your csv file contains only numeric variables with headers for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data at below

# To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below

#### Parameters ####

# Method can be "kendall", "pearson" or "spearman"
# Correlation_Test_k contains the "kendall" correlation values
# Correlation_Test_p contains the "pearson" correlation values
# Correlation_Test_s contains the "spearman" correlation values

# Loading Data Set

print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

# Correlation

# use = "complete.obs" when you have missing values
# use = "all.obs" when you DO NOT have missing values
Correlation_Test_k <- cor(data_csv, method = "kendall", use = "all.obs")
Correlation_Test_p <- cor(data_csv, method = "pearson", use = "all.obs")
Correlation_Test_s <- cor(data_csv, method = "spearman", use = "all.obs")

View(Correlation_Test_k)
View(Correlation_Test_p)
View(Correlation_Test_s)

#################################################################################
