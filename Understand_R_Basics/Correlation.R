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
    b- type of separator in your csv file
    c- choose correlation to be calculated between rows(variables) or columns(instances)  
    d- range of columns for numeric data
    e- significance value for correlation - the minimum value for correlation you would like to assign (e.g. 0.05)
    f- For row wise calculation of correlation - whether the first column of your dataset contains the row names
    
3 - After the normalized values are calculated you can view the resulting matrices from the environment window (right) &
    they will be exported to your present working directory (location of this RScript) as csv files
    
             Methods are kendall, pearson or spearman
 
             1: Pearson Correlation (Calculates correlation, but requires linear correlation)
             2: Spearman Correlation (Correlation using ranks, do not require a linear correlation)
             3: Kendalls Tau Correlation (Correlation using ranks, do not require a linear correlation)--> Results of Kendallas Tau and Spearman are
                quite similar. But Kendalls Tau: usually smaller values than Spearmans rho correlation. Calculations based on concordant and discordant 
                pairs. Insensitive to error. P values are more accurate with smaller sample sizes.
             
             For column wise
             * Cor_c_Test_k contains the kendall correlation values (exported as Correlation_Col_Kendall.csv)
             * Cor_c_Test_p contains the pearson correlation values (exported as Correlation_Col_Pearson.csv)
             * Cor_c_Test_s contains the spearman correlation values (exported as Correlation_Col_Spearman.csv)
             
             For row wise
             * Cor_r_Test_k contains the kendall correlation values (exported as Correlation_Row_Kendall.csv)
             * Cor_r_Test_p contains the pearson correlation values (exported as Correlation_Row_Pearson.csv)
             * Cor_r_Test_s contains the spearman correlation values (exported as Correlation_Row_Spearman.csv)
"

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

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

#ask user for significant value of correlation :
sig_p <- as.numeric(readline(prompt = "significance value for correlation - the minimum value for correlation you would like to assign (e.g. 0.05) : "))

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
    
    Cor_c_Test_k <- as.data.frame(Cor_c_Test_k)
    Cor_c_Test_p <- as.data.frame(Cor_c_Test_p)
    Cor_c_Test_s <- as.data.frame(Cor_c_Test_s)
    
    Cor_c_Test_k <- replace(Cor_c_Test_k, Cor_c_Test_k < sig_p, "No_correlation")
    Cor_c_Test_p <- replace(Cor_c_Test_p, Cor_c_Test_p < sig_p, "No_correlation")
    Cor_c_Test_s <- replace(Cor_c_Test_s, Cor_c_Test_s < sig_p, "No_correlation")
    
    write.csv(as.matrix(Cor_c_Test_k), file = "Correlation_Col_Kendall.csv", row.names = TRUE)  
    write.csv(as.matrix(Cor_c_Test_p), file = "Correlation_Col_Pearson.csv", row.names = TRUE)
    write.csv(as.matrix(Cor_c_Test_s), file = "Correlation_Col_Spearman.csv", row.names = TRUE)

  
} else if  (ask_type == 'r') {
    
    ask_row_names <- as.character(readline(prompt = "Does the first variable column in your dataset contain rownames (Y or N)?  : "))
    
    if (ask_row_names == 'Y') {
      
    rownames(data_csv) <- file1[,1]
    
    }
    
    data_csv2 <- t(data_csv)
    
    Cor_r_Test_k <- cor(data_csv2, method = "kendall", use = "complete.obs")
    Cor_r_Test_p <- cor(data_csv2, method = "pearson", use = "complete.obs")
    Cor_r_Test_s <- cor(data_csv2, method = "spearman", use = "complete.obs")
    
    Cor_r_Test_k <- as.data.frame(Cor_r_Test_k)
    Cor_r_Test_p <- as.data.frame(Cor_r_Test_p)
    Cor_r_Test_s <- as.data.frame(Cor_r_Test_s)
    
    Cor_r_Test_k <- replace(Cor_r_Test_k, Cor_r_Test_k < sig_p, "No_correlation")
    Cor_r_Test_p <- replace(Cor_r_Test_p, Cor_r_Test_p < sig_p, "No_correlation")
    Cor_r_Test_s <- replace(Cor_r_Test_s, Cor_r_Test_s < sig_p, "No_correlation")
    
    write.csv(as.matrix(Cor_r_Test_k), file = "Correlation_Row_Kendall.csv", row.names = TRUE)  
    write.csv(as.matrix(Cor_r_Test_p), file = "Correlation_Row_Pearson.csv", row.names = TRUE)
    write.csv(as.matrix(Cor_r_Test_s), file = "Correlation_Row_Spearman.csv", row.names = TRUE)

}
cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)