
#-------------------------------------------------------------------------------------------------------------
                                "Kruskall Wallis TEST COMPUTATION"
#-------------------------------------------------------------------------------------------------------------



# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
                                          "HEADER OF THE SOFTWARE OUTPUT"
#------------------------------------------------

sourceAuthor  <-  "META PRO STAT TEAM"
sourceDate    <-  "12.05.2020"
sourceVersion <-  "1.2.1"

# Information about the software
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)

# Installing  Packages
# Package for package administration
if(!require("miniCRAN")) install.packages("miniCRAN") #Contains some packages for general usage
if(!require("dplyr")) install.packages("dplyr")       #Package for Data-Wrangling
if(!require("FSA")) install.packages("FSA")           #Package for DUNN Posthoc test for Kruskall Wallis
if(!require("tidyr")) install.packages("tidyr")       #Package for Data-Wrangling
if(!require("ggplot2")) install.packages("ggplot2")   #Package for Data-Visualization
if(!require("ggpubr")) install.packages("ggpubr")     #Package for Data-Visualization

# Loading the required libraries to the programm
library("miniCRAN")
library("dplyr")
library("FSA")
library("tidyr")
library("ggplot2")
library("ggpubr")





#------------------------------------------------
                                "STEP 0: Gets the matrix and Choose Groups"
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose() #Hint: MetaProtein.csv

# Declaration of parameters 
SEPARATOR = ";"                        # Separator within the csv.-files

matrix <- read.csv(fname, sep=SEPARATOR, row.names=1)  # sep=SEPARATOR (use this if you are using a seperator)

# Output path
outputname = "RESULTS_KW.csv"       #File name for results output



#List for Start of the groups:
Group_start <- list()

#List for End of the groups:
Group_end <- list()


# Allows you to ask for Group ranges
for (i in 1:3){
  Group_start[i] <- readline(prompt = "Enter values for Start of group: ")
  Group_end[i] <- readline(prompt = "Enter values for End of group: ")
}


"Manually Enter the range of Groups"

# Final ranges for new groups 
index_for_new_groups = as.numeric(Group_end) - as.numeric(Group_start)+1
print(index_for_new_groups)

#--------------------------------------------------
                              "STEP 1: Calculates Kruskall Walles Test"
#--------------------------------------------------


# Create a vector representing the assignment of the samples of 3 groups as "1", "2" and "3" 
groups <- rep(1:3,index_for_new_groups) # Making space for the groups, 

groups <- factor(groups) # Making in factors so the system understand the groups, so that all 1s
#can be identified as single group of 1 and 2s as single group of 2 and so on
print(groups)

# Create new output vectors for the results
EMPTY                   <-  (rep("",nrow(matrix))) # + 1
average                 <-  (rep(0, nrow(matrix))) # + 2
average_group_1         <-  (rep(0, nrow(matrix))) # + 3
average_group_2         <-  (rep(0, nrow(matrix))) # + 4
average_group_3         <-  (rep(0, nrow(matrix))) # + 5



result_kruskal_wallis   <-  (rep(0, nrow(matrix))) # + 7
kruskall_1_2_padj       <-  (rep(0, nrow(matrix))) # + 8
kruskall_1_3_padj       <-  (rep(0, nrow(matrix))) # + 9
kruskall_2_3_padj       <-  (rep(0, nrow(matrix))) # + 10

# Combined it to the output matrix
Resulting_Matrix <- cbind( matrix,
                           EMPTY, 
                           average,
                           average_group_1,
                           average_group_2,
                           average_group_3,
                           EMPTY,
                           result_kruskal_wallis,
                           kruskall_1_2_padj,
                           kruskall_1_3_padj,
                           kruskall_2_3_padj)

# Calculate the kruskall walles for all variables
for (i in 1:nrow(matrix)) {
  # Calculates the total and the group averages
  Resulting_Matrix[i,ncol(matrix) + 2] <- mean( as.numeric( matrix[i, 1 : ncol(matrix)] ))
  Resulting_Matrix[i,ncol(matrix) + 3] <- mean( as.numeric( matrix[i, Group_start[[1]] : Group_end[[1]]] ))
  Resulting_Matrix[i,ncol(matrix) + 4] <- mean( as.numeric( matrix[i, Group_start[[2]] : Group_end[[2]]] ))
  Resulting_Matrix[i,ncol(matrix) + 5] <- mean( as.numeric( matrix[i, Group_start[[3]] : Group_end[[3]]] ))
  
  
  
  "Calculate Kruskall Walles"
  
  #Kruskal-Wallis test by rank is a non-parametric alternative to one-way ANOVA test, 
  #which extends the two-samples Man Whitney - Wilcoxon test in the situation 
  #where there are more than two groups.  
  
  
  kruskal <- kruskal.test(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix)
  Resulting_Matrix[i,ncol(matrix) + 7] <- kruskal["p.value"]
  # Post-hoc test: DUNN Test
  dunn <- dunnTest(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix, method ="none")
  dunn.res <- as.data.frame(dunn[2])
  Resulting_Matrix[i,ncol(matrix) + 8] =dunn.res[1,4]
  Resulting_Matrix[i,ncol(matrix) + 9] =dunn.res[2,4]
  Resulting_Matrix[i,ncol(matrix) + 10] =dunn.res[3,4]
}


#--------------------------------------------------
                                    "STEP 2: Visualization for Tests"
#--------------------------------------------------

# Creating new matrix for all values 
New_Matrix = Resulting_Matrix [,colnames(Resulting_Matrix) != 'EMPTY']



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
"STEP: 2. Export the results"
#--------------------------------------------------

#Exporting the results to your system.
write.table(Resulting_Matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")





#--------------------------------------------------
"STEP 3: Finish"
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)




