
#############################################################
### Input (Reading) Data & Output (Writing) csv file in R ###
#############################################################



# Cleaning the workspace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


#-------------------------------------------------------------------------------
"Input"
#-------------------------------------------------------------------------------

df <- read.csv("C:/Desktop/Presentation Dataset 1.csv", header = TRUE)    #row.names is used to name the first column of the dataset. It defines the name of rows
## or ##
data_csv <- file.choose()                                                 # choose csv file

data_matrix <- read.csv(data_csv, header = TRUE, sep = ",")               # converts the csv file into a data matrix, header = TRUE is as like row.names = TRUE, sep = "," indicates the separator in csv file

print(data_matrix)

#-------------------------------------------------------------------------------
"Choosing CSV File & convert into Data Frame"
#-------------------------------------------------------------------------------

write.csv(df,"C:\\Users\\Ron\\Desktop\\PresentationDataset 1.csv", row.names = TRUE) # copy and paste address of your desired file location

#######################################################################################
