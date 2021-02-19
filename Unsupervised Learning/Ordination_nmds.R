"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains  NUMERIC variables .

   
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
   
   a- Dataset to work on (after screen pops out)
   b- Ranges of numeric data from columns
   c- Distance measure to be implemented ('manhattan', 'euclidean', 'canberra', 'clark', 
   'bray', 'kulczynski', 'jaccard', 'gower', 'altGower', 'morisita', 'horn', 'mountford', 'raup', 
   'binomial', 'chao', 'cao' or 'mahalanobis')
   
   a- dataset to work on (after screen pops out)
   b- Type of Separator for input and output file
   c- Ranges of numeric data from columns
   d- Distance measure to be implemented ('bray', 'manhattan' or 'eucladian')
   
3- After providing all the parameters, the code will compute following:
   * STRESS plot              
   * INDIVIDUAL instances on Coordinates
   * Biplot for Instances and variables
   * DISTANCE MATRIX will get saved at your current working directory into a CSV fromat
"
#------------------------------------------------
"REQUIRED PACKAGES FOR PCoA"
#------------------------------------------------
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Installing  Packages
# Package for package administration:
if(!require("vegan")) install.packages("vegan")
if(!require("ape")) install.packages("ape",repo='https://mac.R-project.org',dependencies = F)

# Add the associated libraries to the programm
library("vegan")
library("ape")

cat("\f")       # Clear old outputs
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------
#Output file name:
outputname <- 'Distance_matrix_NMDS'

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

#ask user for type of DISTANCE measure:
print("manhattan', 'euclidean', 'canberra', 'clark', 'bray', 'kulczynski', 'jaccard', 'gower', 'altGower', 'morisita', 'horn', 'mountford', 'raup', 'binomial', 'chao', 'cao' or 'mahalanobis'")
ask_dist <- as.character(readline(prompt = "ENTER either of the  DISTANCE meansure : "))

#------------------------------------------------
"NMDS RESULTS"
#------------------------------------------------
"NMDS (Non-metric Multidimensional Scaling)"
#calculate the distance matrix
dist = vegdist(matrix, method = ask_dist)

#reshape distance matrix into viewbale form
dist_matrix <- as.matrix(matrix, labels = T)


# apply NMDS on matrix, metaMDS is included in package VEGAN which performs NMDS :

'trymax = Minimum and maximum numbers of random starts in search of stable solution. 
After try has been reached, the iteration will stop when two convergent solutions were 
found or trymax was reached.
'
nmds <- metaMDS(dist_matrix,
                distance = ask_dist, 
                k = 2,       # number of dimensions
                maxit = 999, #maximum iterations that can be done
                trymax = 500,
                wascores = T) #function that calculates the Species score

# Produces a results of test statistics for goodness of fit for each point
goodness(nmds) 

# Stress plot
print(stressplot(nmds)) 


#Individual_Instances on PCs
print(plot(nmds, display = 'site', type = 'text'))

#Biplot for NMDS
print(ordiplot(nmds,type="t"))
#--------------------------------------------------
"EXPORT THE DISTANCE MATRIX INTO CSV"
#--------------------------------------------------
#Write DISTANCE MATRIX into csv file at your current working directory
write.table(dist_matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ask_sep,
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
