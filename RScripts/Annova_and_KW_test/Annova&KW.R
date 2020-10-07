# Cleaning the workspace


cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

#-------------------------------------------------------------------------------------------------------------
# HEADER OF THE  OUTPUT
#-------------------------------------------------------------------------------------------------------------
sourceAuthor  <-  "META PRO STAT TEAM"
sourceDate    <-  "12.05.2020"
sourceVersion <-  "1.0.1"

# Inforamtion about the software
print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)

# Installing  Packages
# Package for package administration
if(!require("miniCRAN")) install.packages("miniCRAN") 

# Package for a layout theme for the violone plots
if(!require("dplyr")) install.packages("dplyr") 

# Required for DUNN Posthoc test for Kruskall Wallis
if(!require("FSA")) install.packages("FSA") 

# Loading the required libraries to the programm
library("miniCRAN")
library("dplyr")
library("FSA")

# MAIN PROGRAM STARTS HERE 

# Declaration of parameters 
SEPARATOR = ";"  # Separator within the csv.-files

# Output path
#outputname = "RESULTS_ANOVA.csv"
# or
outputname = "C:\\Users\\abdullah.rizvi\\Desktop\\Studies\\DE Project Meta_Prot_Stat\\results\\R1.csv"


#------------------------------------------------
# STEP 1: Gets the matrix
#------------------------------------------------
# Choose the file from your PC

print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose() #Hint: MetaProtein.csv
matrix <- read.csv(fname, sep=SEPARATOR,row.names=1) 


#List for Start of the groups
Group_start <- list()
#List for End of the groups
Group_end <- list()


# Allows you to ask for Group ranges
for (i in 1:3){
  Group_start[i] <- readline(prompt = "Enter values for Start of group: ")
  Group_end[i] <- readline(prompt = "Enter values for End of group: ")
}

#Printing Lists for Start and End of the groups
#print(Group_start[1])
#print(Group_end[1])

# Final ranges for new groups 
index_for_new_groups = as.numeric(Group_end) - as.numeric(Group_start)+1
print(index_for_new_groups)


#************************************************



#--------------------------------------------------
# STEP 2: Calculates Anova and Kruskall Walles
#--------------------------------------------------

# Create a vector representing the assignment of the samples to the 3 groups as "1", "2" and "3" 

groups <- rep(1:3,index_for_new_groups) #Making space for the groups
groups <- factor(groups) #Making in factors so the system understand the groups
print(groups)

# Create new output vectors for the results
EMPTY                   <-  (rep("",nrow(matrix))) # + 1
average                 <-  (rep(0, nrow(matrix))) # + 2
average_group_1         <-  (rep(0, nrow(matrix))) # + 3
average_group_2         <-  (rep(0, nrow(matrix))) # + 4
average_group_3         <-  (rep(0, nrow(matrix))) # + 5

result_anova            <-  (rep(0, nrow(matrix))) # + 7
anova_2_1_diff_mean     <-  (rep(0, nrow(matrix))) # + 8
anova_2_1_padj          <-  (rep(0, nrow(matrix))) # + 9
anova_3_1_diff_mean     <-  (rep(0, nrow(matrix))) # + 10
anova_3_1_padj          <-  (rep(0, nrow(matrix))) # + 11
anova_3_2_diff_mean     <-  (rep(0, nrow(matrix))) # + 12
anova_3_2_padj          <-  (rep(0, nrow(matrix))) # + 13

result_kruskal_wallis   <-  (rep(0, nrow(matrix))) # + 15
kruskall_1_2_padj       <-  (rep(0, nrow(matrix))) # + 16
kruskall_1_3_padj       <-  (rep(0, nrow(matrix))) # + 17
kruskall_2_3_padj       <-  (rep(0, nrow(matrix))) # + 18

