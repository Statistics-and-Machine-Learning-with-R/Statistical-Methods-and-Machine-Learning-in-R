"

1- Please know that you will need following files for this script
   a- Anosim_and_Permanova_2.R file
   b- Input_file_Anosim&Permanova.CSV
   c- Groupings_file_Anosim&Permanova.CSV

2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
which will be asked on running the code in the CONSOLE screen. In this case select:
  
  a- Select first Input_file_Anosim&Permanova.CSV as your Input file when your are asked to select Input file
  b- Then, select Groupings_file_Anosim&Permanova.CSV, when you are asked to select the Groupings file
  b- Select whether you want to perform anosim or Permanova 

3- After providing all the parameters, the code will compute following:
  
  * P and R values of Anosim      OR
  * P and R values of Permanova
  * Save the results in the working directory

"
# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
"REQUIRED PACKAGES FOR ANOSIM And PERMANOVA"
#------------------------------------------------

#Installing  Packages
if(!require("miniCRAN")) install.packages("miniCRAN")     # Package for package administration
if(!require("factoextra")) install.packages("factoextra") # Package for multivariate data analysis
if(!require("vegan")) install.packages("vegan")           # Package to check multivariate normal distribution

# Add the associated libraries to the programm
library("miniCRAN")
library("ggpubr")
library("vegan")


#Set your working directory to the folder in which the 'Anosim_and_Permanova_2.R is located

# Class for the input file for making objects which are 
setClass(Class="CSV_data",
         representation(
           MATRIX="data.frame",
           VALUES="data.frame",
           RNames = "character",
           CNames = "character"
         )
)

#------------------------------------------------
#------------------------------------------------
"STEP 1 : Inputting the matrix"
#------------------------------------------------

# Separator parameter 
SEPARATOR = ";"          # Separator based on which we want to separate our data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows.
            Here we choose our Input file: Input_file_Anosim&Permanova.csv"), quote = FALSE)

matrix <- read.csv(file.choose(), sep = SEPARATOR,row.names=1)
values <- matrix[2:nrow(matrix),2:ncol(matrix)]
rNames <- row.names(matrix)
cNames <- colnames(matrix)
fname  <- new("CSV_data", MATRIX = matrix, VALUES = values, RNames = rNames, CNames = cNames )
NORMDATA <- fname

#------------------------------------------------
"STEP 2 : Load Classifications"
#------------------------------------------------

# Now, Selecting the grouping file.
print(paste("Please select Grouping CSV", "Care about correct format."), quote = FALSE)
fname <- file.choose()    # select 'Groupings_file_Anosim&Permanova'
groups <- as.matrix(read.csv(fname, sep=SEPARATOR,row.names=1))

#------------------------------------------------
"STEP 3: Applying significance tests for groups"
#------------------------------------------------

source("Anosim_and_Permanova_2.R")    #It will Load this Script from the folder which is set
#as your working directory.

#Making a binary variable to be used afterwards in running the function 'groupDifferenceData'
performGroupTest <- TRUE

#Select ANOSIM or PERMANOVA Test:
groupSimMethod <- readline(prompt = "Write anosim for Performing ANOSIM test and panova for performing PERMANOVA test   :")

#Number of Permutations we want. Permutations are for shuffling the data in groups
perm  <- 200

#This function will run in 2nd 'Anosim_and_Permanova_2.R' script
if(performGroupTest){
  NORMDATA <- groupDifferenceData(NORMDATA,groups,groupSimMethod,perm)
}
