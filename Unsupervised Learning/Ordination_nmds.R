"
1- Please make sure your csv file contains  NUMERIC variables .

2- To run the code, select the whole code and run as 'source with echo' (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Ranges of numeric data from columns
   c- Distance measure to be implemented ('bray', 'manhattan' or 'eucladian')
   
3- After providing all the parameters, the code will compute following:
   * STRESS plot              
   * INDIVIDUAL instances on Principl Coordinates
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

#User input for data:
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
file1 <- read.csv(file.choose(), sep=',')
cat("\f")       # Clear old outputs

#Extract continuous variables:
start_num <- as.integer(readline(prompt = "Enter value for START of range of numerical variable: "))
cat("\f")       # Clear old outputs
end_num <- as.integer(readline(prompt = "Enter value for END of range of numerical variable: "))

#Sub space the nuermic dataframe:
matrix <- file1[,start_num : end_num] #all cont. variables
cat("\f")       # Clear old outputs

#User input for Distance Measure
ask_dist <- as.character(readline(prompt = "ENTER either of the  DISTANCE meansure 'manhattan', 'euclidean', 'bray' : "))

#------------------------------------------------
"NMDS RESULTS"
#------------------------------------------------
"NMDS (Non-metric Multidimensional Scaling)"
#calculate the distance matrix
dist = vegdist(matrix, method = ask_dist)

#reshape distance matrix into viewbale form
dist_matrix <- as.matrix(dist, labels = T)


# apply NMDS on matrix, metaMDS is included in package VEGAN which performs NMDS :
nmds <- metaMDS(dist_matrix,
                distance = ask_dist,
                k = 3,
                maxit = 999, 
                trymax = 500,
                wascores = T)

# Produces a results of test statistics for goodness of fit for each point
goodness(nmds) 

# Stress plot
stressplot(nmds) 


# Plotting points in ordination space
plot(nmds, "sites")   # Produces distance 
orditorp(nmds, "sites")  

#--------------------------------------------------
"EXPORT THE DISTANCE MATRIX INTO CSV"
#--------------------------------------------------
#Write DISTANCE MATRIX into csv file at your current working directory
write.table(dist_matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)




