"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains  NUMERIC variables. (for sample check the dataset provided with the 
   name ' German_State_Results')
   
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
   b- Ranges of numeric data from columns
   
3- After providing all the parameters, the code will compute following:
   * SCREE plot              
   * INDIVIDUAL instances on Principl Coordinates
   * Bi-plot for individual and variables on PCs
"
#------------------------------------------------
"REQUIRED PACKAGES FOR CA"
#------------------------------------------------
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Installing  Packages
# Package for package administration:
if(!require("factoextra")) install.packages("factoextra") 
if(!require("FactoMineR")) install.packages("FactoMineR")

# Add the associated libraries to the programm
library("factoextra")
library("FactoMineR")

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

#Sub space the numeric matrix
matrix <- file2[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs

#------------------------------------------------
"CA RESULTS"
#------------------------------------------------
#apply CA analysis on the matrix
ca <- CA(matrix, graph = T)

ca_eig <- get_eigenvalue(ca)

fviz_screeplot(ca) + geom_hline(yintercept=33.33, linetype=0, color="red")
row <- get_ca_row(ca)

#individual instances plot on PCs
fviz_ca_row(ca) 

# repel= TRUE to avoid text overlapping (slow if many point)
fviz_ca_biplot(ca, repel = F)

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
