################################################################################
#                         Anosim & Permanova Script Part 1

# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables
################################################################################



# TABLE OF CONTENTs
# Step 1. Input the matrix
# Step 2. Significance tests for groups

#*****Install Packages*****************************************
'While the first run certain subpackages have to be installed'
# *************************************************************
# Package for package administration
if(!require("miniCRAN")) install.packages("miniCRAN") 
# Package for multivariate data analysis
if(!require("factoextra")) install.packages("factoextra") 
# Package to check multivariate normal distribution
if(!require("vegan")) install.packages("vegan") 

# Add the associated libraries to the programm
library("miniCRAN")
library("ggpubr")
library("vegan")

#Developers Rules and Classes
# small for Variables
# capital start for functions
# all capital for classes

###############################################
# HEADER OF THE SOFTWARE OUTPUT
###############################################
sourceAuthor  <-  "Robert Heyer/Meta Prot stat Team"
sourceDate    <-  "17.06.2020"

# Info about the software
print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)
print("R-Package for Mibi Statistics", quote = FALSE )
print(paste("Check similarities of the groups","....."), quote = FALSE)

#------------------------------------------

# definition of a subclass
#-----------------------------------------
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
#------------------------------------------


#Setting working directory to the folder in which the 'InputCSV.R' and 'Anosim & Permanova' scripts are
setwd('D:\\Studies\\DE Project Meta_Prot_Stat\\Permanova')

################################################
# 1. Inputting the matrix
source("InputCSV.R")  # Loading 'InputCSV.R' from the working directory
################################################
#************************************************
# Separator parameter 
separator = ";"          # Separator based on which we want to separate our data
#************************************************
#------------------------------------------------
# Now, selecting our 'Input_file_Anosim&Permanova'
DATA <-  InputData(separator)
NORMDATA <- DATA
#------------------------------------------------

#________________________
# Load Classifications
#________________________


# Now, Selecting the grouping file.
print(paste("Please select Grouping CSV", "Care about correct format."), quote = FALSE)
fname <- file.choose()    # select 'Groupings_file_Anosim&Permanova'
groups <- as.matrix(read.csv(fname, sep=separator,row.names=1))


################################################
# Step 2. Applying significance tests for groups

source("Anosim-and-Permanova-2.R")    # It will Load this Script from the folder which is set
                                      # as your working directory.
################################################

#************************************************
# Making a binary variable to be used afterwards in running the function 'groupDifferenceData'
performGroupTest <- TRUE

# Select ANOSIM or Permanova Test:
groupSimMethod <- "ANOSIM"           # "PERMANOVA/ ANOSIM

# Number of Permutations we want. Permutations are for shuffling the data in groups
perm  <- 200
#************************************************
#------------------------------------------------
# This function will run in 2nd 'Anosim&Permanova-2.R' script
if(performGroupTest){
  NORMDATA <- groupDifferenceData(NORMDATA,groups,groupSimMethod,perm)
}
#------------------------------------------------

