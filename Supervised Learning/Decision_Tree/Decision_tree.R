"
NOTE: First Column is treated as 1 in the Selection of Data:
1- Please select the dataset provided with the name 'German_state_results_New') or any numeric data available.

                   Column(Variable) 1       Column(Variable) 2     . . . .    Column(Classification) n
      
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Instance) n       (Value)                  (Value)           . . . .         (Value)
      
                                        
2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- Select Dataset to work on (after screen pops out)
   b- Select Separator 
   c- Assign the Classification column
   
3- After providing all the parameters, the code will compute following:
   * Computation and Visulaization of Decision Tree
   * Pruning and again visulaization of pruned tree
   * Comparison of predicted output and corresponding actual test data
   * Computation of Confusion Matrix
"
# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
"REQUIRED PACKAGES FOR Decison Tree"
#------------------------------------------------

#Cleaning the workplace to start over
cat("\f")       #Clear old outputs
rm(list=ls())   #Clear all variables

#Installing  Packages
if(!require("rpart")) install.packages("rpart")             #Package to create Decision Tree
if(!require("rpart.plot")) install.packages("rpart.plot")   # To Visulaize DT
if(!require("caret")) install.packages("caret")   

library(rpart)
library(rpart.plot)
library(caret)
#------------------------------------------------
"SELECTION OF DATASET"
#------------------------------------------------

# choose file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)

#Choose the Separator for file
fname <- file.choose()     #choose German_State_Results_New.csv

#type of separator used in input data
ask_sep <- as.character(readline(prompt = "ENTER the SEPARATOR for file(',' or ';') : "))

matrix<- read.csv(fname, sep= ask_sep) 

#extract classification column
output_col <- as.integer(readline(prompt = "Enter the Column number of Classification Column: "))

#extract Size of Training set
training_size <- as.integer(readline(prompt = "Enter a Percentage of training dataset: "))

cat("\f")       #Clear old outputs

#------------------------------------------------
"Train-Test Data Split"
#------------------------------------------------


training_size <- training_size/100 #extracting Percentage
n = nrow(matrix)
smp_size <- floor(training_size * n)  #ask from the user
index<- sample(seq_len(n),size = smp_size)

#Breaking into Training and Testing Sets:
TrainingSet <- matrix[index,]
TestingSet <- matrix[-index,]

#------------------------------------------------
"Decison Tree Creation"
#------------------------------------------------

#getting formula variables:
classification <- colnames(TrainingSet[output_col])
rest_var <- colnames(TrainingSet[names(TrainingSet) != classification])


#Making Dynamic formula
rest_var  <- paste(rest_var, collapse = " + ")
dt_formula <- as.formula(paste(classification, rest_var, sep=" ~ "))


# Using rpart Function for Making the Tree
mytree <- rpart(formula = dt_formula , data = TrainingSet)

cat("\f")       #Clear old outputs

#------------------------------------------------
"Plot Decison Tree"
#------------------------------------------------
# Plotting the Tree
rpart.plot(mytree, extra = 4)

# Printing Complexity Parameter
printcp(mytree)

#Plotting Complexity Parameter
plotcp(mytree)

#Measurng Importance of Variables
mytree$variable.importance

#Pruning the tree to Reduce Overfitting
mytree <- prune(mytree, cp = 0.21)  #CP or Complexity Parameter is used to control the size of Decision Tree.
rpart.plot(mytree, extra = 4) 
printcp(mytree)

cat("\f")       #Clear old outputs
#------------------------------------------------
"Predict the Output"
#------------------------------------------------
#Predicting Output
TestingSet$PassClass <- predict(mytree, newdata = TestingSet, type = "class")
TestingSet$Prob <- predict(mytree, newdata = TestingSet, type = "prob")
TestingSet


Conf_Matrix <- confusionMatrix(table(TestingSet$PassClass, TestingSet$Result))
print(Conf_Matrix)

print(paste("FINISHED"), quote = FALSE)
