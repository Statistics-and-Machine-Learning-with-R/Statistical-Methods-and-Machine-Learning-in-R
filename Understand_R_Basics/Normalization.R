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

    a- the dataset to work with
    b- Type of separator used in the file
    c- The parameters to be dealt with in this script which are center & scale

## The value of center determines how column centering is performed

    * If center =  numeric-alike vector with length equal to the number of columns of x, 
      then each column of x has the corresponding value from center subtracted from it.

    * If center = TRUE then centering is done by subtracting the column means (omitting NAs) of x from their corresponding columns

    * If center = FALSE, no centering is done

## The value of scale determines how column scaling is performed (after centering)

    * If scale = a numeric-alike vector with length equal to the number of columns of x, 
      then each column of x is divided by the corresponding value from scale

    * If scale = TRUE then scaling is done by dividing the (centered) columns of x by their standard deviations given center is TRUE, 
      and the root mean square otherwise

    * If scale = FALSE, no scaling is done

3 - After the normalized values are calculated you can view the resulting matrix from the environment window on the right &
    it will be exported to your present working directory (location of this RScript) as a csv file

"
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#----------------------
"Selecting Parameters"
#----------------------

ask_sep <- as.character(readline(prompt = " ENTER the SEPARATOR for file(',' or ';') : "))

C <- readline(prompt = "Input TRUE/FALSE for centering :")
c <- as.logical(C)

S <- readline(prompt = "Input TRUE/FALSE for scaling :")
s <- as.logical(S)



#----------------------
"Loading Data Set"
#----------------------
print(paste("Please select Input CSV"), quote = FALSE)

data <- file.choose()
data_matrix <- read.csv(data, header = TRUE, sep = ask_sep)


#--------------
"Normalization"
#--------------

data_matrix_out <- as.data.frame(scale(data_matrix, center = c , scale = s))
print(data_matrix_out)


#--------------------
"Exporting csv file"
#--------------------

write.csv(data_matrix_out, file = "Normalized_Values.csv", row.names = TRUE)

print(paste("FINISHED"), quote = FALSE)
