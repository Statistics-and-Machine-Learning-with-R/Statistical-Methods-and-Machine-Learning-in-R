"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains only numeric variables with headers for the code and one
   first column with Name of the Elements (for sample check the dataset provided with the
   name 'German_state_results')
   
                   Column(Variable) 1      Column(Variable) 2     . . . .    Column(Variable) n
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      Row(Instance) n      (Value)                  (Value)           . . . .         (Value)
      
2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- Select Dataset to work on (after screen pops out) and the type of Separator
   b- Select what type of clustering you want out of Kmeans, Hierarchical and Dbscan
   c- You can also visualize the optimum number of clusters as determined by the Nbclust function.
 
   For K-Means
   d- Select distance measure : Euclidean, Manhattan, Bray-Curtis.... 
   e- Select number of clusters to be calculated

   For Hierarchical (Agglomerative)
   f- Select distance measure : Euclidean, Manhattan, Bray-Curtis...
   g- Select linkage criteria : Single, Complete, Average, Ward's method...

   For DBSCAN
   h- Select epsilon (minimum radius for each datapoint to be consired part of a dense region) 
   i- Select Minimum Points (least number of points to required to form a cluster in a dense region)
   
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
fname <- file.choose()

#Choose the Separator for file
ask_sep <- as.character(readline(prompt = "ENTER the SEPARATOR for file(',' or ';') : "))

#numeric data file
file1 <- read.csv(fname, header = TRUE, sep = ask_sep)

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
cat("\f")       #Clear old outputs
end_num   <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#User input for type of CLUSTERING
ask_clustering <- as.character(readline(prompt = "Enter either type of CLUSTERING, 'kmeans' or 'hierarchical' or 'dbscan' : "))

#numerical data
matrix <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs
#----------------------------------------------
"Calculation and Visualization for CLUSTERING"
#----------------------------------------------
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
if (ask_clustering=='kmeans') {
  
  #Taking the preferred distance metric from the user
  ask_dis <- readline(prompt = "SELECT the distance measure from 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary': ")
  
  #Taking number of clusters from the user
  cat("\f")       # Clear old outputs
  ask_k <- as.integer(readline(prompt = "Input number of clusters required: "))
  
  #Determining the optimum number of clusters
  nb <- NbClust(matrix, distance = ask_dis, min.nc = 2, max.nc = 5, method = "kmeans", index ="all")
  
  #Visualize the result
  print(fviz_nbclust(nb) + theme_minimal())
  
  #Performing K-means clustering giving number of clusters
  k_means <- eclust(matrix, "kmeans",hc_metric = ask_dis, ask_k , nstart = 25, graph = TRUE)
  
  #Visualize k-means clusters
  print(fviz_cluster(k_means, geom = "text", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal()))  # Visualization of the clusters
  
  #Quality Of clustering Using Silhouette Function
  print(fviz_silhouette(k_means))
  
  #-------------------------
  "Hierarchical Clustering"
  #-------------------------
} else if(ask_clustering=='hierarchical'){
  
  #Taking the preferred distance metric from the user:
  #You have choice b/w 
  
  #Taking the preferred distance metric from the user
  ask_dist <- readline(prompt = "SELECT the distance measure from 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary': ")
  
  #Taking the preferred linkage method from the user:
  cat("\f")       # Clear old outputs
  ask_clust <- readline(prompt = "SELECT the distance measure from 'single', 'complete', 'average', 'Ward.D' : ")
  
  #Hierarchical clustering giving number of clusters
  h_clust <- eclust(matrix, "hclust" , hc_metric = ask_dist, hc_method = ask_clust, graph = FALSE)
  
  #Visualize Hierarchical clusters by dendrograms
  print(fviz_dend(h_clust, show_labels = TRUE, palette = "jco", as.ggplot = TRUE))
  
  #Making Heatmaps
  print(heatmap(as.matrix(h_clust$data)))
  
  #Quality Of clustering Using Silhouette Function
  print(fviz_silhouette(h_clust))
  
  #--------------------
  "DBSCAN"
  #--------------------
} else if (ask_clustering == 'dbscan') {
  
  #Parameters which you will be needing to give for Dbscan
  #epsilon (eps) - minimum radius for each point where the algorithm will search for minPts
  #minimum points (minPts) - minimum number of neighboring points required for a point in its eps to be considered a core point
  
  #Input values for "eps" & "minPts"
  eps <- readline(prompt = "Enter your value for epsilon: ")
  cat("\f")       # Clear old outputs
  minPts <- readline(prompt = "Enter minPts for cluster formation: ")
  
  #Performing DBSCAN clustering on parameters eps & minPts
  dbscan <- fpc::dbscan(matrix, eps = eps, MinPts = minPts)      # performing DBSCAN
  
  #Visualize clusters
  print(fviz_cluster(dbscan, matrix, stand = FALSE, ellipse = TRUE, geom = "point"))
}

options(warn = -1)
cat("\f")       #Clear old outputs
print(paste("FINISHED"), quote = FALSE)
