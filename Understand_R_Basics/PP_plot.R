"
1- Please make sure your csv file contains  p-Values as vsriables, with separator ';' .

2- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Columns number where p-values are stored
  
   
3- After providing all the parameters, the code will compute following:
   * PP-Plot
"
#--------------------------------------------------
"Loading Required Packages"
#--------------------------------------------------
if(!require("qualityTools")) install.packages("qualityTools")       #package for PP-plots
library(qualityTools)

# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

#--------------------------------------------------
"Loading Required Parameters"
#--------------------------------------------------
# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
matrix <- read.csv(file.choose(), sep=";", row.names = 1)

#--------------------------------------------------
"Plotting PP-plot"
#--------------------------------------------------
#input number of groups
P_val_col <- as.integer(readline(prompt = "Enter the number of coulumn containing P-Values: "))

#extracting user's column number
p_values <- as.numeric(matrix[,P_val_col])

#Plot p-values
ppPlot(p_values, "normal")         #'p' contains p values resulting from test your are performing
cat("\f")                          # Clear old outputs
warning = FALSE
