#-------------------------------------------------------------------------------------------------------------
#                                        PCA, PCOA AND NMDS
#-------------------------------------------------------------------------------------------------------------


# Cleaning the workspace to start over

cat("\f")       # Clear old outputs

rm(list=ls())   # Clear all variables

#-------------------------------------------------------------------------------------------------------------
# HEADER OF THE SOFTWARE OUTPUT
#-------------------------------------------------------------------------------------------------------------

sourceAuthor  <-  "Robert Heyer/META PRO STAT TEAM"

sourceDate    <-  "10.08.2020"
sourceVersion <-  "1.0.1"


# Inforamtion about the software:

print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)



# Installing  Packages

# Package for package administration:
if(!require("ggplot2")) install.packages("ggplot2") 
if(!require("factoextra")) install.packages("factoextra") 
if(!require("vegan")) install.packages("vegan")
if(!require("ape")) install.packages("ape",repo='https://mac.R-project.org',dependencies = F)
#if(!require("ggbiplot")) install_github("vqv/ggbiplot")
if(!require("ggdendro")) install.packages("ggdendro") 
if(!require("reshape2")) install.packages("reshape2") 
if(!require("grid")) install.packages("grid") 
if(!require("NbClust")) install.packages("NbClust")



# Add the associated libraries to the programm
library("ggplot2")
library("factoextra")
library("vegan")
library("ape")
#library('ggbiplot')
library('devtools')
library("ggdendro")
library("reshape2")
library("grid")
library("cluster")
library("NbClust")


# MAIN PROGRAM STARTS HERE 

# # Declaration of parameters:
# SEPARATOR = ";"  # Separator within the csv. -files

# Output path:
# outputname = "Result_of_Ordiantion"

# outputname = "/Users/mac/Documents/Result_of_T&U_test.csv"



#------------------------------------------------
# STEP 1: Gets the matrix and Choose Groups
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()
file1 <- read.csv(fname, sep=',')

#Extract contineous variables: (If there are columns/variables with categories,first remove them)


matrix <- file1[,1:4]  #all variables except 5th(States)


#--------------------------------------------------
# STEP 2: Calculates PCA, PCoA & NMS
#--------------------------------------------------

#-------------------------------------
# PCA(Principal Component Analysis)
#-------------------------------------

#There are two general methods to perform PCA in R :
  #Spectral decomposition which examines the covariances / correlations between variables
  #Singular value decomposition which examines the covariances / correlations between individuals

#The function princomp() uses the spectral decomposition approach.
#The functions prcomp() and PCA()[FactoMineR] use the singular value decomposition (SVD).


PCA <- prcomp(matrix,scale=T,center = T) #scale/center=T implies we can scale/center our data

#Eigenvalues are stored under Rotation 
PCA$rotation

#Standard Deviation under sdev
PCA$sdev

#Visualize eigenvalues (scree plot). Show the percentage of variances explained by each principal component
fviz_eig(PCA)

### Access to the PCA results:

# Eigenvalues
eigVal <- get_eigenvalue(PCA)
eigVal

# Results for Variables
resVar <- get_pca_var(PCA)
resVar$coord          # Coordinates
resVar$contrib        # Contributions to the PCs
resVar$cos2           # Quality of representation 
# Results for individuals
resInd <- get_pca_ind(PCA)
resInd$coord          # Coordinates
resInd$contrib        # Contributions to the PCs
resInd$cos2           # Quality of representation 


#Graph of individuals. Individuals with a similar profile are grouped together.

fviz_pca_ind(PCA,
                   geom.ind = "point", # show points only (nbut not "text")
                   col.ind = file1$State, # color by group
                   addEllipses = TRUE, # Concentration ellipses,
                   legend.title = "State"
)


##Graph of variables. Positive correlated variables point to the same side of the plot. 
  #Negative correlated variables point to opposite sides of the graph.

fviz_pca_var(PCA,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("red", "blue", "green"),
             repel = TRUE     # Avoid text overlapping
)

# Biplot of individuals and variables.

 fviz_pca_biplot(PCA, repel = F,
                
                col.var = "black", # Variables color,
                legend.title= 'States',
                col.ind = file1$State,# Individuals color according to States
                addEllipses = T  # add ellipse around individuals
)




#Overlay in forms of vectors:
# fviz_add(q,groups,geom='arrow',color='red')

 
#Overlay in forms of individuals:
 
groups <-  as.factor(file1$Wealth)
 
fviz_pca_biplot(PCA,
             col.ind = groups, # color by groups
             palette = c("red",  "blue",'green'),
             addEllipses = F, # Concentration ellipses
             legend.title = "Groups",
             
)

#-------------------------------------
# Redundancy Analysis (RDA)
#-------------------------------------
typeof(file1$Rich)

# apply RDA on matrix, rda() is included in package VEGAN which performs RDA :


RDA <- rda(matrix,scale=T) #scale=T implies we can scale our data

#Eigenvalues?
RDA$CA$eig

# Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis

barplot(as.vector(RDA$CA$eig)/sum(RDA$CA$eig)) 


# How much of the variance in our dataset is explained by the first principal component?

