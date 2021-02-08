"
#WHY COLUMN WISE?
# HOW THE MATRIX LOOKS
# COLUMN TO ROW
# OUTFILE FILE MISSING (ADD IT)
1 - Please make sure your csv file contains only numeric variables with headers for the code to run.

2 - To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below
In this case select

    a - the dataset to work with

3 - After the normalized values are calculated you can view the resulting values in the console below

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

# Loading Data Set
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_matrix <- read.csv(data, header = TRUE, sep = ',')


#--------------------
"Test for Normality"
#--------------------

for (i in 1:NROW(data_matrix)) {
  print(shapiro.test(data_matrix[,i]))
}
