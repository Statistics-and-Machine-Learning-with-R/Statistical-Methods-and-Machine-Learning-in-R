# -----------------------------------------
# HEADER
# -----------------------------------------
# Author: Robert Heyer
# Package to read a csv-File
# ------------------------------------------
InputData <- function(SEPARATOR) {

  # Default values
  print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
   fname <- file.choose() 

  
  
  matrix <- read.csv(fname, sep=SEPARATOR,row.names=1) 
  values <- matrix[2:nrow(matrix),2:ncol(matrix)]
  rNames <- row.names(matrix)
  cNames <- colnames(matrix)
  myCSVData <- new("CSV_data", MATRIX = matrix, VALUES = values, RNames = rNames, CNames = cNames )
  
  print("")
  print("1. Finish input data")
  return(myCSVData)
}