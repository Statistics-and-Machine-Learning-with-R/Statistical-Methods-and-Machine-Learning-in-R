
####################
## Normalization ##
###################

# Cleaning the workplace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables


# Creating a data matrix

data_matrix <- as.data.frame(iris)
data_matrix


## Normalization of Variables ##

data_matrix$Sepal.Length <- scale(data_matrix$Sepal.Length, center = TRUE, scale = TRUE)  # scales  variable by calculating     
data_matrix$Sepal.Width <- scale(data_matrix$Sepal.Width, center = TRUE, scale = TRUE)    # the mean and standard deviation of the entire vector,
data_matrix$Petal.Length <- scale(data_matrix$Petal.Length, center = TRUE, scale = TRUE)  # if scale is TRUE then scaling is done by dividing
data_matrix$Petal.Length <- scale(data_matrix$Petal.Width, center = TRUE, scale = TRUE)   # the (centered) columns of x by their standard deviations
                                                                                          # if center is TRUE, and the root mean square otherwise.
data_matrix                                                                               # If scale is FALSE, no scaling is done

########################
## Test for Normality ##
########################

## Test for Normality : Shapiro-Wilk Test ##
# The data is normal if the p-value is above 0.05 #

shapiro.test(data_matrix$Sepal.Length)            # passed
shapiro.test(data_matrix$Sepal.Width)             # passed
shapiro.test(data_matrix$Petal.Length)            # did not pass      
shapiro.test(data_matrix$Petal.Width)             # did not pass

# Normalization does not change the distribution of a variable. If a variable did not pass test for normality
# before normalization, most probably it would not even after normalization


###############################################