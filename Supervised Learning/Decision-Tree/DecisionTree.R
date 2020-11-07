
#-------------------------------------------------------------------------------------------------------------
                                                          " DECISION TREE"
#-------------------------------------------------------------------------------------------------------------
# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
                                          "HEADER OF THE SOFTWARE & INPUT"
#------------------------------------------------


# STEPS:
#  1. Import Dataset
#  2. Split Training and Testing Data
#  3. Build Tree
#  4. Acquire Tree Information -> mytree and printcp(mytree)
#  5. Plot Tree
#  6. Prune the Decision Tree
#  7. Again Acquire Tree Information -> mytree and printcp(mytree)
#  8. Again Plot Tree 
#  9. Use Test Set for Predicting Results


install.packages("rpart")        #Package to create Decision Tree
install.packages("rpart.plot")   # To Visulaize DT

library(rpart)
library(rpart.plot)


# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()     #choose German_State_Results_New.csv

# Declaration of parameters:
SEPARATOR = ";"  # Separator within the csv. -files


#Getting Data
my_data<- read.csv(fname, sep=SEPARATOR) 
head(my_data)

#------------------------------------------------
                                              "Train-Test Data Split"
#------------------------------------------------


#Breaking into Training and Testing Sets:

n = nrow(my_data)
split = sample(c(TRUE, FALSE), n, replace=TRUE, prob=c(0.75, 0.25))

TrainingSet = my_data[split, ]
TestingSet = my_data[!split, ]
View(TrainingSet)
View(TestingSet)

#------------------------------------------------
                                            "Decison Tree Creation"
#------------------------------------------------

# Using rpart Function for Making the Tree
#mytree <- rpart(Result ~ Wealth + Biology + History + Litrature + State + City   , data = my_data, method = "class", split = "information gain" )
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
                                        "Predict the Out-put"
#------------------------------------------------


s#Predicting Output
TestingSet$PassClass <- predict(mytree, newdata = TestingSet, type = "class")
TestingSet$Prob <- predict(mytree, newdata = TestingSet, type = "prob")
TestingSet
