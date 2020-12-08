# Reshaping data using tidyr package:

# The tidyr package, provides four functions to help you change the layout of your data set:
  
                        #   gather(): gather (collapse) columns into rows
                        # spread(): spread rows into columns
                        # separate(): separate one column into multiple
                        # unite(): unite multiple columns into one


#####################################################################################################
                                        #Installing and loading tidyr
#####################################################################################################

# Installing
install.packages("tidyr")
# Loading
library("tidyr")


#####################################################################################################
                                              #Example data sets
#####################################################################################################

my_data <- USArrests[c(1, 10, 20, 30), ]
my_data


##: Row names are states, so let’s use the function cbind() to add a column named “state” 
##  in the data. This will make the data tidy and the analysis easier.

my_data <- cbind(state = rownames(my_data), my_data)
my_data


#####################################################################################################
                               
                            #1:   gather(): collapse columns into rows
                                  #[Replacement of MELT(reshape2)]

#####################################################################################################

# Simplified format:
#   gather(data, key, value, ...)

                      # data: A data frame
                      # key, value: Names of key and value columns to create in output
                      # …: Specification of columns to gather. Allowed values are:
                      #   variable names
                      # if you want to select all variables between a and e, use a:e
                      # if you want to exclude a column name y use -y
                      # for more options, see: dplyr::select()

# Examples of usage:
                      #Gather all columns except the column state

my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   -state)
my_data2

                      #Gather only Murder and Assault columns

my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   Murder, Assault)
my_data2


                      #Gather all variables between Murder and UrbanPop

my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   Murder:UrbanPop)
my_data2

                    #How to use gather() programmatically inside an R function?

#The simplified syntax is as follow:
  
#gather_(data, key_col, value_col, gather_cols)

#data: a data frame
#key_col, value_col: Strings specifying the names of key and value columns to create
#gather_cols: Character vector specifying column names to be gathered together into pair of key-value columns.


#As an example, type this:
  
  gather_(my_data,
          key_col = "arrest_attribute",
          value_col = "arrest_estimate",
          gather_cols = c("Murder", "Assault"))
  
#####################################################################################################
#####################################################################################################
#####################################################################################################
                         
                         #2    spread(): spread two columns into multiple columns
                                        #[Replacement of CAST(reshape2)]
  
#####################################################################################################
  
# The function spread() does the reverse of gather(). It takes two columns (key and value) and 
# spreads into multiple columns. It produces a “wide” data format from a “long” one.
# It’s an alternative of the function cast() [in reshape2 package].
  
  
##Simplified format:
#spread(data, key, value)
  
            # data: A data frame
            # key: The (unquoted) name of the column whose values will be used as column headings.
            # value:The (unquoted) names of the column whose values will populate the cells
 
  
##Examples of usage:
            #Spread “my_data2” to turn back to the original data:
    
my_data3 <- spread(my_data2, 
    key = "arrest_attribute",
    value = "arrest_estimate"
)
my_data3
  
  

##How to use spread() programmatically inside an R function?
#The simplified syntax is as follow:
  
#spread_(data, key_col, value_col)

                #data: a data frame.
                #key_col, value_col: Strings specifying the names of key and value columns.

#As an example, type this:
  
  spread_(my_data2, 
          key = "arrest_attribute",
          value = "arrest_estimate"
  )
  
#####################################################################################################
#####################################################################################################
#####################################################################################################
  
                                #3    unite(): Unite multiple columns into one
  
#####################################################################################################  
  
  
#The function unite() takes multiple columns and paste them together into one.
  

#Simplified format:
  
#unite(data, col, ..., sep = "_")
  
                          # data: A data frame
                          # col: The new (unquoted) name of column to add.
                          # sep: Separator to use between values
  
  
#Examples of usage:
    
#The R code below uses the data set “my_data” and unites the columns Murder and Assault
  
  my_data4 <- unite(my_data,
                    col = "Murder_Assault",
                    Murder, Assault,
                    sep = "_")
  my_data4  
  
  
  
  
##How to use unite() programmatically inside an R function?
  
#unite_(data, col, from, sep = "_")
  
                     # data: A data frame.
                     # col: String giving the name of the new column to be added
                     # from: Character vector specifying the names of existing columns to be united
                     # sep: Separator to use between values.
  
  
#As an example, type this:
    
    unite_(my_data,
           col = "Murder_Assault",
           from = c("Murder", "Assault"),
           sep = "_")
  
#####################################################################################################
#####################################################################################################
#####################################################################################################
    
                        #4    separate(): separate one column into multiple
    
#####################################################################################################

# The function sperate() is the reverse of unite(). It takes values inside a single character
# column and separates them into multiple columns.   
    
  
#Simplified format:
#separate(data, col, into, sep = "[^[:alnum:]]+")
    
                # data: A data frame
                # col: Unquoted column names
                # into: Character vector specifying the names of new variables to be created.
                # sep: Separator between columns:
                #   If character, is interpreted as a regular expression.
                #   If numeric, interpreted as positions to split at. Positive values start at
                #   1 at the far-left of the string; negative value start at -1 at the far-right of the string.
    
    
#Examples of usage:

#Separate the column “Murder_Assault” [in my_data4] into two columns Murder and Assault:
      
      separate(my_data4,
               col = "Murder_Assault",
               into = c("Murder", "Assault"),
               sep = "_")
    
    
    
    #####################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    ##########################################################################################################################################################################################################
    #####################################################################################################
    #####################################################################################################
    
    
  
  
  
