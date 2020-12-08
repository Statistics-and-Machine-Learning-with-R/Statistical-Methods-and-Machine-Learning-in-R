#-------------------------------------------------------------------------------------------------------------
" Ordination : PCA" 
#-------------------------------------------------------------------------------------------------------------


# Cleaning the workspace to start over

cat("\f")       # Clear old outputs

rm(list=ls())   # Clear all variables

#-------------------------------------------------------------------------------------------------------------
"HEADER OF THE SOFTWARE OUTPUT"
#-------------------------------------------------------------------------------------------------------------

sourceAuthor  <-  "META PRO STAT TEAM"
sourceDate    <-  "10.08.2020"
sourceVersion <-  "1.2.2"


# Inforamtion about the software:

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
if(!require("reshape2")) install.packages("reshape2") 




# Add the associated libraries to the programm
library("ggplot2")
library("factoextra")
library("vegan")
library("ape")
library("reshape2")





#------------------------------------------------
"Get the matrix and Choose Groups"
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()
file1 <- read.csv(fname, sep=',')

#Extract contineous variables: (If there are columns/variables with categories,first remove them)


matrix <- file1[,1:4]  #all variables except 5th(States)


#--------------------------------------------------
"Calculation and Visualization for PCA"
#--------------------------------------------------


"PCA(Principal Component Analysis)"


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





"Redundancy Analysis (RDA)"




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





#--------------------------------------------------
"Finish"
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)





