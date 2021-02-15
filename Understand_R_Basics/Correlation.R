"
NOTE: First Column is treated as 1 in the Selection of Data:

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
    In this case select:
    
    a- the dataset to work with
    b- Type of separator and range of columns for numeric data
    
3 - After the normalized values are calculated you can view the resulting matrices from the environment window (right) &
    they will be exported to your present working directory (location of this RScript) as csv files
             Method can be kendall, pearson or spearman
             * Correlation_Test_k contains the kendall correlation values (exported as Correlation_Values_Kendall.csv )
             * Correlation_Test_p contains the pearson correlation values (exported as Correlation_Values_Pearson.csv )
             * Correlation_Test_s contains the spearman correlation values (exported as Correlation_Values_Spearman.csv )
"

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
#--------------------------------------------------
"Calculating correlation"
#--------------------------------------------------

# use = "complete.obs" when you have missing values
# use = "all.obs" when you DO NOT have missing values

Correlation_Test_k <- cor(data_csv, method = "kendall", use = "complete.obs")
Correlation_Test_p <- cor(data_csv, method = "pearson", use = "complete.obs")
Correlation_Test_s <- cor(data_csv, method = "spearman", use = "complete.obs")

# view as a data matrix inside the RStudio
#View(Correlation_Test_k)  
#View(Correlation_Test_p)
#View(Correlation_Test_s)

# exporting csv file to present working directory
write.csv(as.matrix(Correlation_Test_k), file = "Correlation_Values_Kendall.csv", row.names = TRUE)  
write.csv(as.matrix(Correlation_Test_p), file = "Correlation_Values_Pearson.csv", row.names = TRUE)
write.csv(as.matrix(Correlation_Test_s), file = "Correlation_Values_Spearman.csv", row.names = TRUE)

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
