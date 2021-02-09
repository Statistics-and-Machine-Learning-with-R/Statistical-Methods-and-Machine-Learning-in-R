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

3 - After the regression values are calculated you can view the results in the console below (or environment window to the right)
"

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)
data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

# Linear Regression
lm1 <- lm(data_csv)

summary(lm1)
print(lm1)

print(paste("FINISHED"), quote = FALSE)
