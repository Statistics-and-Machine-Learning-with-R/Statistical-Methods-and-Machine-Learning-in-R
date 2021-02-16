
"
NOTE: First Column is treated as 1 in the Selection of Data:

1- Please make sure your csv file contains only numeric variables with headers for the code and one 
   first column with Name of the Elements (for sample check the dataset provided with the 
   name 'practice file').
                     Column(Variable) 1      Column(Variable) 2     . . . .    Column(Variable) n
      
      Row(Instance) 1      (Value)                  (Value)           . . . .         (Value)
      
      Row(Instance) 2      (Value)                  (Value)           . . . .         (Value)
      
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      .                       .                        .                                 .
      
      Row(Instance) n      (Value)                  (Value)           . . . .         (Value)

2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
   which will be asked on running the code in the CONSOLE screen. In this case select:
   
   a- dataset to work on (after screen pops out)
   b- Total Number of groups to make.
   c- Ranges of all groups (Group-1, Group-2 ... Group n)
   
3- After providing all the parameters, the code will compute following:
   * p-Value (anova), difference mean for all groups combinations
   * p-Value (kruskal wallis) for all groups combinations                     
   * Overall Average             
   * Averages of all groups
   
4- After all the executions the final resulting file(in CSV format) will be saved on your current
   working directory. In the resulting file you can find all the calulated values done through the 
   analysis.
"


#------------------------------------------------
"REQUIRED PACKAGES FOR Annova & Kruskall Wallis TEST COMPUTATIONS"
#------------------------------------------------

# Cleaning the workspace
cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

# Installing  Packages
# Package for package administration
if(!require("miniCRAN")) install.packages("miniCRAN") #Contains some packages for general usage
if(!require("dplyr")) install.packages("dplyr")       #Package for Data-Wrangling
if(!require("FSA")) install.packages("FSA")           #Package for DUNN Posthoc test for Kruskall Wallis
if(!require("tidyr")) install.packages("tidyr")       #Package for Data-Wrangling
if(!require("ggplot2")) install.packages("ggplot2")   #Package for Data-Visualization
if(!require("ggpubr")) install.packages("ggpubr")     #Package for Data-Visualization

# Loading the required libraries to the program
library("miniCRAN")
library("dplyr")
library("FSA")
library("tidyr")
library("ggplot2")
library("ggpubr")

# Cleaning the workspace to start over
cat("\f")       # Clear old outputs
#------------------------------------------------
"SELECTION OF DATSET AND PARAMETERS"
#------------------------------------------------
# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose() #Hint: MetaProtein.csv

#Choose the Separator for file
ask_sep <- as.character(readline(prompt = " ENTER the SEPARATOR for file(',' or ';') : "))

#file wtih mumerical data only
matrix <- read.csv(fname, sep=ask_sep, row.names=1)  

# Output path
outputname = "RESULTS_ANOVA_and_KW.csv"      #File name for results output

#List for Start of the groups:sw
Group_start <- list()

#List for End of the groups:
Group_end <- list()


#input number of groups
NG <- as.numeric(readline(prompt = "Enter Total no of group: ")) 



# Allows you to ask for Group ranges wrt Number of Groups (NG)
for (i in 1:NG){
  Group_start[i] <- readline(prompt = "Enter values for Start of group: ")
  Group_end[i] <- readline(prompt = "Enter values for End of group: ")
}

#------------------------------------------------
"CALCULATIONS FOR Anova and Kruskall Walles Test"
#------------------------------------------------

# Final ranges for new groups 
index_for_new_groups = as.numeric(Group_end) - as.numeric(Group_start)+1

# Create a vector representing the assignment of the samples of 3 groups as "1", "2" and "3" 
groups <- rep(1:NG,index_for_new_groups) # Making space for the groups

groups <- factor(groups) # Making in factors so the system understand the groups, so that all 1s
#can be identified as single group of 1 and 2s as single group of 2 and so on

# Create new output vectors for the results
EMPTY                   <-  (rep("",nrow(matrix))) # + 1
average                 <-  (rep(0, nrow(matrix))) # + 2

#Dynamic combination Average of groups
for (i in 1:NG) {
  assign(paste0('average_group_', i), (rep(0, nrow(matrix)))) # + (3 onward upto number of groups i.e 4 or 5 
}


result_anova            <-  (rep(0, nrow(matrix))) # + 3
result_kruskal_wallis   <-  (rep(0, nrow(matrix))) # + 4

