#-------------------------------------------------------------------------------------------------------------
#                                           T-TEST AND U-TEST COMPUTATIONS
#-------------------------------------------------------------------------------------------------------------


# Cleaning the workspace to start over

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

#-------------------------------------------------------------------------------------------------------------
# HEADER OF THE SOFTWARE OUTPUT
#-------------------------------------------------------------------------------------------------------------

sourceAuthor  <-  "Robert Heyer/META PRO STAT TEAM"
sourceDate    <-  "30.04.2020"
sourceVersion <-  "1.0.1"
testName      <-  'T-Test and Mann-Whitney U-Test'
# Inforamtion about the software:

print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)
print(paste("TEST",testName), quote = FALSE )


# Installing  Packages

# Package for package administration:
if(!require("miniCRAN")) install.packages("miniCRAN") 

# Package for a layout theme for the violone plots:
if(!require("dplyr")) install.packages("dplyr") 

# Add the associated libraries to the programm
library("miniCRAN")
library("dplyr")


# MAIN PROGRAM STARTS HERE 

# Declaration of parameters:
SEPARATOR = ";"  # Separator within the csv. -files



#------------------------------------------------
# STEP 0: Gets the matrix and Choose Groups
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose() 
matrix <- read.csv(fname, sep=SEPARATOR,row.names=1)



# Output path:
outputname = "Result_of_T&U_test.csv"

outputname = "/Users/mac/Documents/12CP Project/Result_of_T&U_test.csv"



# Define start and end rows of each group
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
# STEP 1: Normality Test
#------------------------------------------------

#Shapiro test values to check normality:

for (i in 1:ncol(matrix)) { 
  newMatrix[i,ncol(matrix) + 14]   <- shapiro.test(as.numeric(matrix[,i]))$statistic # w-value
  newMatrix[i,ncol(matrix) + 15]   <- shapiro.test(as.numeric(matrix[,i]))$p.value   #p-value
  
  
}

#--------------------------------------------------
# STEP 2: Calculates U-Test and T-Test
#--------------------------------------------------


# Calculate the T-TEST and U-TEST for all variables: 
for (i in 1:nrow(matrix)) {
  #Average of Groups: 
  
  newMatrix[i,ncol(matrix) + 10]    <- mean(as.numeric( matrix[i, start_Col_Group_X : end_Col_Group_X] ))
  newMatrix[i,ncol(matrix) + 11]    <- mean(as.numeric( matrix[i, start_Col_Group_Y : end_Col_Group_Y] ))
  newMatrix[i,ncol(matrix) + 12]    <- mean( as.numeric( matrix[i, start_Col_Group_X : end_Col_Group_X] ))/
                                       mean(as.numeric( matrix[i, start_Col_Group_Y : end_Col_Group_Y] ))
  
  
  # Calculation of P-Value for TTest and U-Test
  
  newMatrix[i,ncol(matrix)+ 2]      <- t.test(as.numeric(matrix[i,start_Col_Group_X:end_Col_Group_X]),
                                              as.numeric(matrix[i,start_Col_Group_Y:end_Col_Group_Y]),
                                              alternative = c("two.sided"), paired = FALSE, 
                                              var.equal = FALSE,conf.level = 0.95)$p.value
  
  
  
  newMatrix[i,ncol(matrix)+ 6]      <- wilcox.test(as.numeric(matrix[i,start_Col_Group_X:end_Col_Group_X]),
                                                   as.numeric(matrix[i,start_Col_Group_Y:end_Col_Group_Y]),
                                                   alternative = c("two.sided"), paired = FALSE, 
                                                   var.equal = FALSE,conf.level = 0.95)$p.value
    
  newMatrix[i,ncol(matrix) + 13]    <-  log2(newMatrix[i,ncol(matrix) + 12])
}


# Bonferroni and Benjamin-Hochberger Corrections for T-Test:

#Save P-Value of T-Test in 'p':
p <- newMatrix[1:nrow(matrix),ncol(matrix)+ 2] 

#apply Bonferroni correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 3]   <- p.adjust(p,method = "bonferroni", n = length(p))   
#apply Benjamin-Hochberger correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 4]   <-  p.adjust(p, method = "BH", n = length(p))