# Combined it to the output matrix
Resulting_Matrix <- cbind( matrix,
                           EMPTY, 
                           average,
                           average_group_1,
                           average_group_2,
                           average_group_3,
                           EMPTY,
                           result_anova,
                           anova_2_1_diff_mean,
                           anova_2_1_padj,
                           anova_3_1_diff_mean,
                           anova_3_1_padj,
                           anova_3_2_diff_mean,
                           anova_3_2_padj,
                           EMPTY,
                           result_kruskal_wallis,
                           kruskall_1_2_padj,
                           kruskall_1_3_padj,
                           kruskall_2_3_padj)

# Calculate the anova for all variables
for (i in 1:nrow(matrix)) {
  # Calculates the total and the group averages
  Resulting_Matrix[i,ncol(matrix) + 2] <- mean( as.numeric( matrix[i, 1 : ncol(matrix)] ))
  Resulting_Matrix[i,ncol(matrix) + 3] <- mean( as.numeric( matrix[i, Group_start[[1]] : Group_end[[1]]] ))
  Resulting_Matrix[i,ncol(matrix) + 4] <- mean( as.numeric( matrix[i, Group_start[[2]] : Group_end[[2]]] ))
  Resulting_Matrix[i,ncol(matrix) + 5] <- mean( as.numeric( matrix[i, Group_start[[3]] : Group_end[[3]]] ))
  
  
  # Calculates ANOVA 
  anova <- aov(as.numeric(matrix[i,1:ncol(matrix)])  ~  groups  , data = matrix) 
  Resulting_Matrix[i,ncol(matrix) + 7] <- unlist(summary(anova))["Pr(>F)1"]
  # Post-hoc test: tukey test to check differences between the groups
  tukey <- TukeyHSD(aov(as.numeric(matrix[i,1:ncol(matrix)])  ~  groups  , data = matrix))
  tukey <- as.data.frame(tukey[1])
  tukey
  
  # Add for comparisons differences of mean and adjusted p-value
  Resulting_Matrix[i,ncol(matrix) + 8] =tukey[1,1]
  Resulting_Matrix[i,ncol(matrix) + 9] =tukey[1,4]
  Resulting_Matrix[i,ncol(matrix) + 10] =tukey[2,1]
  Resulting_Matrix[i,ncol(matrix) + 11] =tukey[2,4]
  Resulting_Matrix[i,ncol(matrix) + 12] =tukey[3,1]
  Resulting_Matrix[i,ncol(matrix) + 13] =tukey[3,4]
  
  # Calculate Kruskall Walles  
  kruskal <- kruskal.test(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix)
  Resulting_Matrix[i,ncol(matrix) + 15] <- kruskal["p.value"]
  # Post-hoc test: DUNN Test
  dunn <- dunnTest(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix, method ="none")
  dunn.res <- as.data.frame(dunn[2])
  Resulting_Matrix[i,ncol(matrix) + 16] =dunn.res[1,4]
  Resulting_Matrix[i,ncol(matrix) + 17] =dunn.res[2,4]
  Resulting_Matrix[i,ncol(matrix) + 18] =dunn.res[3,4]
}


#--------------------------------------------------
# STEP: 3. Export the results
#--------------------------------------------------
# https://stat.ethz.ch/R-manual/R-devel/library/utils/html/write.table.html