#loop decrements for group combinations
#logic for internal combinations
anv_mean<-("") #to capture variable names of anova mean
anv_padj<-("") #to capture variable names of anova P-values
krus_padj<- ("")  #to capture variable names of Kruskal Wallis P-values
Grp_Comb <- 0 #group comnbinations
for (i in NG:2)
{
  newi = i-1
  for (j in newi:1) 
  {
    assign(paste0('anova_',i,'_',j,'_diff_mean'), (rep(0, nrow(matrix)))) #for  anova_i_j_diff_mean 
    anv_mean <- append(anv_mean, paste0('anova_',i,'_',j,'_diff_mean'))
    assign(paste0('anova_',i,'_',j,'_padj'), (rep(0, nrow(matrix))))      #for #anova_i_j_padj
    anv_padj <- append(anv_padj, paste0('anova_',i,'_',j,'_padj'))
    assign(paste0('kruskall_',i,'_',j,'_padj'), (rep(0, nrow(matrix))))   #for kruskall_i_j_padj
    krus_padj <- append(krus_padj, paste0('kruskall_',i,'_',j,'_padj'))
    Grp_Comb <- Grp_Comb +1
  }
}


#cbind dynamic variables
avg_grp<-do.call(cbind, mget(paste0("average_group_",1:NG)))   #average groups
anv_mean1<-do.call(cbind, mget(paste0(anv_mean[2:length(anv_mean)])))   #average groups anova_mean combination
anv_padj1<-do.call(cbind, mget(paste0(anv_padj[2:length(anv_padj)])))   #average groups anova_padj combination
krus_padj1<-do.call(cbind, mget(paste0(krus_padj[2:length(krus_padj)])))  #average groups Kruskal_padj combination

# Combined it to the output matrix  
Resulting_Matrix <- cbind( matrix, #input matrix          
                           EMPTY,   #                     +1 = 1
                           average, #Average overall      +1 = 2
                           result_anova, #                +1 = 3
                           result_kruskal_wallis, #Kruskal wallis Result    +1 = 4
                           avg_grp, #Average all groups   +5 +Dynamic  
                           # EMPTY, #                      Dynamic +1
                           anv_mean1, #Anova Mean         Dynamic  
                           anv_padj1, #Anova Padj         Dynamic
                           # EMPTY, #                       Dynamic +1
                           krus_padj1 #Kruskal Wallis Padj     Dynamic
                           
)

#"Anova-Test"
for (i in 1:nrow(matrix)) {
  # Calculates the total and the group averages
  Resulting_Matrix[i,ncol(matrix) + 2] <- mean( as.numeric( matrix[i, 1 : ncol(matrix)] ))
  
  for (j in 1:NG)  #Average of each group
  {   
    Resulting_Matrix[i,ncol(matrix) + (4 +j)  ] <- mean( as.numeric( matrix[i, Group_start[[j]] : Group_end[[j]]] )) #for single gro
    
  }
  
  
  "Calculates ANOVA "
  
  #The one-way analysis of variance (ANOVA), also known as one-factor ANOVA, 
  #is an extension of independent two-samples t-test for comparing means in a situation 
  #where there are more than two groups. In one-way ANOVA, the data is organized into several groups
  #base on one single grouping variable (also called factor variable).
  
  
  anova <- aov(as.numeric(matrix[i,1:ncol(matrix)])  ~  groups  , data = matrix) 
  Resulting_Matrix[i,ncol(matrix) + 3] <- unlist(summary(anova))["Pr(>F)1"]  # Annova Result
  # Post-hoc test: tukey test to check differences between the groups
  tukey <- TukeyHSD(aov(as.numeric(matrix[i,1:ncol(matrix)])  ~  groups  , data = matrix))
  tukey
  tukey <- as.data.frame(tukey[1])
  
  
  #loops and logic for comparisons between groups
  #Diff Mean of annova from tuckey
  for (k in 1:Grp_Comb) {
    Resulting_Matrix[i,ncol(matrix) + ((4 +NG)  + k ) ] =tukey[k,1] #In Tuckey, [x,y]=[1,1]=[group =1st Index, Diff_mean = 1st Index]
  }
  
  
  #Padj of annova from tuckey
  for (l in 1:Grp_Comb) {
    Resulting_Matrix[i,ncol(matrix)+ (((4+NG)+ Grp_Comb) + l)] =tukey[l,4] #In Tuckey, [x,y]=[1,4]=[group =1st Index, Padj = 4th Index]
  }
  
  
  "Calculate Kruskall Walles"
  
  #Kruskal-Wallis test by rank is a non-parametric alternative to one-way ANOVA test, 
  #which extends the two-samples Man Whitney - Wilcoxon test in the situation 
  #where there are more than two groups.  
  
  
  kruskal <- kruskal.test(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix)
  Resulting_Matrix[i,ncol(matrix) + 4] <- kruskal["p.value"]  #KW Result
  # Post-hoc test: DUNN Test
  dunn <- dunnTest(as.numeric(matrix[i,1:ncol(matrix)]) ~ groups, data = matrix, method ="none")
  dunn.res <- as.data.frame(dunn[2])
  #Padj of Kruskal Waliis from from Dunn Test
  
  for (m in 1:Grp_Comb) {
    Resulting_Matrix[i,ncol(matrix) + ((((4+NG)+ Grp_Comb)+Grp_Comb) + m) ] =dunn.res[m,4] #In Dunn, [x,y]=[1,4]=[group =1st Index, Padj = 4th Index]
  }
  
}

