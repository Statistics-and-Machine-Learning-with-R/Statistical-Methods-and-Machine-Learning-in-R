
##############################
## Clustering + Ordination ###
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
if(!require("factoextra")) install.packages("factoextra")   # For Visualization

# Loading Package
library("factoextra")



# Get principal component vectors using prcomp
pca <- prcomp(data_matrix[,(1:4)],scale=T,center = T)

# First 2 principal components
comp <- data.frame(pca$x[,1:2])
comp


# Plot the result
plot(comp, pch=16)

# Applying K-Means
k_means_new <- eclust(comp, FUNcluster= "kmeans", k= 3, hc_metric = "euclidean" , nstart = 25, graph = TRUE)


####################################################################################
