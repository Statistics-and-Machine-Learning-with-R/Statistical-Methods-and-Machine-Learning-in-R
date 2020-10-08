#IMPLMENTATION OF DECISION TREE

#PACKAGES REQUIRED
# -> RPART
# -> RPART.PLOT

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

install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

#Getting Data
my_data<- read.csv("/Users/mabook/Documents/German_state_results_New.csv",sep = ";")
head(my_data)

#Breaking into Training and Testing Sets

n = nrow(my_data)
split = sample(c(TRUE, FALSE), n, replace=TRUE, prob=c(0.75, 0.25))

TrainingSet = my_data[split, ]
TestingSet = my_data[!split, ]
View(TrainingSet)
View(TestingSet)

# Using rpart Function for Making the Tree
#mytree <- rpart(Result ~ Wealth + Biology + History + Litrature + State + City   , data = my_data, method = "class" )
mytree <- rpart(Result ~ Mathematics + Biology + History + Litrature + State + City + Wealth  , data = TrainingSet)
mytree


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


#Predicting Output
testing$PassClass <- predict(mytree, newdata = testing, type = "class")
testing$Prob <- predict(mytree, newdata = testing, type = "prob")
testing
