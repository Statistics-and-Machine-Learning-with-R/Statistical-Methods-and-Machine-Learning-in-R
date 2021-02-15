  "
  1- Please know that you will need CSV files for this script
     a- Input_file_Anosim&Permanova.CSV
     b- Groupings_file_Anosim&Permanova.CSV
     
  2- To run the code, select the whole code and run as source (top right in this window) & enter parameters
  which will be asked on running the code in the CONSOLE screen. In this case select:
    
    a- Select first Input_file_Anosim&Permanova.CSV as your Input file when your are asked to select Input file
    b- Then, select Groupings_file_Anosim&Permanova.CSV, when you are asked to select the Groupings file
    c- Select whether you want to perform anosim or Permanova 
    d- Select number of Permutations you want
    
  3- After providing all the parameters, the code will compute following:
    
    * P and R values of Anosim      (if you chosed Anosim) OR
    * P and R values of Permanova   (if you chosed Permanova)
    * Save the results in the working directory
  "
  
  #------------------------------------------------
  "REQUIRED PACKAGES FOR ANOSIM And PERMANOVA"
  #------------------------------------------------
  
  #Cleaning the workspace to start over
  cat("\f")       # Clear old outputs
  rm(list=ls())   # Clear all variables
  
  #Installing  Packages
  if(!require("miniCRAN")) install.packages("miniCRAN")     # Package for package administration
  if(!require("factoextra")) install.packages("factoextra") # Package for multivariate data analysis
  if(!require("vegan")) install.packages("vegan")           # Package to check multivariate normal distribution

  #Add the associated libraries to the programm
  library("miniCRAN")
  library("ggpubr")
  library("vegan")

  cat("\f")       # Clear old outputs
  
  #------------------------------------------------
  "SELECTION OF DATASETS AND PARAMETERS"
  #------------------------------------------------
  
  
  print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows.
              Here we choose our Input file: Input_file_Anosim&Permanova.csv"), quote = FALSE)
  fname <- file.choose()
  
  #Choose the Separator for file
  ask_sep <- as.character(readline(prompt = " ENTER the SEPARATOR for file(',' or ';') : "))
  
  matrix <- read.csv(fname, sep=ask_sep, row.names=1)  
  
  #Extract continuous variables:
  start_row   <- as.integer(readline(prompt = "Enter value for START of range of numerical values in rows: "))
  cat("\f")     #Clear old outputs
  start_col   <- as.integer(readline(prompt = "Enter value for START of range of numerical values in columns: "))
  
  values <- matrix[start_row:nrow(matrix),start_col:ncol(matrix)]
  NORMDATA <- as.matrix(values)
  
  #Now, Selecting the grouping file.
  print(paste("Please select Grouping CSV", "Care about correct format."), quote = FALSE)
  fname1 <- file.choose()    # select 'Groupings_file_Anosim&Permanova'
  groups <- as.matrix(read.csv(fname1, sep=ask_sep,row.names=1))
  
  #------------------------------------------------
  "Calculation for Anosim and Permanova"
  #------------------------------------------------
  
  #Select ANOSIM or PERMANOVA Test:
  cat("\f")       # Clear old outputs
  groupSimMethod <- readline(prompt = "Write 'a' for Anosim or 'p' for Permanova: ")
    if(groupSimMethod== "a"){
      cat("\f")       # Clear old outputs
      #Select Choice of distance metric for Anosim
      ask_dist <- readline(prompt = "Write your Choice of distance metric between manhattan,euclidean,bray,jaccard:")
      
    }
  
  #Select the number of Permutations you want. Permutations are for shuffling the data in groups
  perm <- as.numeric(readline(prompt = "Write the number of Permutations you want:"))
  
    #Get the data matrix
    groupMatrix <- NORMDATA
    
    #Get non-redundant list of subgroups
    uniqueGroups <- unique(t(groups))
    #Creates the output matrix for R and p-values
    groupOutputMatrixR <- matrix("empty", nrow=nrow(uniqueGroups), ncol= nrow(uniqueGroups))
    groupOutputMatrixp <- matrix("empty", nrow=nrow(uniqueGroups), ncol= nrow(uniqueGroups))
    #Set the column heades for the R and p-value matrix
    rownames(groupOutputMatrixR)<- uniqueGroups[1:nrow(uniqueGroups),1]
    colnames(groupOutputMatrixR) <- uniqueGroups[1:nrow(uniqueGroups),1]
    rownames(groupOutputMatrixp)<- uniqueGroups[1:nrow(uniqueGroups),1]
    colnames(groupOutputMatrixp) <- uniqueGroups[1:nrow(uniqueGroups),1]
    
    #Iterate over all combinations of groups
    for (i in 1:nrow(uniqueGroups)){
      for (j in 1:nrow(uniqueGroups)){
        
        #Create submatrix
        #Empty subgroupmatrix
        subgroupMatrix = matrix(nrow =nrow(groupMatrix), ncol = 0)
        #Set the rownames
        rownames(subgroupMatrix) <- rownames(groupMatrix)
        #Empty classification matrix
        classifications = matrix(nrow = 1, ncol = 0)
        rownames(classifications) <- "CLASSIFICATIONS"
        #For loop to fill subgroupmatrix and classification matrix
        for (samples in 1:ncol(groupMatrix)){
          if ((uniqueGroups[i,1] == groups[1,samples]) || (uniqueGroups[j,1] == groups[1,samples])) {
            #Get the information for the subgroupmatrix and the column name
            subgroupMatrix <- cbind(subgroupMatrix, groupMatrix[0:nrow(groupMatrix),samples])
            colnames(subgroupMatrix)[ncol(subgroupMatrix)] <-colnames(groupMatrix)[samples]
            #Get the classifications and the column names
            classifications <-cbind(classifications,t(groups[1,samples]))
            colnames(classifications)[ncol(classifications)] <-colnames(groupMatrix)[samples]
          }
        }
        
        #A P value less than 0.05 is generally considered to be statistically significant, 
        #An R value close to “1.0” means dissimilarity between groups 
        #while an R value close to “0” suggests an even distribution of high and low ranks within and between groups
         if(uniqueGroups[i,1] == uniqueGroups[j,1]){
          #Get R value
          groupOutputMatrixR[i,j] <-1
          
          #Get p-value
          groupOutputMatrixp[i,j] <-0
          
        }else{
          #Calculate Anosim or Permanova
          if (groupSimMethod =="a") {
            #Perform Anosim
            res <- anosim(t(subgroupMatrix), classifications, permutations = perm, ask_dist, strata = NULL,
                          parallel = getOption("mc.cores"))
            
            #Get R value
            groupOutputMatrixR[i,j] <- res$statistic
            #Get p-value
            groupOutputMatrixp[i,j] <- res$signif
    
          }else if (groupSimMethod =="p"){
            # Perform Permanova
            res2 <- adonis(t(subgroupMatrix) ~ CLASSIFICATIONS, data =as.data.frame(t(classifications)), permutations=perm)
            
            #Get R value
            groupOutputMatrixR[i,j] <- res2$aov.tab$R2[1]
            #Get p-value
            groupOutputMatrixp[i,j] <- res2$aov.tab$`Pr(>F)`[1]
            
          }
        }
      }
    }
    
  #--------------------------------------------------
  "Export the results"
  #--------------------------------------------------  
    
    write.table(groupOutputMatrixp, file = paste("Pvalue",".csv"), append = FALSE, quote = TRUE, sep = ask_sep,
                eol = "\n", na = "NA", dec = ".", row.names = TRUE,
                col.names = NA, qmethod = c("escape", "double"),
                fileEncoding = "")
    write.table(groupOutputMatrixR, file = paste("Rvalue",".csv"), append = FALSE, quote = TRUE, sep = ask_sep,
                eol = "\n", na = "NA", dec = ".", row.names = TRUE,
                col.names = NA, qmethod = c("escape", "double"),
                fileEncoding = "")
    
    
  print(paste("FINISHED"), quote = FALSE)
  cat("\f")       # Clear old outputs
    