# Bonferroni and Benjamin-Hochberger Corrections for U-Test:

#Save P-Value of U-Test in 'p':
p <- newMatrix[1:nrow(matrix),ncol(matrix)+ 6]

#apply Bonferroni correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 7]   <- p.adjust(p,method = "bonferroni", n = length(p))   
#apply Benjamin-Hochberger correction:
newMatrix[1:nrow(matrix),ncol(matrix)+ 8]   <-  p.adjust(p, method = "BH", n = length(p))



#--------------------------------------------------
#  STEP 3: Visualization for Tests
#--------------------------------------------------


# Packages required for DataFrame manuplulation:

if(!require("tidyr")) install.packages("tidyr")
if(!require("ggplot2")) install.packages("ggplot2")
if(!require("ggpubr")) install.packages("ggpubr")

#Load Libraries/packages:
library(tidyr)
library(ggplot2)
library(ggpubr)

#--------------------------------------------------
# Visualization by Groups
#--------------------------------------------------

# PValues comaprison w.r.t Average Ratio:

# Combining Two attributes for visualization


#Box_plot for camparison of TTest and Mann-Whitney U test:

ggboxplot(data= gather(data=newMatrix,
                              key = 'TestNames',
                              value = 'P_Value',
                              pValue_TTest,pValue_UTest),
           x = "TestNames", y = "P_Value", 
          color = "TestNames", palette = c("#00AFBB", "#E7B800"),
          ylab = "P-Values", xlab = "Test-Names")

#Scatter_plot for comaprison of TTest and Mann-Whitney U test:

ggplot(data=newMatrix)+geom_point(aes(x=Log2_average_group_1div2,y=pValue_TTest,color='T-Test'))+
geom_point(aes(x=Log2_average_group_1div2,y=pValue_UTest,color='U-Test'))+
  xlab('Log2(Group1avg/Group2avg)')+ylab('P-Values')+labs(color='Test-Type')+
  ggtitle("P-Value comparison of T-Test & U-Test") + theme(plot.title = element_text(hjust = 0.5))



#--------------------------------------------------
# Visualization for Individual test
#--------------------------------------------------


#Scatter-Plot for T-Test according to P-Value:

pValueGreatTTest            <- newMatrix %>% filter(pValue_TTest>=0.05)      #filter matrix with p value >0.05
pVlaueLessTTest             <- newMatrix  %>% filter(pValue_TTest <= 0.05)   #filter matrix with p value <0.05

# Visualization for T-Test:
ggplot()+geom_point(aes(x=pValueGreatTTest$average_group_1,y=pValueGreatTTest$average_group_2,color= '>0.05'))+
geom_point(aes(x=pVlaueLessTTest$average_group_1,y=pVlaueLessTTest$average_group_2,color= '<0.05'))+
geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group2')+labs(color='P-values')+
ggtitle("Group abandance w.r.t P-Value(T-Test)") + theme(plot.title = element_text(hjust = 0.5))



#Scatter-Plot for T-Test according to P-Value:

pValueGreatUTest            <- newMatrix %>% filter(pValue_UTest>=0.05)        #filter matrix with p value >0.05
pVlaueLessUTest             <- newMatrix  %>% filter(pValue_UTest <= 0.05)     #filter matrix with p value <0.05

# Visualization for U-Test:
ggplot()+geom_point(aes(x=pValueGreatUTest$average_group_1,y=pValueGreatUTest$average_group_2,color= '>0.05'))+
geom_point(aes(x=pVlaueLessUTest$average_group_1,y=pVlaueLessUTest$average_group_2,color= '<0.05'))+
geom_abline(aes(intercept=0,slope=1),color='blue')+xlab('Average of Group1')+ylab('Average of Group2')+labs(color='P-values')+
ggtitle("Group abandance  w.r.t  P-Value(U-Test)") + theme(plot.title = element_text(hjust = 0.5))


#--------------------------------------------------
# STEP 4 : Export the results
#--------------------------------------------------


write.table(newMatrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")


#--------------------------------------------------
# STEP 5: Finish
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)


 
       