cat("\f")       # Clear old outputs
#--------------------------------------------------
"VISUALIZATIONS FOR Anova Test and Kruskal Wallis Test"
#--------------------------------------------------

# Creating new matrix for all values 
New_Matrix = Resulting_Matrix [,colnames(Resulting_Matrix) != 'EMPTY']

#for all Anova Plots

for (i in 2:length(anv_padj)) {
  
  #Filter P-values
  arrayless <- New_Matrix[New_Matrix[, anv_padj[i]] <=0.05,]
  arraygreat <- New_Matrix[New_Matrix[, anv_padj[i]] >0.05,]
  label1 <- print(substr(anv_padj[i],7,7))
  label2 <- print(substr(anv_padj[i],9,9))
  label3 <- paste(label1, '&', label2)
  
  #Plotting Graphs
  print(ggplot()+
          geom_point(aes(x=arraygreat[[paste0("average_group_",substr(anv_padj[i],7,7))]],y=arraygreat[[paste0("average_group_",substr(anv_padj[i],9,9))]],color= '>0.05'))+
          geom_point(aes(x=arrayless[[paste0("average_group_",substr(anv_padj[i],7,7))]],y=arrayless[[paste0("average_group_",substr(anv_padj[i],9,9))]],color= '<0.05'))+
          geom_abline(aes(intercept=0,slope=1),color='blue')+xlab(paste('Average of Group',label1))+ylab(paste('Average of Group',label2))+labs(color='P-adj.Values')+
          ggtitle('Comparison Anova-Test, GROUP',label3))
  
}


#for all KW Plots
for (i in 2:length(krus_padj)) {
  
  #Filter P-values
  arrayless <- New_Matrix[New_Matrix[, krus_padj[i]] <=0.05, ]
  arraygreat <- New_Matrix[New_Matrix[, krus_padj[i]] >0.05, ]
  label1 <- print(substr(krus_padj[i],10,10))
  label2 <- print(substr(krus_padj[i],12,12))
  label3 <- paste(label1, '&', label2)
  
  
  #Plotting Graphs
  print(ggplot()+
          geom_point(aes(x=arraygreat[[paste0("average_group_",substr(krus_padj[i],10,10))]],y=arraygreat[[paste0("average_group_",substr(krus_padj[i],12,12))]],color= '>0.05'))+
          geom_point(aes(x=arrayless[[paste0("average_group_",substr(krus_padj[i],10,10))]],y=arrayless[[paste0("average_group_",substr(krus_padj[i],12,12))]],color= '<0.05'))+
          geom_abline(aes(intercept=0,slope=1),color='blue')+xlab(paste('Average of Group',label1))+ylab(paste('Average of Group',label2))+labs(color='P-adj.Values')+
          ggtitle("Comparison Kruskal Wallis GROUP", label3))
}


cat("\f")       # Clear old outputs
warning=FALSE
#--------------------------------------------------
"EXPORT THE RESULTS INTO CSV"
#--------------------------------------------------

#Exporting the results to your system.
write.table(Resulting_Matrix, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = NA, qmethod = c("escape", "double"),
            fileEncoding = "")


#analysis completed:
cat("\f")       # Clear old outputs
print(paste("FINISHED"), quote = FALSE)
