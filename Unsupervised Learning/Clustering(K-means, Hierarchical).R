#####################################################
"Clustering : K-Means & Hierarchical(Agglomerative)" 
#####################################################

# Please make sure your csv file contains only numeric variables for the code to run.

# If your csv file has non numeric variables, make sure to remove them or alternatively you can choose a subset of 
# your data below


# Cleaning the workplace to start over

cat("\f")       # Clear old outputs

rm(list=ls())   # Clear all variables


# Installing  Packages

# Package for package administration:
if(!require("ggplot2")) install.packages("ggplot2") 
if(!require("ggdendro")) install.packages("ggdendro") 
if(!require("grid")) install.packages("grid") 
if(!require("factoextra")) install.packages("factoextra")
if(!require("NbClust")) install.packages("NbClust")



# Add the associated libraries to the program
library("ggplot2")
library("ggdendro")
library("grid")
library("factoextra")
library("NbClust")




#------------------------------------------------
"Get the matrix and Choose Groups"
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()
matrix <- read.csv(fname, sep=',', header = TRUE)


#----------------------------------------------
"Calculation and Visualization for CLUSTERING"
#----------------------------------------------



# Determining the optimum number of clusters 
nb <- NbClust(matrix, distance = "euclidean", min.nc = 2,
              max.nc = 5, method = "complete", index ="all")

# Visualize the result
fviz_nbclust(nb) + theme_minimal()


# Taking number of clusters from user #
                                  
K <- readline(prompt = "Input number of clusters required:")
k<- as.integer(K)


help(eclust)

# Types of Cluster Distances
# 1. "euclidean"  : SQRT(sum_i:(xi-i)2).
# 2. "maximum"    : Maximum distance between two components of x and y (supremum norm)
# 3. "manhattan"  : Absolute distance between the two vectors (1 norm aka L1).
# 4. "canberra"   : sum:i|xi?-yi|/(|xi|+|yi|). 
# 5. "binary"     : The vectors are regarded as binary bits, so non-zero elements are "on" and zero elements are "off".
# 6. "minkowski"  : The p norm, the pth root of the sum of the pth powers of the differences of the components.


######################
# K-Means Clustering #
######################

# Performing K-means clustering giving number of clusters  

k_means <- eclust(matrix, "kmeans",hc_metric = "euclidean", k , nstart = 25, graph = TRUE)


# Visualize k-means clusters
fviz_cluster(k_means, geom = "point", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal())  # Visualization of the clusters



###########################
# Hierarchical Clustering #
###########################

# Hierarchical clustering giving number of clusters
h_clust <- eclust(matrix, "hclust", k , hc_metric = "euclidean", graph = FALSE)



# Visualize Hierarchical clusters by dendrograms
fviz_dend(h_clust, show_labels = FALSE, palette = "jco", as.ggplot = TRUE)

# Making heatmaps

heatmap(as.matrix(h_clust$data))



"Quality Of Clustering"

# Using Silhouette Function
fviz_silhouette(k_means)
fviz_silhouette(h_clust)


#################################################