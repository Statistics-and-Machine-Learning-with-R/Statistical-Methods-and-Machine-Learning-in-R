"
NOTE: First Column is treated as 1 in the Selection of Data:


1- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. 
                   
                     Column(Variable) 1      Column(Variable) 2     . . . .    Column(Variable) n
      
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Instance) n      (Value)                  (Value)           . . . .         (Value)



2- In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Ranges for numeric variables
   c- Number of cluster to map
   
3- After providing all the parameters, the code will compute following:
   * Plot of K-means CLusters on Principle Coordinates(PCs)

"
#------------------------------------------------
"REQUIRED PACKAGES FOR PCA and K-means"
#------------------------------------------------
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Installing  Packages
if(!require("factoextra")) install.packages("factoextra")   # For Visualization
if(!require("NbClust")) install.packages("NbClust")   # For Visualization

# Loading Package
library("factoextra")
library("NbClust")

cat("\f")       # Clear old outputs
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------
#Choose the Separator for file
ask_sep <- as.character(readline(prompt = "ENTER the SEPARATOR for file(‘,’ or ‘;’) : ")) #hint ","

#User input for data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
file1 <- read.csv(file.choose(), sep= ask_sep)
cat("\f")       # Clear old outputs

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#ask user for type of  analysis:
ask_k <- as.integer(readline(prompt = "ENTER no of the cluster to be mapped : "))

#Sub space the numeric matrix
matrix <- file1[,start_num : end_num] #all cont. variables

cat("\f")       # Clear old outputs
#------------------------------------------------
"PCA+K_means RESULTS"
#------------------------------------------------
# Get principal component vectors using prcomp
pca <- prcomp(matrix,scale=T,center = T)

# First 2 principal components
comp <- data.frame(pca$x[,1:2])

# Plot the result
plot(comp, pch=16)

# Applying K-Means and map on PCs
eclust(comp, FUNcluster= "kmeans", ask_k, hc_metric = "euclidean" , nstart = 25, graph = TRUE)

cat("\f")       # Clear old outputs