# Calculate the percent of variance explained by first two axes
sum((as.vector(RDA$CA$eig)/sum(RDA$CA$eig))[1:2]) # 95%, this is ok.




# display

# display = sites corresonds to the rows of data; one datapoint per row
# display = species corresponds to the columns of data; one line/arrow per column


# type

# type = text plots row numbers and column names as labels
# type = points plots points

plot(RDA, display = "site", type = "point")
plot(RDA, display = "species", type = "text")

# In a biplot of a RDAA, species' scores are drawn as arrows that point in the direction of increasing values for that variable

biplot(RDA, choices = c(1,2),
       type = c("text", "points"),
       display = c('site','species')) # biplot of axis 1 vs 2

biplot(RDA, choices = c(1,3), 
       type = c("text","points"),
       display = c('site','species')) # biplot of axis 1 vs 3




#-------------------------------------
# PCoA(Principal Coordinate Analysis)
#-------------------------------------

# Make distance-Matrix and use method of distance:


dist <- vegdist(matrix,  method = "bray")

# apply PCoA on distance-matrix, pcoa() is included in package APE which performs PCoA
PCOA <- pcoa(dist)

# Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis

barplot(PCOA$values$Relative_eig)

#How much of the variance in our dataset is explained by the first principal component?

# Calculate the percent of variance explained by first two axes
sum(PCOA$values$Relative_eig[1:2]) # 97%, this is ok.

#site_score
sitePCoA <- PCOA$vectors
#View(sitePCoA) #Axis.1 is same as PC1 and so-on(difference in name due to different package)



?biplot()
biplot(PCOA,file1[,1:4])
biplot(PCOA, choices = c(1,2),
       type = c("text", "points"),
       display = c('site','species')) # biplot of axis 1 vs 2




#----------------------------------------------
# NMDS (Non-metric Multidimensional Scaling)
#----------------------------------------------

# apply NMDS on matrix, metaMDS is included in package VEGAN which performs NMDS :
NMDS_CALC <- metaMDS(matrix, k = 2, trymax = 100, trace = F, autotransform = FALSE, distance="bray")
NMDS_CALC

#bootstraping and testing for differences in groups:
fit <- adonis(matrix ~ file1$State,permutations = 999,method = 'bray')
fit # P-value less than 0.05 shows groups are different

#Stress Plot
stressplot(NMDS_CALC) 

#Plot to visualize NMDS
ord_NMDS=ordiplot(NMDS_CALC,type="t")

## Plot ordination in a way that points are colored and shaped according to groups of interest

co= c('red','blue','green')
shape = c(13,18,22)

plot(NMDS_CALC$points,col=co[file1$State],pch= shape[file1$State],cex=0.6,
     main = 'Difference between State Results', xlab = 'Axis 1',ylab = 'Axis 2')

# Connect points using Ordispider
ordispider(NMDS_CALC,groups = file1$State,label = T)






#----------------------------------------------
# STEP 5: Clustering Initialization
#----------------------------------------------



# Determining the optimum number of clusters 
nb <- NbClust(matrix, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "complete", index ="all")

# Visualize the result
fviz_nbclust(nb) + theme_minimal()


# Taking number of clusters from user

K <- readline(prompt = "Input number of clusters required:")
k<- as.integer(K)


help(eclust)

# Types of Cluster Distances
# 1. "euclidean"  : SQRT(SUMMe_i:(xi-i)2).
# 2. "maximum"    : Maximum distance between two components of x and y (supremum norm)
# 3. "manhattan"  : Absolute distance between the two vectors (1 norm aka L1).
# 4. "canberra"   : summe:i|xi?-yi|/(|xi|+|yi|). 
# 5. "binary"     : The vectors are regarded as binary bits, so non-zero elements are "on" and zero elements are "off".
# 6. "minkowski"  : The p norm, the pth root of the sum of the pth powers of the differences of the components.



#----------------------------------------------
# STEP 6: K-Means Clustering
#----------------------------------------------


# Performing K-means clustering giving number of clusters  

k_means <- eclust(matrix, "kmeans",hc_metric = "euclidean", k , nstart = 25, graph = TRUE)


# Visualize k-means clusters
fviz_cluster(k_means, geom = "point", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal())  # Visualization of the clusters



#----------------------------------------------
# STEP 7: Hierarchical Clustering
#----------------------------------------------

# Hierarchical clustering giving number of clusters
h_clust <- eclust(matrix, "hclust", k , hc_metric = "euclidean", graph = FALSE)



# Visualize Hierarchical clusters by dendograms
fviz_dend(h_clust, show_labels = FALSE, palette = "jco", as.ggplot = TRUE)

# Making heatmaps

heatmap(as.matrix(h_clust$data))

#------------------------------------------------------------------
# STEP 8: Using Silhouette for measuring the quality of clustering
#-----------------------------------------------------------------

# Using Silhouette Function
fviz_silhouette(k_means)
fviz_silhouette(h_clust)


#--------------------------------------------------
# STEP 9: Overlaying Results onto NMDS plot
#--------------------------------------------------

# ordicluster: which connects similar communities 
#(useful to see if treatments are effective in controlling community structure)

ordicluster(ord_NMDS, h_clust)






#--------------------------------------------------
# STEP 10: Finish
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)





