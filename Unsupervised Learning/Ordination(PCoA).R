#-------------------------------------------------------------------------------------------------------------
" Ordination : PCOA" 
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
"Calculation and Visualization for PCoA"
#--------------------------------------------------



"PCoA(Principal Coordinate Analysis)"




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







#--------------------------------------------------
"Finish"
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)





