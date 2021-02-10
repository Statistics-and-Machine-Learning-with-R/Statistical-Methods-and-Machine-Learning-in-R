"
1 - Please make sure your csv file contains only numeric variables with headers for the code to run.
                       Column(Variable) 1      Column(Variable) 2     . . . .    Column(Variable) n
      
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Instance) n      (Value)                  (Value)           . . . .         (Value)
      
2 - To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below
In this case select
    a - the dataset to work with
    b- Type of separator and range of columns for numeric data
    
3 - After the regression values are calculated you can view the results in the console below (or environment window to the right)
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
data_csv <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs

#------------------------------------------------
"CALCULATION FOR REGRESSION"
#-----------------------------------------------
# Linear Regression
lm1 <- lm(data_csv)

summary(lm1)
print(lm1)

print(paste("FINISHED"), quote = FALSE)
