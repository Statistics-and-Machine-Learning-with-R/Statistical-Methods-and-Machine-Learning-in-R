#-------------------------------------------------------------------------------------------------------------
#                                        PCA, PCOA AND NMDS
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
    

# Inforamtion about the software:

print(paste("Info"), quote = FALSE)
print(paste("Date", sourceDate), quote = FALSE)
print(paste("Version", sourceVersion), quote = FALSE)
print(paste("Author", sourceAuthor), quote = FALSE)



# Installing  Packages

# Package for package administration:
if(!require("ggplot2")) install.packages("ggplot2") 
if(!require("dplyr")) install.packages("dplyr") 
if(!require("vegan")) install.packages("vegan")
if(!require("ape")) install.packages("ape",repo='https://mac.R-project.org',dependencies = F)

if(!require("ggbiplot")) install_github("vqv/ggbiplot")



# Add the associated libraries to the programm
library("ggplot2")
library("dplyr")
library("vegan")
library("ape")
library('ggbiplot')
library('devtools')

# MAIN PROGRAM STARTS HERE 

# # Declaration of parameters:
 # SEPARATOR = ";"  # Separator within the csv. -files

# Output path:
# outputname = "Result_of_Ordiantion"

# outputname = "/Users/mac/Documents/Result_of_T&U_test.csv"



#------------------------------------------------
# STEP 1: Gets the matrix and Choose Groups
#------------------------------------------------

# Choose a csv file
print(paste("Please select Input CSV", " The different samples in columns and the measured variables in the rows."), quote = FALSE)
fname <- file.choose()
file1 <- read.csv(fname, sep=',')

#Extract contineous variables: (If there are columns/variables with categories,first remove them)


matrix <- file1[,-5]  #all variables except 5th(Species)


#--------------------------------------------------
# STEP 2: Calculates PCA, PCoA & NMS
#--------------------------------------------------

                                            #-------------------------------------
                                            # PCA(Principal Component Analysis)
                                            #-------------------------------------

                              # apply PCA on matrix, rda() is included in package VEGAN which performs PCA :


PCA <- rda(matrix,scale=T) #scale=T implies we can scale our data

#Eigenvalues?
PCA$CA$eig

      # Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis

barplot(as.vector(PCA$CA$eig)/sum(PCA$CA$eig)) 


                    # How much of the variance in our dataset is explained by the first principal component?

# Calculate the percent of variance explained by first two axes
sum((as.vector(PCA$CA$eig)/sum(PCA$CA$eig))[1:2]) # 95%, this is ok.




                                                        # display

# display = sites corresonds to the rows of data; one datapoint per row
# display = species corresponds to the columns of data; one line/arrow per column


                                                            # type

# type = text plots row numbers and column names as labels
# type = points plots points

plot(PCA, display = "site", type = "text")
plot(PCA, display = "species", type = "text")

                         # You can extract the species and site scores on the new PC for further analyses:

sitePCA <- PCA$CA$u # Site scores
#View(sitePCA)
speciesPCA <- PCA$CA$v # Species scores
#View(speciesPCA)

                                                    # combine matrix with  site-score
PCAstate <- cbind(file1,PCA$CA$u)
#View(PCAiris)




                                                  #-------------------------------------
                                                  # PCoA(Principal Coordinate Analysis)
                                                  #-------------------------------------

                                            # Make distance-Matrix and use method of distance:


dist <- vegdist(matrix,  method = "bray")

                      # apply PCoA on distance-matrix, pcoa() is included in package APE which performs PCoA
PCOA <- pcoa(dist)

       # Now plot a bar plot of relative eigenvalues. This is the percentage variance explained by each axis

barplot(PCOA$values$Relative_eig)

                     #How much of the variance in our dataset is explained by the first principal component?
  
# Calculate the percent of variance explained by first two axes
sum(PCOA$values$Relative_eig[1:2]) # 97%, this is ok.
  
#site_score
sitePCoA <- PCOA$vectors
#View(sitePCoA) #Axis.1 is same as PC1 and so-on(difference in name due to different package)

# combine matrix with  site-score
PCoAstate <- cbind(file1,PCOA$vectors)
#View(PCoAiris)

                                        #----------------------------------------------
                                        # NMDS (Non-metric Multidimensional Scaling)
                                        #----------------------------------------------

# apply NMDS on matrix, metaMDS is included in package VEGAN which performs NMDS :
NMDS_CALC <- metaMDS(matrix, k = 2, trymax = 100, trace = F, autotransform = FALSE, distance="bray")
NMDS_CALC


#--------------------------------------------------
#  STEP 3: Visualizations
#--------------------------------------------------


                                            #-------------------------------------
                                            #   PCA(Principal Component Analysis)
                                            #-------------------------------------

 
# In a biplot of a PCA, species' scores are drawn as arrows that point in the direction of increasing values for that variable

biplot(PCA, choices = c(1,2),
       type = c("text", "points"),
       display = c('site','species')) # biplot of axis 1 vs 2

biplot(PCA, choices = c(1,3), 
       type = c("text","points"),
       display = c('site','species')) # biplot of axis 1 vs 3



#Group as per State:
ggplot(PCAstate,aes(x=PC1,y=PC2,color=State,fill=State))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

ggplot(PCAstate,aes(x=PC1,y=PC3,color=State,fill=State))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

#Group as per City:

fname <- file.choose()
file2 <- read.csv(fname, sep=',')

PCAcity <- cbind(file2,PCA$CA$u)


ggplot(PCAcity,aes(x=PC1,y=PC2,color=City,fill=City))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

ggplot(PCAcity,aes(x=PC1,y=PC3,color=City,fill=City))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')




                                            #-------------------------------------
                                            # PCoA(Principal Coordinate Analysis)
                                            #-------------------------------------

biplot(PCOA)
biplot(PCOA,file1[,-5])


#Group as per State:

ggplot(PCoAstate,aes(x=Axis.1,y=Axis.2,color=State,fill=State))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

ggplot(PCoAstate,aes(x=Axis.1,y=Axis.3,color=State,fill=State))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

#Group as per City:

PCoAcity <- PCoAstate <- cbind(file2,PCOA$vectors)

ggplot(PCoAcity,aes(x=Axis.1,y=Axis.2,color=City,fill=City))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')

ggplot(PCoAcity,aes(x=Axis.1,y=Axis.3,color=City,fill=City))+
  stat_ellipse(geom = 'polygon',col='black',alpha=0.5)+
  geom_point(shape=21,col='black')




                                              #-------------------------------------------
                                              # NMDS(Non-Metric Multidimensional Scaling)
                                              #-------------------------------------------

#Stress Plot
stressplot(NMDS_CALC)
#Plot to visualize NMDS
plot(NMDS_CALC,type="t")



                                            #-------------------------------------
                                            #        PCA vs PCoA
                                            #-------------------------------------

#Compare PCA vs PCoA graph:
par(mfrow = c(1, 2)) 
biplot.pcoa(PCOA)
plot(PCA)

# reset plot window
par(mfrow = c(1, 1)) 


#--------------------------------------------------
# STEP 4 : Export the results
#--------------------------------------------------


# write.table(PCa1, file = paste(outputname), append = FALSE, quote = TRUE, sep = ";",
#             eol = "\n", na = "NA", dec = ".", row.names = TRUE,
#             col.names = NA, qmethod = c("escape", "double"),
#             fileEncoding = "")


#--------------------------------------------------
# STEP 5: Finish
#--------------------------------------------------
print(paste("FINISHED"), quote = FALSE)





