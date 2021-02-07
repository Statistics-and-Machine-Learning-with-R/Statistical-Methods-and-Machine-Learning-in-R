
######################
## Data Types in R ###
######################



# Cleaning the workspace

cat("\f")       # Clear old outputs
rm(list=ls())   # Clear all variables

#-------------------------------------------------------------------------------
"Data Types in R"
#-------------------------------------------------------------------------------

## Vector ##
x <- 10 
print(x)

## Matrix ##
M <- matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)

## Factor ##
apple_colors <- c('green','green','yellow','red','red','red','green')           # Create a vector
factor_apple <- factor(apple_colors)                                            # Create a factor object
print(factor_apple)

## Time Series ##
myvector <- c(10,20,30,40,50,60,70,80,90,100,110,120)
myts <- ts(myvector, start=c(2019, 1), end = c(2019,12), frequency=12)
print(myts)

## Data Frame ##
BMI <- data.frame(gender = c("Male", "Male","Female"), height = c(152, 171.5, 165), weight = c(81,93, 78), Age = c(42,38,26))
print(BMI)

## List ##
list1 <- list(c(2,5,3), 21.3, sin)
print(list1)

## Array ##
a <- array(c('green','yellow'),dim = c(3,3,2))
print(a)

#########################################################################
