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
    
3 - After the QQ Plots are generated, you can view them in the Plots window on the bottom right. If you want to save the plots as png
    or jpg format, press the export option on the Plots window.
"

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_matrix <- read.csv(data, header = TRUE, sep = ',')


#--------------------------------------------------
"Plotting QQ-plot"
#--------------------------------------------------

   for (i in 1:NCOL(data_matrix)) {
        qqnorm(data_matrix[,i])
        qqline(data_matrix[,i], col = "blue")
    }

print(paste("FINISHED"), quote = FALSE)