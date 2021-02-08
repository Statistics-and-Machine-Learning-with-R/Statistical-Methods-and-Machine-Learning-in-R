"
1 - Please make sure your csv file contains only numeric variables with headers for the code to run.

                       Column(Variable) 1      Column(Variable) 2     . . . . 
      
      Row(Instance) 1      (Value)                  (Value)
      
      Row(Instance) 2      (Value)                  (Value)
      
      .
      .
      .
      .

2 - To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below
    In this case select

    a- the dataset to work with
    b- Type of separator used in the file
    c- Columns(Variables) or rows(Instances) to be performed Shapiro Test on

3 - After the normalized values are calculated you can view the resulting matrix from the environment window on the right &
    it will be exported to your present working directory (location of this RScript)

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

ask_sep <- as.character(readline(prompt = " ENTER the SEPARATOR for file(',' or ';') : "))

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_matrix <- read.csv(data, header = TRUE, sep = ',')

ask_type <- as.character(readline(prompt = " Specify how you want to perform Shapiro Test (type 'r' for rowwise or 'c' for columnwise) : "))


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

   shapiro_result <- cbind(w_value, p_value)
  
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