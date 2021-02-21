"
NOTE: First Column is treated as 1 in the Selection of Data:

1 - Please make sure your csv file contains only numeric variables with headers for the code to run.

                       Column(Instance) 1      Column(Instance) 2     . . . .    Column(Instance) n
      
      Row(Variable) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Variable) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Variable) n      (Value)                  (Value)           . . . .         (Value)

2 - To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below
    In this case select
    
    a- the dataset to work with
    b- type of Separator used in input file
    c- range of numeric data 
    
3 - After the QQ Plots are generated, you can view them in the Plots window on the bottom right. If you want to save the plots as png
    or jpg format, press the export option on the Plots window.
"

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#-----------------------------------------------

#User input for data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()

#ask user for type of  Separator:
ask_sep <- as.character(readline(prompt = "ENTER either of the types of Separator ',' or ';' : "))

#Input file read
file1 <- read.csv(fname, sep=ask_sep)
cat("\f")       # Clear old outputs

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
cat("\f")       # Clear old outputs
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#Sub space the nuermic dataframe:
data_matrix <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs
#--------------------------------------------------
"Plotting QQ-plot"
#--------------------------------------------------

data_matrix <- t(data_matrix)

for (i in 1:NCOL(data_matrix)) {
  qqnorm(data_matrix[,i])
  qqline(data_matrix[,i], col = "blue")
}

print(paste("FINISHED"), quote = FALSE)
