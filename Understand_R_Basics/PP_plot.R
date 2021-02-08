if(!require("qualityTools")) install.packages("qualityTools")       #package for PP-plots
library(qualityTools)

# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
matrix <- read.csv(file.choose(), sep=";", row.names = 1)


#input number of groups
P_val_col <- as.integer(readline(prompt = "Enter the number of coulumn containing P-Values: "))

#extracting user's column number
p_values <- as.numeric(matrix[,P_val_col])

#Plot p-values
ppPlot(p_values, "normal")         #'p' contains p values resulting from test your are performing

cat("\f")       # Clear old outputs

warning = FALSE
