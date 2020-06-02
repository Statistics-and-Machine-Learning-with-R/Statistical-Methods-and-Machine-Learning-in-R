#-------------------------------------------------------------------------------------------------------------
                                               # Cleaning the workspace
#-------------------------------------------------------------------------------------------------------------

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#-------------------------------------------------------------------------------------------------------------
                                           # HEADER OF THE SOFTWARE OUTPUT
#-------------------------------------------------------------------------------------------------------------

sourceAuthor  <-  "TEAM"
sourceDate    <-  "30.04.2020"
sourceVersion <-  "1.0.1"

##Info about the software:

print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)
print("Normalization", quote = FALSE )



#-------------------------------------------------------------------------------------------------------------
                                                 # {Install Packages}
                               #While the first run certain subpackages have to be installed
#-------------------------------------------------------------------------------------------------------------

# Install necessary packages for the program

if(!require("miniCRAN")) install.packages("miniCRAN") 
if(!require("plyr")) install.packages("plyr") 
if(!require("readr")) install.packages("readr") 
if(!require("ggplot2")) install.packages("ggplot2") 
if(!require("GGally")) install.packages("GGally") 
if(!require("dplyr")) install.packages("dplyr") 
if(!require("caret")) install.packages("caret") 


# Add the associated libraries to the programm

library("miniCRAN")
library("plyr")
library("readr")
library("ggplot2")
library("GGally")
library("dplyr")
library("mlbench")
library("caret")



#-------------------------------------------------------------------------------------------------------------
                                                      # MAIN
#-------------------------------------------------------------------------------------------------------------



# Declaration of parameters:
SEPARATOR = ";"


# Select your file : 

print(paste("Please select Input CSV", " Which is to be operated."), quote = FALSE)
fname <- file.choose()  #Metaprotein.csv


# Store your data in a matrix

matrix <- read.csv(fname, sep=";", row.names=1) 



# Declare a function which can offer a set of operations

NormalizeData <- function(reScaleData, normalizeMoments )  {
  
  
  
# Declare a variable which can store and return value of processed data  
#   
# norm1 <<- "new" 


# Defining operation reScaleData of function  
   if (reScaleData){
     
     # A glimpse of the current status of data
     summary(matrix)
     
     # Define a function to scale the data between 0 and 1
     range01 <- function(x){(x-min(x))/(max(x)-min(x))}
     
     # Save normalized data in pre-declared variable
     norm1 <-  range01(matrix)
     
     # A glimpse of the current status of data
     summary(norm1)
     
     # Returns value for the function
     return(norm1)
  }
  

  
  
# Defining operation normalizeMoments which normalizes data by dividing mean by Standard Deviation  
  if (normalizeMoments){
    
    # A glimpse of the current status of data
    summary(matrix)
    
    # Pre-processing of data matrix
    preproc1 <- preProcess(matrix[], method=c("center", "scale"))
    
    # Normalization of Data
    norm1 <- predict(preproc1, matrix[])
    
    # A glimpse of the current status of data
    summary(norm1)
    
    return (norm1)
  }
  


  # Display statement to confirm data has been processed
  print("2. Normalization finished")
  
  # Return final data
  return(normalizedData)
  
}




# Define the type of normalization you require for your data by calling the predefined function, assign "T" to the desired operation/s and "F" for undesired operation
result <- NormalizeData(reScaleData=F, normalizeMoments=T)















