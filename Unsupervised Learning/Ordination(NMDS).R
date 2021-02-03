#######################
## Ordination : NMDS ##
#######################


# Cleaning the workspace to start over

cat("\f")       # Clear old outputs

rm(list=ls())   # Clear all variables


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
"Calculation and Visualization for ORDINATION"
#--------------------------------------------------

"NMDS (Non-metric Multidimensional Scaling)"


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



#--------------------------------------------------
"Finish"
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)





