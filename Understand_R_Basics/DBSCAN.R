############
## DBSCAN ##
############

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Please make sure your csv file contains only numeric variables for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data at " # Plotting QQ Plots " below

# To run the code, select the whole code and run as source (top right in this window) & enter parameter values in the console below

#### Parameters ####

# epsilon (eps) - minimum radius for each point where the algorithm will search for minPts
# minimum points (minPts) - minimum number of neighboring points required for a point in its eps to be considered a core point

# Input values for "eps" & "MinPts"

eps <- readline(prompt = "Enter your value for epsilon : ")
minPts <- readline(prompt = "Enter minPts for CLuster formation ")


# Creating a data matrix

data_csv <- file.choose()
data_matrix <- read.csv(data_csv, header = TRUE, sep = ",")



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
dbscan <- fpc::dbscan(data_matrix, eps = eps, MinPts = minPts)      # performing DBSCAN
dbscan


# Visualize clusters
fviz_cluster(dbscan, data_matrix, stand = FALSE, ellipse = TRUE, geom = "point")

####################################################################