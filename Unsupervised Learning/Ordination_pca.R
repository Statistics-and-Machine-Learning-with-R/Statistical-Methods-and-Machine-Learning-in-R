"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains  NUMERIC variables with headers.
   
                   Column(Instance) 1      Column(Instance) 2         . . . .    Column(Instance) n
      
      Row(Variable) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Variable) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Variable) n      (Value)                  (Value)           . . . .         (Value)
      
2- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Type of Separator for the input file
   c- Ranage of Variable Colummns
   
3- After providing all the parameters, the code will compute following:
   * For respective (PCA) analysis
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
fname <- file.choose()
#Choose the Separator for file
ask_sep <- as.character(readline(prompt = "ENTER the SEPARATOR for file(',' or ';') : "))

file1 <- read.csv(fname, sep = ask_sep, row.names = 1)
cat("\f")       # Clear old outputs

#Transpose of data for ecological data
file2 <- t(file1)

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#ask user for scaling:
ask_scale <- as.logical(readline(prompt = "Enter 'TRUE' if scaling of data is require otherwise 'FALSE' : "))

#Sub space the numeric matrix
matrix <- file2[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs
#------------------------------------------------
"PCA RESULTS"
#------------------------------------------------
  
#PCA calculations
PCA <- prcomp(matrix, scale = ask_scale) #scale=T implies we can scale/center our data
cat("\f")       # Clear old outputs
  
##scree plot PCA
print(screeplot(PCA))
  
#Individual_Element_effect
print(fviz_pca_ind(PCA,geom.ind = "text", # show points only
                   addEllipses = F ))
  
  
#Biplot(Individual elements & variables)
print(fviz_pca_biplot(PCA,geom.ind = "text", # show points only
                        addEllipses = F ))
  
 
options(warn = -1)
cat("\f")       #Clear old outputs
print(paste("FINISHED"), quote = FALSE) 
