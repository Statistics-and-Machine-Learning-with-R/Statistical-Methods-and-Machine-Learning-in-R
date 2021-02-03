##############################
## Clustering + Ordination ###
##############################


# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Creating a data matrix

data_csv <- file.choose()
data_matrix <- read.csv(data_csv, header = TRUE, sep = ",")


#------------------------------------
"Installing necessary packages"
#------------------------------------


# Installing  Packages
if(!require("factoextra")) install.packages("factoextra")   # For Visualization
if(!require("NbClust")) install.packages("NbClust")   # For Visualization

# Loading Package
library("factoextra")
library("NbClust")



# Get principal component vectors using prcomp
pca <- prcomp(data_matrix,scale=T,center = T)

# First 2 principal components
comp <- data.frame(pca$x[,1:2])
comp

# Plot the result
plot(comp, pch=16)



# Applying K-Means

# Determining the optimum number of clusters 
nb <- NbClust(data_matrix, distance = "euclidean", min.nc = 2,
              max.nc = 5, method = "complete", index ="all")


# Visualize the result

fviz_nbclust(nb) + theme_minimal()


# Input desired number of clusters

K <- readline(prompt = "Input number of clusters required:")
k <- as.integer(K)

k_means_new <- eclust(comp, FUNcluster= "kmeans", k, hc_metric = "euclidean" , nstart = 25, graph = TRUE)


####################################################################################
