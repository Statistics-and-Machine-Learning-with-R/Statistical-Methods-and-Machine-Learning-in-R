# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Package for package administration
if(!require("miniCRAN")) install.packages("miniCRAN") 
# Package for multivariate data analysis
if(!require("factoextra")) install.packages("factoextra") 

if(!require("ggplot2")) install.packages("ggplot2") 
if(!require("ggdendro")) install.packages("ggdendro") 
if(!require("reshape2")) install.packages("reshape2") 
if(!require("grid")) install.packages("grid") 
if(!require("NbClust")) install.packages("NbClust")


# Add the associated libraries to the program
library("miniCRAN")
library("factoextra")
library("ggplot2")
library("ggdendro")
library("reshape2")
library("grid")
library("cluster")
library("NbClust")


fname <- file.choose() 
data1 <- read.csv(fname, sep=",")

data1 #to check the dataset


#Removing Categorical Variable
state_data <- data1[,-5] # Remove column 5 which is Categorical
state_data

#Standardize the dataset
state_data <- scale(state_data) # Standardize: Scale is a generic function whose default method centers and/or scales the columns of a numeric matrix.


# Determining the optimum number of clusters 
#nb <- NbClust(state_data, distance = "euclidean", min.nc = 2,
#              max.nc = 10, method = "complete", index ="all")
# Visualize the result
#fviz_nbclust(nb) + theme_minimal()


help(eclust)
# eclust(F_iris, FUNcluster = "kmeans", hc_metric = "euclidean") 

# Types of Cluster Distances
# 1. "euclidean"  : SQRT(SUMMe_i:(xi-i)2).
# 2. "maximum"    : Maximum distance between two components of x and y (supremum norm)
# 3. "manhattan"  : Absolute distance between the two vectors (1 norm aka L1).
# 4. "canberra"   : summe:i|xi?-yi|/(|xi|+|yi|). 
# 5. "binary"     : The vectors are regarded as binary bits, so non-zero elements are "on" and zero elements are "off".
# 6. "minkowski"  : The p norm, the pth root of the sum of the pth powers of the differences of the components.

#Performaing K-means clustering giving number of clusters= 3  

k_means <- eclust(state_data, "kmeans",hc_metric = "euclidean", k = 3, nstart = 25, graph = TRUE) #For now it stores the values
                                                                                            #gives basic graph


# Visualize k-means clusters
??fviz_cluster
fviz_cluster(k_means, geom = "point", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal())  # Visualization of 3 clustures



# Hierarchical clustering giving number of clusters= 3
#h_clust <- eclust(state_data, "hclust", k = 3, hc_metric = "euclidean", hc_method = "ward.D2", graph = FALSE)

# Visualize Hierarchical clusters by dendograms
#fviz_dend(h_clust, show_labels = FALSE, palette = "jco", as.ggplot = TRUE)
