"

1- Please select the dataset provided with the name 'German_state_results_New')
                                        
2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- Select Dataset to work on (after screen pops out)
3- After providing all the parameters, the code will compute following:
   * Computation and Visulaization of Decision Tree
   * Pruning and again visulaization of pruned tree
   * Comparison of predicted output and corresponding actual test data
"
# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
"REQUIRED PACKAGES FOR DT"
#------------------------------------------------

#Cleaning the workplace to start over
cat("\f")       #Clear old outputs
rm(list=ls())   #Clear all variables

#Installing  Packages
if(!require("rpart")) install.packages("rpart")             #Package to create Decision Tree
if(!require("rpart.plot")) install.packages("rpart.plot")   # To Visulaize DT

library(rpart)
library(rpart.plot)


#------------------------------------------------
"SELECTION OF DATASET"
#------------------------------------------------

SEPARATOR = ";"  # Separator within the csv.-files
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()     #choose German_State_Results_New.csv
matrix<- read.csv(fname, sep=SEPARATOR) 
head(matrix)

#------------------------------------------------
"Train-Test Data Split"
#------------------------------------------------

n = nrow(matrix)
smp_size <- floor(0.75 * n)
index<- sample(seq_len(n),size = smp_size)

#Breaking into Training and Testing Sets:
TrainingSet <- matrix[index,]
TestingSet <- matrix[-index,]

#------------------------------------------------
"Decison Tree Creation"
#------------------------------------------------

# Using rpart Function for Making the Tree
mytree <- rpart(Result ~ Mathematics + Biology + History + Litrature + State + City + Wealth  , data = TrainingSet)
mytree

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
mytree <- prune(mytree, cp = 0.21)
rpart.plot(mytree, extra = 4)
mytree
printcp(mytree)

#------------------------------------------------
"Predict the Output"
#------------------------------------------------

#Predicting Output
TestingSet$PassClass <- predict(mytree, newdata = TestingSet, type = "class")
TestingSet$Prob <- predict(mytree, newdata = TestingSet, type = "prob")
TestingSet

print(paste("FINISHED"), quote = FALSE)
