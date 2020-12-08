#-------------------------------------------------------------------------------------------------------------
"U-TEST COMPUTATIONS"
#-------------------------------------------------------------------------------------------------------------


# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#------------------------------------------------
"HEADER OF THE SOFTWARE OUTPUT"
#------------------------------------------------

# Information about the software:
sourceAuthor  <-  "META PRO STAT TEAM"
sourceDate    <-  "30.04.2020"
sourceVersion <-  "1.0.5"
testName      <-  'Mann-Whitney U-Test'




print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)
print(paste("TEST",testName), quote = FALSE )


# Installing  Packages

# Package for package administration:
if(!require("tidyr")) install.packages("tidyr")             #package for Data-wrangling
if(!require("ggplot2")) install.packages("ggplot2")         #package for Data-visualization
if(!require("ggpubr")) install.packages("ggpubr")           #package for Data-visualization
if(!require("dplyr")) install.packages("dplyr")             #package for Data-wrangling


# Load packages:

library("dplyr")
library(tidyr)
library(ggplot2)
library(ggpubr)




#------------------------------------------------
"STEP 0: Gets the matrix and Choose Groups"
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()     #choose all metaprotein.csv

# Declaration of parameters:
SEPARATOR = ";"  # Separator within the csv. -files


matrix <- read.csv(fname, sep=SEPARATOR, row.names = 1) 

# Output file name:
outputname = "Result_of_U_test.csv"


# Define start and end rows of each group:
start_Col_Group_X  <- 1 # Start Group 1
end_Col_Group_X    <- 33 # End Group 1
start_Col_Group_Y  <- 34 # Start Group 2
end_Col_Group_Y    <- 66 # End Group 2


# Create new output vectors for the results:
EMPTY_First                                      <-  (rep("",nrow(matrix))) # + 1
pValue_TTest                                     <-  (rep(0, nrow(matrix))) # + 2
BonferoniCorrection_TTest                        <-  (rep(0, nrow(matrix))) # + 3
BenjaminHochbergerCorrection_TTest               <-  (rep(0, nrow(matrix))) # + 4
EMPTY_Second                                     <-  (rep('', nrow(matrix)))# + 5
pValue_UTest                                     <-  (rep(0, nrow(matrix))) # + 6
BonferoniCorrection_UTest                        <-  (rep(0, nrow(matrix))) # + 7
BenjaminHochbergerCorrection_UTest               <-  (rep(0, nrow(matrix))) # + 8
EMPTY_Third                                      <-  (rep('', nrow(matrix)))# + 9
average_group_1                                  <-  (rep(0, nrow(matrix))) # + 10
average_group_2                                  <-  (rep(0, nrow(matrix))) # + 11
average_group_1div2                              <-  (rep(0, nrow(matrix))) # + 12
Log2_average_group_1div2                         <-  (rep(0, nrow(matrix))) # + 13
shapiro_Wvalue                                   <-  (rep(0, nrow(matrix))) # + 14
shapiro_Pvalue                                   <-  (rep(0, nrow(matrix))) # + 15


# Combined it to the output matrix:
newMatrix <-  cbind(  matrix, EMPTY_First,pValue_TTest, BonferoniCorrection_TTest, BenjaminHochbergerCorrection_TTest,
                      
                      EMPTY_Second, pValue_UTest, BonferoniCorrection_UTest, BenjaminHochbergerCorrection_UTest,
                      
                      EMPTY_Third, average_group_1, average_group_2, average_group_1div2, Log2_average_group_1div2,
                      
                      shapiro_Wvalue,shapiro_Pvalue)

#------------------------------------------------
"STEP 1: Normality Test"
#------------------------------------------------


#Shapiro test values to check normality:

for (i in 1:ncol(matrix)) { 
  newMatrix[i,ncol(matrix) + 14]   <- shapiro.test(as.numeric(matrix[,i]))$statistic # w-value
  newMatrix[i,ncol(matrix) + 15]   <- shapiro.test(as.numeric(matrix[,i]))$p.value   #p-value
  
  
}

#--------------------------------------------------
"STEP 2: Calculation for U-Test"
#--------------------------------------------------


# Calculate the T-TEST and U-TEST for all variables: 
for (i in 1:nrow(matrix)) {
  #Average of Groups: 
  
  newMatrix[i,ncol(matrix) + 10]    <- mean(as.numeric( matrix[i, start_Col_Group_X : end_Col_Group_X] ))
  newMatrix[i,ncol(matrix) + 11]    <- mean(as.numeric( matrix[i, start_Col_Group_Y : end_Col_Group_Y] ))
  newMatrix[i,ncol(matrix) + 12]    <- mean( as.numeric( matrix[i, start_Col_Group_X : end_Col_Group_X] ))/
    mean(as.numeric( matrix[i, start_Col_Group_Y : end_Col_Group_Y] ))
  
  
  # Calculation of P-Value for U-Test
  
  newMatrix[i,ncol(matrix)+ 6]      <- wilcox.test(as.numeric(matrix[i,start_Col_Group_X:end_Col_Group_X]),
                                                   as.numeric(matrix[i,start_Col_Group_Y:end_Col_Group_Y]),
                                                   alternative = c("two.sided"), paired = FALSE, 
                                                   var.equal = FALSE,conf.level = 0.95)$p.value
  
  newMatrix[i,ncol(matrix) + 13]    <-  log2(newMatrix[i,ncol(matrix) + 12])
}



# Bonferroni and Benjamin-Hochberger Corrections for U-Test:

#Save P-Value of U-Test in 'p':
p <- newMatrix[1:nrow(matrix),ncol(matrix)+ 6]

#apply Bonferroni correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 7]   <- p.adjust(p,method = "bonferroni", n = length(p))   
#apply Benjamin-Hochberger correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 8]   <-  p.adjust(p, method = "BH", n = length(p))



#--------------------------------------------------
"STEP 3: Visualization for Tests"
#--------------------------------------------------




"Visualization for Individual test"



#Scatter-Plot for U-Test according to P-Value:

pValueGreatUTest            <- newMatrix %>% filter(pValue_UTest>=0.05)        #filter matrix with p value >0.05
pVlaueLessUTest             <- newMatrix  %>% filter(pValue_UTest <= 0.05)     #filter matrix with p value <0.05

# Visualization for U-Test:
ggplot()+geom_point(aes(x=pValueGreatUTest$average_group_1,y=pValueGreatUTest$average_group_2,color= '>0.05'))+
  geom_point(aes(x=pVlaueLessUTest$average_group_1,y=pVlaueLessUTest$average_group_2,color= '<0.05'))+
  geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group2')+labs(color='P-values')+
  ggtitle("Group abandance  w.r.t  P-Value(U-Test)") + theme(plot.title = element_text(hjust = 0.5))


#--------------------------------------------------
"STEP 4 : Export the results"
#--------------------------------------------------


write.table(newMatrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")


#--------------------------------------------------
"STEP 5: PP-plot"
#--------------------------------------------------
# Setting up the plotting window with suitable margins
par(mar=c(4,4,2,1))

# Plotting the Probability plot
ppPlot(p, "normal")  #'p' here contains our p-values obtained from the test


#--------------------------------------------------
"STEP 6: Finish"
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)