#Exporting the results to your system.
write.table(Resulting_Matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")



#--------------------------------------------------
# STEP 4: Visualizations
#--------------------------------------------------

# Package require for DataFrame manuplulation:

if(!require("tidyr")) install.packages("tidyr")
if(!require("ggplot2")) install.packages("ggplot2")
if(!require("ggpubr")) install.packages("ggpubr")

#Loading the required Visualization libraries to the programm
library(tidyr)
library(ggplot2)
library(ggpubr)

# Creating new matrix for all values 
New_Matrix = Resulting_Matrix [,colnames(Resulting_Matrix) != 'EMPTY']

#________________________________________________________________________________
#Scatter-Plot for ANOVA-Test according to P-Value:
pValueGreatANOVA_2_1           <- New_Matrix %>% filter(anova_2_1_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessTANOVA_2_1            <- New_Matrix  %>% filter(anova_2_1_padj <= 0.05)   #filter matrix with p value <0.05

pValueGreatANOVA_3_1           <- New_Matrix %>% filter(anova_3_1_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessTANOVA_3_1            <- New_Matrix  %>% filter(anova_3_1_padj <= 0.05)   #filter matrix with p value <0.05

pValueGreatANOVA_3_2           <- New_Matrix %>% filter(anova_3_2_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessTANOVA_3_2            <- New_Matrix  %>% filter(anova_3_2_padj <= 0.05)   #filter matrix with p value <0.05


# Visualization for ANOVA A/C to P-adjustment values:

# Group 2_1
ggplot()+
  geom_point(aes(x=pValueGreatANOVA_2_1$average_group_1,y=pValueGreatANOVA_2_1$average_group_2,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessTANOVA_2_1$average_group_1,y=pVlaueLessTANOVA_2_1$average_group_2,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group2')+labs(color='P-adj.Values')+
  ggtitle('Comparison Group 1 and 2 - Anova-Test')

# Group 3_1
ggplot()+
  geom_point(aes(x=pValueGreatANOVA_3_1$average_group_1,y=pValueGreatANOVA_3_1$average_group_3,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessTANOVA_3_1$average_group_1,y=pVlaueLessTANOVA_3_1$average_group_3,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group3')+labs(color='P-adj.Values')+
  ggtitle('Comparison Group 1 and 3 - Anova-Test')

# Group 3_2
ggplot()+
  geom_point(aes(x=pValueGreatANOVA_3_2$average_group_2,y=pValueGreatANOVA_3_2$average_group_3,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessTANOVA_3_2$average_group_2,y=pVlaueLessTANOVA_3_2$average_group_3,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group2')+ylab('Average of Group3')+labs(color='P-adj.Values')+
  ggtitle('Comparison Group 2 and 3 - Anova-Test')


#Scatter-Plot for Kruskall Walles-Test according to P-Value:
pValueGreatKruskall_1_2           <- New_Matrix %>% filter(kruskall_1_2_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessKruskall_1_2            <- New_Matrix  %>% filter(kruskall_1_2_padj <= 0.05)   #filter matrix with p value <0.05

pValueGreatKruskall_1_3           <- New_Matrix %>% filter(kruskall_1_3_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessTKruskall_1_3            <- New_Matrix  %>% filter(kruskall_1_3_padj <= 0.05)   #filter matrix with p value <0.05

pValueGreatKruskall_2_3           <- New_Matrix %>% filter(kruskall_2_3_padj>=0.05)      #filter matrix with p value >0.05
pVlaueLessTKruskall_2_3            <- New_Matrix  %>% filter(kruskall_2_3_padj <= 0.05)   #filter matrix with p value <0.05

# Visualization for Kruskall Walles-Test A/C to P-adjustment values:

# Group 2_1
ggplot()+
  geom_point(aes(x=pValueGreatKruskall_1_2$average_group_1,y=pValueGreatKruskall_1_2$average_group_2,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessKruskall_1_2$average_group_1,y=pVlaueLessKruskall_1_2$average_group_2,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group2')+labs(color='P-adj.Values')+ 
  ggtitle("Comparison Group 2 and 1 - KW-Test ")

# Group 1_3
ggplot()+
  geom_point(aes(x=pValueGreatKruskall_1_3$average_group_1,y=pValueGreatKruskall_1_3$average_group_3,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessTKruskall_1_3$average_group_1,y=pVlaueLessTKruskall_1_3$average_group_3,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group3')+labs(color='P-adj.Values')+
  ggtitle('Comparison Group 1 and 3 - KW-Test')


# Group 2_3
ggplot()+
  geom_point(aes(x=pValueGreatKruskall_2_3$average_group_2,y=pValueGreatKruskall_2_3$average_group_3,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessTKruskall_2_3$average_group_2,y=pVlaueLessTKruskall_2_3$average_group_3,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group2')+ylab('Average of Group3')+labs(color='P-adj.Values')+
  ggtitle('Comparison Group 2 and 3 - KW-Test')


#--------------------------------------------------
# STEP 5: Finish
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)




