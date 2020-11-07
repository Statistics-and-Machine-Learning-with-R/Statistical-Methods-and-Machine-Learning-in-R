
#-------------------------------------------------------------------------------------------------------------
                                        "Anosim & Permanova Script Part 1"
#-------------------------------------------------------------------------------------------------------------

# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


                                          " TABLE OF CONTENTS
                                Step 1. Input the matrix
                                Step 2. Significance tests for groups"


#------------------------------------------------
                                             "INSTALL Packages"
#------------------------------------------------


if(!require("miniCRAN")) install.packages("miniCRAN")     # Package for package administration
if(!require("factoextra")) install.packages("factoextra") # Package for multivariate data analysis
if(!require("vegan")) install.packages("vegan")           # Package to check multivariate normal distribution

# Add the associated libraries to the programm
library("miniCRAN")
library("ggpubr")
library("vegan")

#Developers Rules and Classes
# small for Variables
# capital start for functions
# all capital for classes

#------------------------------------------------
                                        "HEADER OF THE SOFTWARE OUTPUT"
#------------------------------------------------

sourceAuthor  <-  "Meta Prot stat Team"
sourceDate    <-  "17.06.2020"
sourceDate    <-  "30.04.2020"
sourceVersion <-  "1.0.5"
testName      <-  'Anosim and Permanova Test'

# Info about the software
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)


#------------------------------------------------
                                      "STEP 0 : Definition of a Subclass"
#------------------------------------------------

# Class for the input file for making objects which are 
#used un 'InputCSV.R' script for inoutting data

setClass(Class="CSV_data",
         representation(
           MATRIX="data.frame",
           VALUES="data.frame",
           RNames = "character",
           CNames = "character"
         )
)

#------------------------------------------------
                                          "STEP 1 : Inputting the matrix"
#------------------------------------------------

#Setting working directory to the folder in which the 'InputCSV.R' and 'Anosim & Permanova' scripts are
                  # setwd('...\\Permanova') {provide link to directory of files}


# 1. Inputting the matrix
source("InputCSV.R")  # Loading 'InputCSV.R' from the working directory

# Separator parameter 
separator = ";"          # Separator based on which we want to separate our data

# Now, selecting our 'Input_file_Anosim&Permanova'
DATA <-  InputData(separator)
NORMDATA <- DATA


#------------------------------------------------
                                         "STEP 2 : Load Classifications"
#------------------------------------------------


# Now, Selecting the grouping file.
print(paste("Please select Grouping CSV", "Care about correct format."), quote = FALSE)
fname <- file.choose()    # select 'Groupings_file_Anosim&Permanova'

groups <- as.matrix(read.csv(fname, sep=separator,row.names=1))

#------------------------------------------------
                                  "STEP 3: Applying significance tests for groups"
#------------------------------------------------

source("Anosim-and-Permanova-2.R")    # It will Load this Script from the folder which is set
                                      # as your working directory.


# Making a binary variable to be used afterwards in running the function 'groupDifferenceData'
performGroupTest <- TRUE

# Select ANOSIM or Permanova Test:
groupSimMethod <- "ANOSIM"           # "PERMANOVA/ ANOSIM

# Number of Permutations we want. Permutations are for shuffling the data in groups
perm  <- 200



# This function will run in 2nd 'Anosim&Permanova-2.R' script
if(performGroupTest){
  NORMDATA <- groupDifferenceData(NORMDATA,groups,groupSimMethod,perm)
}


