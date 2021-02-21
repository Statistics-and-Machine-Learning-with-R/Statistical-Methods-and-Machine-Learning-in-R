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
    b- Type of separator used in the file
    c- range of columns for numeric data
    d- Columns(Instances) or rows(Variables) to be performed Shapiro Test on

3 - After the normalized values are calculated you can view the resulting matrix from the environment window on the right &
    it will be exported to your present working directory (location of this RScript) as a csv file as Shapiro_results.csv

    # Shapiro-Wilk Test Result in R :
    # Null Hypothesis - a variable is normally distributed in some population.
    # Values generated - W & p-value
    
     * If W is very small then distribution is probably not normal
     * p-value > 0.05 implies that the distribution of the data is not significantly different from normal distribution.
       (accept the NULL Hypothesis)
   
     
    # Normalization does not change the distribution of a variable. If a variable did not pass test for normality
    # before normalization, it would not even after normalization
"

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()

ask_sep <- as.character(readline(prompt = " ENTER the SEPARATOR for file(',' or ';') : "))

data_matrix <- read.csv(data, header = TRUE, sep = ask_sep)

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
cat("\f")       # Clear old outputs
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

data_matrix <- data_matrix[,start_num : end_num] #all cont. variables

ask_type <- as.character(readline(prompt = " Specify how you want to perform Shapiro Test (type 'r' for row wise or 'c' for column wise) : "))


#--------------------
"Test for Normality"
#--------------------

shapiro_test <- array()
w_value <- array()
p_value <- array()
shapiro_result <- matrix()


if (ask_type == 'r'){

    for (i in 1:NROW(data_matrix)) {
       shapiro_test <- shapiro.test(as.numeric(data_matrix[i,]))
       w_value[i] <- shapiro_test$statistic
       p_value[i] <- shapiro_test$p.value
    }

   shapiro_result <- cbind(rownames(data_matrix),w_value, p_value)
  
  } else if  (ask_type == 'c') {

    for (i in 1:NCOL(data_matrix)) {
       shapiro_test <- shapiro.test(as.numeric(data_matrix[,i]))
       w_value[i] <- shapiro_test$statistic
       p_value[i] <- shapiro_test$p.value
    }
    
   shapiro_result <- cbind(colnames(data_matrix), w_value, p_value)
  }

#--------------------
"Exporting csv file"
#--------------------

write.csv(shapiro_result, file = "Shapiro_results.csv", row.names = TRUE)

print(paste("FINISHED"), quote = FALSE)
