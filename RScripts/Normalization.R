#-------------------------------------------------------------------------------------------------------------
# Cleaning the workspace
#-------------------------------------------------------------------------------------------------------------

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#-------------------------------------------------------------------------------------------------------------
# HEADER OF THE SOFTWARE OUTPUT
#-------------------------------------------------------------------------------------------------------------

sourceAuthor  <- "Robert Heyer/META PRO STAT TEAM"
sourceDate    <-  "30.04.2020"
sourceVersion <-  "1.0.1"

# Information about the software:

print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)
print("Normalization", quote = FALSE )





# Install necessary packages for the program

if(!require("miniCRAN")) install.packages("miniCRAN") 

# Add the associated libraries to the programm

library("miniCRAN")


#--------------------------------------------------
# MAIN of Normalization
#--------------------------------------------------

# Declaration of parameters:
SEPARATOR = ";"


# Select your file : 
print(paste("Please select Input CSV", " Which is to be operated."), quote = FALSE)
fname <- file.choose()  #HINT: Metaprotein.csv


# Store your data in a matrix
matrix <- read.csv(fname, sep=";", row.names=1) 



# Declare a function which can offer a set of operations
NormalizeData <- function(reScaleData, normalizeMoments )  {
  
# Defining operation reScaleData of function  
   if (reScaleData){
     
     # Define a function to scale the data between 0 and 1
     range01 <- function(x){(x-min(x))/(max(x)-min(x))}
     
     # Save normalized data in pre-declared variable
     norm1 <-  range01(matrix)
     
     # Returns value for the function
     return(norm1)
  }
  
# Defining operation normalizeMoments which normalizes data by dividing mean by Standard Deviation  
  if (normalizeMoments){
    
    # Pre-processing of data matrix
    preproc1 <- preProcess(matrix[], method=c("center", "scale"))
    
    # Normalization of Data
    norm1 <- predict(preproc1, matrix[])
    
    
    return (norm1)
  }
  


  # Display statement to confirm data has been processed
  print("2. Normalization finished")
  
  # Return final data
  return(normalizedData)
  
}
#--------------------------------------------------
#  Select which type of Normalization to operate:
#--------------------------------------------------

# Define the type of normalization you require for your data by calling the predefined function, assign "T" to the desired operation/s and "F" for undesired operation
result <- NormalizeData(reScaleData=T, normalizeMoments=F)



#--------------------------------------------------
# Export the results
#--------------------------------------------------

outputname <- 'Normalized_Data.csv' # Outpuft File name
#or
outputname <- '/Users/mac/Documents/12CP Project/Normalized_Data.csv' #OUtput File Location

write.table(result, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")







