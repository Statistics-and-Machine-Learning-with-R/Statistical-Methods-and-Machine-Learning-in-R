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
    In this case select:
    
    a- the dataset to work with
    b- Type of separator in your csv file
    c- Choose correlation to be calculated between rows(instances) or columns(variables)  
    d- range of columns for numeric data
    
3 - After the normalized values are calculated you can view the resulting matrices from the environment window (right) &
    they will be exported to your present working directory (location of this RScript) as csv files
             Method can be kendall, pearson or spearman
             
             For column wise
             * Cor_c_Test_k contains the kendall correlation values (exported as Correlation_Col_Kendall.csv)
             * Cor_c_Test_p contains the pearson correlation values (exported as Correlation_Col_Pearson.csv)
             * Cor_c_Test_s contains the spearman correlation values (exported as Correlation_Col_Spearman.csv)
             
             For row wise
             * Cor_r_Test_k contains the kendall correlation values (exported as Correlation_Row_Kendall.csv)
             * Cor_r_Test_p contains the pearson correlation values (exported as Correlation_Row_Pearson.csv)
             * Cor_r_Test_s contains the spearman correlation values (exported as Correlation_Row_Spearman.csv)
"

#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------

rm(list=ls())

#User input for data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()

#ask user for type of  Separator:
ask_sep <- as.character(readline(prompt = "ENTER either of the types of Separator ',' or ';' : "))

#ask user for correlation to be calculated between columns or rows :
ask_type <- as.character(readline(prompt = "ENTER 'r' for rows or 'c' for columns : "))

#Input file read
file1 <- read.csv(fname, sep=ask_sep)
cat("\f")       # Clear old outputs

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
cat("\f")       # Clear old outputs
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#Sub space the numeric data frame:
data_csv <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs

#--------------------------------------------------
"Calculating correlation"
#--------------------------------------------------

# use = "complete.obs" when you have missing values
# use = "all.obs" when you DO NOT have missing values


if (ask_type == 'c'){

    Cor_c_Test_k <- cor(data_csv, method = "kendall", use = "complete.obs")
    Cor_c_Test_p <- cor(data_csv, method = "pearson", use = "complete.obs")
    Cor_c_Test_s <- cor(data_csv, method = "spearman", use = "complete.obs")
    
    write.csv(as.matrix(Cor_c_Test_k), file = "Correlation_Col_Kendall.csv", row.names = TRUE)  
    write.csv(as.matrix(Cor_c_Test_p), file = "Correlation_Col_Pearson.csv", row.names = TRUE)
    write.csv(as.matrix(Cor_c_Test_s), file = "Correlation_Col_Spearman.csv", row.names = TRUE)

  
} else if  (ask_type == 'r') {
  
    data_csv <- t(data_csv)
    
    Cor_r_Test_k <- cor(data_csv, method = "kendall", use = "complete.obs")
    Cor_r_Test_p <- cor(data_csv, method = "pearson", use = "complete.obs")
    Cor_r_Test_s <- cor(data_csv, method = "spearman", use = "complete.obs")
    
    write.csv(as.matrix(Cor_r_Test_k), file = "Correlation_Row_Kendall.csv", row.names = TRUE)  
    write.csv(as.matrix(Cor_r_Test_p), file = "Correlation_Row_Pearson.csv", row.names = TRUE)
    write.csv(as.matrix(Cor_r_Test_s), file = "Correlation_Row_Spearman.csv", row.names = TRUE)

}
cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
