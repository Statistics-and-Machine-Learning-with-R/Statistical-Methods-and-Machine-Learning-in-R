"
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
   
3- After providing all the parameters, the code will compute following:
   * SCREE plot              
   * INDIVIDUAL instances on Principl Coordinates
   * BI-PLOT (INDIVIDUAL instances + VARIABLES) on Principle Coordiantes
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
outputname <- 'Distance_matrix_PCOA'

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
ask_dist <- as.character(readline(prompt = "ENTER either of the  DISTANCE meansure  : "))

#------------------------------------------------
"PCoA RESULTS"
#------------------------------------------------
#Make distance-Matrix and use method of distance:
dist <- vegdist(matrix,  method = ask_dist)

#Reshape distance matrix into viewbale form
dist_matrix <- as.matrix(dist, labels = T)

#Apply PCoA on distance-matrix, pcoa() is included in package APE which performs PCoA
PCOA <- pcoa(dist_matrix)

#Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis
barplot(PCOA$values$Relative_eig[1:2])

#Individual Instances on Principle Coordinates
biplot(PCOA, choices = c(1,2),
       type = "text",
       display = 'site') # biplot of axis 1 vs 2


#Biplot on Principle Coordinates
biplot(PCOA,file2[,start_num : end_num])
#--------------------------------------------------
"EXPORT THE DISTANCE MATRIX INTO CSV"
#--------------------------------------------------

#Write to csv file on current working directory
write.table(dist_matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ask_sep,
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
