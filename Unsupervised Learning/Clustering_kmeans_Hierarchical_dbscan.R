"
1- Please make sure your csv file contains only numeric variables with headers for the code and one
   first column with Name of the Elements (for sample check the dataset provided with the
                                        name 'German_state_results')
2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   a- Select Dataset to work on (after screen pops out)
   b- Select what type of clustering you want out of Kmeans, Hierarchical and Dbscan
   c- Select No. of clusters in case of Kmeans and Hierarchical OR eps and minpts in case of DBscan
   d- You can also use optimum number of clusters as determined by the Nbclust function.
3- After providing all the parameters, the code will compute following:
   * Visulaization of each clustering algorithm along with the qulaity of clustering
"
#------------------------------------------------
"REQUIRED PACKAGES FOR Clustering"
#------------------------------------------------
#Cleaning the workplace to start over
cat("\f")       #Clear old outputs
rm(list=ls())   #Clear all variables

#Installing  Packages
if(!require("ggplot2")) install.packages("ggplot2")         #For visualizations
if(!require("ggdendro")) install.packages("ggdendro")       #For making different Dendograms
if(!require("factoextra")) install.packages("factoextra")   #For using fviz function (used for visualization)
if(!require("NbClust")) install.packages("NbClust")         #For Determining optimum no. of Clusters

#Add the associated libraries to the program
library("ggplot2")
library("ggdendro")
library("factoextra")
library("NbClust")
#------------------------------------------------
"SELECTION OF DATASET AND PARAMETERS"
#------------------------------------------------
print(paste("Please select Input CSV"), quote = FALSE)
file1 <- read.csv(file.choose(), header = TRUE, sep = ",")

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#User input for type of CLUSTERING
ask_clustering <- as.character(readline(prompt = "Enter either type of CLUSTERING, 'kmeans' or 'hierarchical' or 'dbscan: "))

#numerical data
matrix <- file1[,start_num : end_num] #all cont. variables

cat("\f")       # Clear old outputs
#----------------------------------------------
"Calculation and Visualization for CLUSTERING"
#----------------------------------------------
#Determining the optimum number of clusters
nb <- NbClust(matrix, distance = "euclidean", min.nc = 2,
              max.nc = 5, method = "complete", index ="all")

#Visualize the result
fviz_nbclust(nb) + theme_minimal()

#Types of Cluster Distances
#1. "euclidean"  : SQRT(sum_i:(xi-i)2).
#2. "maximum"    : Maximum distance between two components of x and y
#3. "manhattan"  : Absolute distance between the two vectors (1 norm aka L1).
#4. "canberra"   : Sum:i|xi?-yi|/(|xi|+|yi|).
#5. "binary"     : The vectors are regarded as binary bits, so non-zero elements are "on" and zero elements are "off".
#6. "minkowski"  : The p norm, the pth root of the sum of the pth powers of the differences of the components.

#---------------------
"K-Means Clustering"
#---------------------
if (ask_clustering=='kmclust') {
  
  #Taking number of clusters from user
  k <- as.integer(readline(prompt = "Input number of clusters required:"))
  
  #Performing K-means clustering giving number of clusters
  k_means <- eclust(matrix, "kmeans",hc_metric = "euclidean", 4 , nstart = 25, graph = TRUE)
  
  #Visualize k-means clusters
  fviz_cluster(k_means, geom = "point", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal())  # Visualization of the clusters
  
  #Quality Of clustering Using Silhouette Function
  fviz_silhouette(k_means)
  
  #-------------------------
  "Hierarchical Clustering"
  #-------------------------
} else if(ask_clustering=='hiclust'){
  
  #Taking number of clusters from user #
  K <- readline(prompt = "Input number of clusters required:")
  k<- as.integer(K)
  
  #Hierarchical clustering giving number of clusters
  h_clust <- eclust(matrix, "hclust", 4 , hc_metric = "euclidean", graph = FALSE)
  
  #Visualize Hierarchical clusters by dendrograms
  fviz_dend(h_clust, show_labels = FALSE, palette = "jco", as.ggplot = TRUE)
  
  #Making Heatmaps
  heatmap(as.matrix(h_clust$data))
  
  #Quality Of clustering Using Silhouette Function
  fviz_silhouette(h_clust)
  
  #--------------------
  "DBSCAN"
  #--------------------
} else if (ask_clustering=='dbclust') {
  
  #Parameters which you will be needing to give for Dbscan
  #epsilon (eps) - minimum radius for each point where the algorithm will search for minPts
  
  #minimum points (minPts) - minimum number of neighboring points required for a point in its eps to be considered a core point
  #Input values for "eps" & "minPts"
  eps <- readline(prompt = "Enter your value for epsilon : ")
  minPts <- readline(prompt = "Enter minPts for CLuster formation ")
  
  #Performing DBSCAN clustering on parameters eps & minPts
  dbscan <- fpc::dbscan(matrix, eps = eps, MinPts = minPts)      # performing DBSCAN
  dbscan
  
  #Visualize clusters
  fviz_cluster(dbscan, matrix, stand = FALSE, ellipse = TRUE, geom = "point")
  
  #Quality Of clustering Using Silhouette Function
  fviz_silhouette(dbscan)
}
print(paste("FINISHED"), quote = FALSE)
cat("\f")       #Clear old outputs
