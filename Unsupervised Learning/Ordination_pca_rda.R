"
1- Please make sure your csv file contains  NUMERIC variables with headers for the code and  
   last column with CATEGORICAL variables (for sample check the dataset provided with the 
   name ' German_State_Results').
2- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Ranges of both groups (Group-1 and Group-2)
   c- which analysis to be implemented (PCA or RDA)
   
3- After providing all the parameters, the code will compute following:
   * For respective (PCA or RDA) analysis
   * SCREE plot              
   * INDIVIDUAL instances on Principl Coordinates
   * BI-PLOT (INDIVIDUAL instances + VARIABLES) on Principle Coordiantes
"
#------------------------------------------------
"REQUIRED PACKAGES FOR PCA and RDA"
#------------------------------------------------

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Installing  Packages
# Package for package administration:
if(!require("factoextra")) install.packages("factoextra") 
if(!require("vegan")) install.packages("vegan")



# Add the associated libraries to the programm
library("factoextra")
library("vegan")


cat("\f")       # Clear old outputs
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------
#User input for data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
file1 <- read.csv(file.choose(), sep=',')
cat("\f")       # Clear old outputs

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#ask user for type of  analysis:
ask_pca_rda <- as.character(readline(prompt = "ENTER either of the types of Analysis 'pca' or 'rda' : "))

#ask user for scaling:
ask_scale <- as.logical(readline(prompt = "Enter 'TRUE' if scaling of data is require otherwise 'FALSE' : "))

#Sub space the numeric matrix
matrix <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs
#------------------------------------------------
"PCA RESULTS"
#------------------------------------------------
#User input dependent loop
if (ask_pca_rda== 'pca'){
  
  
  
  
  #PCA calculations
  PCA <- prcomp(matrix, scale = ask_scale) #scale=T implies we can scale/center our data
  
  
  cat("\f")       # Clear old outputs
  
  ##scree plot PCA
  print(screeplot(PCA))
  
  #Individual_Element_effect
  print(fviz_pca_ind(PCA,
                     geom.ind = "text", # show points only (nbut not "text")
                     addEllipses = F # Concentration ellipses,
                     
  ))
  
  
  #Biplot(Individual elements & variables)
  print(fviz_pca_biplot(PCA,
                        geom.ind = "text", # show points only (nbut not "text")
                        col.ind = file1[,ncol(file1)], # color by group
                        addEllipses = TRUE, # Concentration ellipses,
                        legend.title = colnames(file1)[ncol(file1)]
                        
  ))
  
  #------------------------------------------------
  "RDA RESULTS"
  #------------------------------------------------   
  
} else if (ask_pca_rda== 'rda'){
  
  RDA <- rda(matrix,scale= ask_scale) #scale=T implies we can scale our data
  
  # Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis
  print(barplot(as.vector(RDA$CA$eig)/sum(RDA$CA$eig)) )
  
  
  #Individual_Element_effect
  print(plot(RDA, display = 'site', type = 'text'))
  
  #Biplot(Individual elements & variables)
  print(biplot(RDA, choices = c(1,2),
               type = c('text', 'points'),
               display = c('site','species'))) # biplot of axis 1 vs 2
  
}

options(warn = -1)
cat("\f")       #Clear old outputs
print(paste("FINISHED"), quote = FALSE)  
