##############################
## DBSCAN ##
##############################


# Cleaning the workspace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Creating a data matrix

data_matrix <- as.data.frame(iris)
data_matrix



#------------------------------------
"Installing necessary packages"
#------------------------------------


# Installing  Packages
if(!require("fpc")) install.packages("fpc")                 # FOR DBSCAN CLUSTERING
if(!require("factoextra")) install.packages("factoextra")   # For Visualization

# Loading Package
library("fpc")
library("factoextra")



# Performing DBSCAN clustering on parameters eps & minPts
dbscan <- fpc::dbscan(data_matrix[,(1:4)], eps = 0.6, MinPts = 3)      # performing dbscan leaving out the column species with epsilon of 0.6 & Min Points of 3
dbscan


# Visualize clusters
fviz_cluster(dbscan, data_matrix[,(1:4)], stand = FALSE, frame = FALSE, geom = "point")

####################################################################
