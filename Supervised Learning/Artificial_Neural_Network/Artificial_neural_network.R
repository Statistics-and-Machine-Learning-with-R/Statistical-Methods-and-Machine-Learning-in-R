"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please select the dataset provided with the name 'German_state_results_New') or any numeric data available.

                   Column(Instance) 1       Column(Instance) 2     . . . .    Column(Instance) n
      
      Row(Variable) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Variable) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
 Row(Classification) n     (Value)                  (Value)           . . . .         (Value)
      
                                        
2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   a- Select Dataset to work on (after screen pops out)
   b- Select Separator 
   c- Assign the Classification column
   d- Select the size of Training set
   e- Select the type of Activation function you want
   
3- After providing all the parameters, the code will compute following:
   * Computation and Visulaization of Neural Network
   * Comparison of predicted output and corresponding actual test data
   * Confusion Matrix to check false positives etc.
"

# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
"REQUIRED PACKAGES FOR Amynn"
#------------------------------------------------

#Cleaning the workplace to start over
cat("\f")       #Clear old outputs
rm(list=ls())   #Clear all variables

#Installing  Packages
if(!require("neuralnet")) install.packages("neuralnet") #For using Neural network package
if(!require("caret")) install.packages("caret")         #For confusion matrix


library("neuralnet")
library("caret")
#------------------------------------------------
"SELECTION OF DATASET"
#------------------------------------------------

# choose file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)

#Choose the Separator for file
fname <- file.choose()     #choose German_State_Results_New.csv

#type of separator used in input data
ask_sep <- as.character(readline(prompt = "ENTER the SEPARATOR for file(',' or ';') : "))

matrix1<- read.csv(fname, sep= ask_sep, row.names = 1)

#Make data in normal form by taking Transpose
df_t <- as.data.frame(t(matrix1))


#Convert the data type back to numeric
for (newa in 1:ncol(df_t)){
  chk <- as.numeric(df_t[1,newa])
  if (!is.na(chk)){  
    
    df_t[ , newa] <- apply(df_t[ , newa, drop= F], 2, function(x) as.numeric(as.character(x)))
  }
  
}
#matrix to be used
matrix <- df_t

#dummify the data
dmy <- dummyVars(" ~ .", data = matrix, sep = NULL)
dmy2 <- data.frame(predict(dmy, newdata = matrix))
matrix <- dmy2

View(matrix)

#extract classification column
#new data(matrix) will be shown in spreadsheet style in R console for you to choose column
#please move your cursor to column name, and R will give you column number
output_col <- as.integer(readline(prompt = "Enter the Column number of Classification Column: "))

#extract Size of Training set
training_size <- as.integer(readline(prompt = "Enter a Percentage of training dataset (e.g. 75): "))

#taking user's input for activation function
actfct <- as.character(readline(prompt = "Enter either of the activation functions you like to use. 'tanh' or 'logistic': "))


#normalizing our data
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

nor_matrix <- as.data.frame(lapply(matrix, normalize))

cat("\f")       #Clear old outputs


#------------------------------------------------
"Train-Test Data Split"
#------------------------------------------------

training_size <- training_size/100   #extracting Percentage
n = nrow(nor_matrix)

smp_size <- floor(training_size * n) #training_size asked from the user
index<- sample(seq_len(n),size = smp_size)

#Breaking into Training and Testing Sets:
TrainingSet <- nor_matrix[index,]
TestingSet <- nor_matrix[-index,]


#------------------------------------------------
"Neural Network Creation"
#------------------------------------------------
#getting formula variables:
classification <- colnames(TrainingSet[output_col])
rest_var <- colnames(TrainingSet[names(TrainingSet) != classification])

#Making Dynamic formula
rest_var  <- paste(rest_var, collapse = " + ")
nn_formula <- as.formula(paste(classification, rest_var, sep=" ~ "))

# Using neuralnet Function for Making the Tree
library(neuralnet)
nn <- neuralnet(formula = nn_formula, data=TrainingSet, 
                hidden=c(2,1),act.fct = actfct, linear.output=F, threshold=0.01)

#hidden:        the number of hidden neurons (vertices) in each layer
#act.fct:       the activation function
#linear.output: specifies the impact of the independent variables on the dependent variable('ResultPromoted', in this case) 
#threshold:     change in error percentage during an iteration 
#               after which no further optimization will be carried out


#nn$result.matrix #to see the computations, un comment this line 

#------------------------------------------------
"Plot Neural Net"
#------------------------------------------------
# Plotting the Neural Network
plot(nn)

#------------------------------------------------
"Predict the Output"
#------------------------------------------------

#Predicting Output
nn.results <- predict(nn, TestingSet)

#scaling the result back
rounded_nn<-sapply(nn.results,round,digits=0)

#taking the classification column which we asked the user initially
classification_col <- TestingSet[,names(TestingSet) %in% classification]

res <- data.frame(rounded_nn, 
                  classification_col)

cat("\f")       #Clear old outputs
print(res)

#making the confusion matrix
Conf_Matrix <- confusionMatrix(table(res$rounded_nn, res$classification_col))
print(Conf_Matrix)

options(warn = -1)
print(paste("FINISHED"), quote = FALSE)
