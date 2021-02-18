"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains  NUMERIC variables with headers 
   
                    Column(Variable) 1      Column(Variable) 2     . . . .    Column(Variable) n
      
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Instance) n      (Value)                  (Value)           . . . .         (Value)
      
2- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Type of Separator for the input file
   c- Ranage of Variable Colummns
   
3- After providing all the parameters, the code will compute following:
   * For respective (RDA) analysis
   * SCREE plot              
   * INDIVIDUAL instances on Principl Coordinates
   * BI-PLOT (INDIVIDUAL instances + VARIABLES) on Principle Coordiantes
"
#------------------------------------------------
"REQUIRED PACKAGES FOR RDA"
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
"RDA RESULTS"
#------------------------------------------------
#performing RDA analysis on the data
RDA <- rda(matrix, scale= ask_scale) #scale=T implies we can scale our data

#Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis
print(barplot(as.vector(RDA$CA$eig)/sum(RDA$CA$eig)) )


#Individual_Instances on PCs
print(plot(RDA, display = 'site', type = 'text'))

#Variables on PCs
print(plot(RDA, display = 'species', type = 'text'))


#Biplot(Individual elements & variables)
print(biplot(RDA, choices = c(1,2),
             type = c('text', 'text'),
             display = c('site','species'))) # biplot of axis 1 vs 2


options(warn = -1)
cat("\f")       #Clear old outputs
print(paste("FINISHED"), quote = FALSE) 