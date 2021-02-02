############
## DBSCAN ##
############


# Cleaning the workspace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

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


# Input values for "eps" & "MinPts"

eps1 <- readline(prompt = "Enter your value for epsilon : ")
minPts <- readline(prompt = "Enter minPts for CLuster formation ")


# Performing DBSCAN clustering on parameters eps & minPts
dbscan <- fpc::dbscan(data_matrix, eps = eps1, MinPts = minPts)      # performing DBSCAN
dbscan


# Visualize clusters
fviz_cluster(dbscan, data_matrix, stand = FALSE, ellipse = TRUE, geom = "point")

####################################################################
