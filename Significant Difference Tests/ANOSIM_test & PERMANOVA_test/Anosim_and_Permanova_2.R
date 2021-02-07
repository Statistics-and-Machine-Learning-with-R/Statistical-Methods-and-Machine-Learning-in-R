#--------------------------------------------------
"STEP 4 : Perform ANOSIM and PERMANOVA"
#--------------------------------------------------

groupDifferenceData <- function(NORMDATA,groups,groupSimMethod, perm) {
  
  # Get the data matrix
  groupMatrix <- NORMDATA@MATRIX
  
  # Get non-redundant list of subgroups
  uniqueGroups <- unique(t(groups))
  
  # Creates the output matrix for R and p-values
  groupOutputMatrixR <- matrix("empty", nrow=nrow(uniqueGroups), ncol= nrow(uniqueGroups))
  groupOutputMatrixp <- matrix("empty", nrow=nrow(uniqueGroups), ncol= nrow(uniqueGroups))
  # Set the column heades for the R and p-value matrix
  rownames(groupOutputMatrixR)<- uniqueGroups[1:nrow(uniqueGroups),1]
  colnames(groupOutputMatrixR) <- uniqueGroups[1:nrow(uniqueGroups),1]
  rownames(groupOutputMatrixp)<- uniqueGroups[1:nrow(uniqueGroups),1]
  colnames(groupOutputMatrixp) <- uniqueGroups[1:nrow(uniqueGroups),1]
  
  # Iterate over all combinations of groups
  for (i in 1:nrow(uniqueGroups)){
    for (j in 1:nrow(uniqueGroups)){
      
      # Create submatrix and its classification subvextor
      # Empty subgroupmatrix
      subgroupMatrix = matrix(nrow =nrow(groupMatrix), ncol = 0)
      # Set the rownames
      rownames(subgroupMatrix) <- rownames(groupMatrix)
      # Empty classification matrix
      classifications = matrix(nrow = 1, ncol = 0)
      rownames(classifications) <- "CLASSIFICATIONS"
      # For loop to fill subgroupmatrix and classification matrix
      for (samples in 1:ncol(groupMatrix)){
        if ((uniqueGroups[i,1] == groups[1,samples]) || (uniqueGroups[j,1] == groups[1,samples])) {
          # Get the information for the subgroupmatrix and the column name
          subgroupMatrix <- cbind(subgroupMatrix, groupMatrix[0:nrow(groupMatrix),samples])
          colnames(subgroupMatrix)[ncol(subgroupMatrix)] <-colnames(groupMatrix)[samples]
          # Get the classifications and the column names
          classifications <-cbind(classifications,t(groups[1,samples]))
          colnames(classifications)[ncol(classifications)] <-colnames(groupMatrix)[samples]
        }
      }
      
      
      # Calculate Anosim and Permanova matrix, for similar input classes (only one input) group the similarity is 1 
      # and p-value is 0.
      if(uniqueGroups[i,1] == uniqueGroups[j,1]){
        # Get R value
        groupOutputMatrixR[i,j] <-1
        # Get p-value
        groupOutputMatrixp[i,j] <- 0
        
      }else{
        # Calculate ANOSIM or PermANOVA
        if (groupSimMethod =="ANOSIM") {
          # Perform ANOSIM
          ######Description ANOSIM function#######################
          # https://www.rdocumentation.org/packages/vegan/versions/2.3-5/topics/anosim
          # Analysis of similarities (ANOSIM) provides a way to test statistically 
          # whether there is a significant difference between two or more groups of 
          # sampling units. Function anosim operates directly
          # on a dissimilarity matrix. A suitable dissimilarity matrix is produced by functions 
          # dist or vegdist. The method is philosophically allied with NMDS ordination (monoMDS), 
          # in that it uses only the rank order of dissimilarity values.
          
          # If two groups of sampling units are really different in their species
          # composition, then compositional dissimilarities between the groups ought to be
          # greater than those within the groups. The anosim statistic R is based on the difference of 
          # mean ranks between groups (rB) and within groups (rW):
          ########################################################
          res <- anosim(t(subgroupMatrix), classifications, permutations = perm, distance = "manhattan", strata = NULL,
                        parallel = getOption("mc.cores"))
          
          # Get R value
          groupOutputMatrixR[i,j] <- res$statistic
          # Get p-value
          groupOutputMatrixp[i,j] <- res$signif
          
        }else{
          # Perform PermAnova
          # Permanova
          # https://www.youtube.com/watch?v=1QGI6u0BVnQ
          # a$aov.tab$R2
          # a$aov.tab$`Pr(>F)`
          ###################################################
          res2 <- adonis(t(subgroupMatrix) ~ CLASSIFICATIONS, data =as.data.frame(t(classifications)), permutations=perm)
          
          # Get R value
          groupOutputMatrixR[i,j] <- res2$aov.tab$R2[1]
          # Get p-value
          groupOutputMatrixp[i,j] <- res2$aov.tab$`Pr(>F)`[1]
        }
      }
    }
  }
  
  
  #--------------------------------------------------
  "STEP 5 : Export the results"
  #--------------------------------------------------
  
  
  write.table(groupOutputMatrixR, file = paste("_Rvalue_",groupSimMethod,".csv"), append = FALSE, quote = TRUE, sep = ";",
              eol = "\n", na = "NA", dec = ".", row.names = TRUE,
              col.names = NA, qmethod = c("escape", "double"),
              fileEncoding = "")
  write.table(groupOutputMatrixp, file = paste("_PValue_",groupSimMethod,".csv"), append = FALSE, quote = TRUE, sep = ";",
              eol = "\n", na = "NA", dec = ".", row.names = TRUE,
              col.names = NA, qmethod = c("escape", "double"),
              fileEncoding = "")
  
  print("4b. Finish tests for group differences")
}