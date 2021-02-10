"
1- Please make sure your csv file contains  NUMERIC variables with headers for the code and  
   one column with CATEGORICAL variables (for sample check the dataset provided with the 
   name ' German_State_Results').

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
   b- Type of separator within Input file
   b- Ranges of both groups (Group-1 and Group-2)
   c- Column number of Cateogrical varibale
   
3- After providing all the parameters, the code will compute following:
   * Calculation fpr respective (CCA)) analysis
   * Multiple corelation plots              
   * Corelation coeffecient score saved in CSV file
"
#------------------------------------------------
"REQUIRED PACKAGES FOR CCA"
#------------------------------------------------
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Installing  Packages
# Package for package administration:
if(!require("CCA")) install.packages("CCA") 
if(!require("CCP")) install.packages("CCP")
if(!require("ggplot2")) install.packages("ggplot2")
if(!require("tidyverse")) install.packages("tidyverse")

# Add the associated libraries to the programm
library(CCA) #facilitates canonical correlation analysis
library(CCP) #facilitates checking the significance of the canonical variates
library(ggplot2)
library(tidyverse)

cat("\f")       # Clear old outputs
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------
#Output Results name
outputname <- 'Results_of_cca'

#User input for data
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()

#ask user for type of  Separator:
ask_sep <- as.character(readline(prompt = "ENTER either of the types of Separator ',' or ';' : "))

#Input file read
file1 <- read.csv(fname, sep=ask_sep)
cat("\f")       # Clear old outputs

#List for Start of the groups:
group_start <- list()

#List for End of the groups:
group_end <- list()

for (i in 1:2) {
  group_start[i] <- as.integer(readline(prompt = "Enter values for Start of group: "))
  group_end[i]   <- as.integer(readline(prompt = "Enter values for End of group: "))
}

#ask user for type of  Separator:
ask_attr <- as.integer(readline(prompt = "ENTER the column number of CATEGORICAL variable : "))

cat("\f")       # Clear old outputs
#------------------------------------------------
"CCA RESULTS"
#------------------------------------------------
#Sub space the numeric matrix
#One group with some variables and Scalled
group_1 <- scale(file1[,group_start[[1]] : group_end[[1]]])

#Second group with some selected variables and Scalled
group_2 <- scale(file1[,group_start[[2]] : group_end[[2]]])

"
CCA aims to find the associations between two data matrices (two sets of variables) X and Y.
CCA’s goal is to find the linear projection of the first data matrix that is maximally correlated 
with the linear projection of the second data matrix.

To perform classical CCA, we use cancor() function CCA R package. 
cancor() function computes canonical covariates between two input data matrices. 
By default cancor() centers the columns of data matrices.

"
#applt CCA analysis
cca <- cancor(group_1, group_2)

"
We can use our data Group-1 & Group-2 and the corresponding coefficients to get the canonical 
covariate pairs. In the code below, we perform matrix multiplication with each data sets and 
its first (and second separately) coefficient column to get the first canonical covariate pairs.
"
canonical_covariate_group_1 <- as.matrix(group_1) %*% cca$xcoef[, 1]
canonical_covariate_group_2 <- as.matrix(group_2) %*% cca$ycoef[, 1]

#cca2_x <- as.matrix(group_1) %*% cca$xcoef[, 2]
#cca2_y <- as.matrix(group_2) %*% cca$ycoef[, 2]

#Corelarion among group-1 and group2
cor(canonical_covariate_group_1,canonical_covariate_group_2)

#Results of CCA Analysis (Respective canonical covariate pairs)
cca_results <-  mutate(.data = file1, canonical_covariate_group_1, canonical_covariate_group_2)

#Extract the Cateogrical column and later on use in Visualization
Cateogry <- cca_results[[ask_attr]]

#Canonical Covariate of Group_1 vs Cateogries(Species)
ggplot(data = cca_results, aes(x=Cateogry,y=canonical_covariate_group_1, color= Cateogry))+geom_point()

#Canonical Covariate of Group_2 vs Cateogries(Species)
ggplot(data = cca_results, aes(x=Cateogry,y=canonical_covariate_group_2, color= Cateogry))+geom_point()


#Canonical Covariate of Group_1 vs Canonical Covariate of Group_2
ggplot(data = cca_results, aes(x=canonical_covariate_group_1,y=canonical_covariate_group_2, color= Cateogry))+geom_point()

cat("\f")       # Clear old outputs
#--------------------------------------------------
"EXPORT THE RESULTS INTO CSV"
#--------------------------------------------------
# Output file:
write.table(cca_results, file = paste(outputname), append = FALSE, quote = TRUE, sep = ask_sep,
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")

cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)







