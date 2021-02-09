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

3 - After the normalized values are calculated you can view the resulting matrices from the environment window (right) &
    they will be exported to your present working directory (location of this RScript) as csv files

             Method can be kendall, pearson or spearman
             * Correlation_Test_k contains the kendall correlation values (exported as Correlation_Values_Kendall.csv )
             * Correlation_Test_p contains the pearson correlation values (exported as Correlation_Values_Pearson.csv )
             * Correlation_Test_s contains the spearman correlation values (exported as Correlation_Values_Spearman.csv )
"

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_csv <- read.csv(data, header = TRUE, sep = ',')
data_csv

#--------------------------------------------------
"Calculating correlation"
#--------------------------------------------------

# use = "complete.obs" when you have missing values
# use = "all.obs" when you DO NOT have missing values

Correlation_Test_k <- cor(data_csv, method = "kendall", use = "all.obs")
Correlation_Test_p <- cor(data_csv, method = "pearson", use = "all.obs")
Correlation_Test_s <- cor(data_csv, method = "spearman", use = "all.obs")

# view as a data matrix inside the RStudio
View(Correlation_Test_k)  
View(Correlation_Test_p)
View(Correlation_Test_s)

# exporting csv file to present working directory
write.csv(as.matrix(Correlation_Test_k), file = "Correlation_Values_Kendall.csv", row.names = TRUE)  
write.csv(as.matrix(Correlation_Test_p), file = "Correlation_Values_Pearson.csv", row.names = TRUE)
write.csv(as.matrix(Correlation_Test_s), file = "Correlation_Values_Spearman.csv", row.names = TRUE)

print(paste("FINISHED"), quote = FALSE)
