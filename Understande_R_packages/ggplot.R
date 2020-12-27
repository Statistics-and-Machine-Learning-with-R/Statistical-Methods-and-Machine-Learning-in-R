                 
"ggplot2 is a powerful and a flexible R package, implemented by Hadley Wickham,
for producing elegant graphics"

"The concept behind ggplot2 divides plot into three different fundamental parts: 
                    Plot = data + Aesthetics + Geometry"

"The principal components of every plot can be defined as follow:"
  
"Data is a data frame
Aesthetics is used to indicate x and y variables. It can also be used to control the color, the size or the shape of points, the height of bars, etc…..
Geometry defines the type of graphics (histogram, box plot, line plot, density plot, dot plot, ….)"


                                  
                                      #------------------------------------
                                      "Install Package ggplot2"
                                      #------------------------------------

install.packages("ggplot2") # download the package
library (ggplot2)            # load the package   
?mtcars                     # dataset to  be used


                                     
                                     #------------------------------------
                                             "Basic scatter plots"
                                     #------------------------------------
          
'Simple scatter plots are created using the R code. The color, the size and 
the shape of points can be changed using the function  geom_point()'

                           
# mtcars = data
# aes = aesthetics
# geom_point(size, color, shape) 
                       
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() 
                       
                       
                       
# Change the point size, and shape:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(size=2, shape=23)


# Label points in the scatter plot:
# used "geom_text" to lavel points

ggplot(mtcars, aes(x=wt, y=mpg)) +geom_point() + geom_text(label=rownames(mtcars))




                                      #------------------------------------
                                      "Add regression lines in the data"
                                      #------------------------------------

# geom_smooth() and stat_smooth() to be used

ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()+ geom_smooth(method=lm) 

# Remove the confidence interval:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()+ geom_smooth(method=lm, se=FALSE)

# Loess method:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()+ geom_smooth()



                                      #------------------------------------
                                    "Change the appearance of points and lines"
                                      #------------------------------------

# Change colors and shape of point and line
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(shape=18, color="blue")+ geom_smooth(method=lm, se=FALSE, linetype="dashed", color="darkred")

# Change the confidence interval fill color
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(shape=18, color="blue")+ geom_smooth(method=lm, linetype="dashed", color="darkred", fill="blue")





                                   #------------------------------------
                                   "Scatter plots with multiple groups"
                                b  #------------------------------------


# Change point shapes by the levels of cyl 
ggplot(mtcars, aes(x=wt, y=mpg, shape=cyl)) + geom_point()

# Change point shapes and colors 
ggplot(mtcars, aes(x=wt, y=mpg, shape=cyl, color=cyl)) + geom_point() 

# Change point shapes, colors and sizes 
ggplot(mtcars, aes(x=wt, y=mpg, shape=cyl, color=cyl, size=cyl)) + geom_point()


                                  #------------------------------------
                                     "Add multiple regression lines:"
                                  #------------------------------------


# Add regression lines
ggplot(mtcars, aes(x=wt, y=mpg, color=cyl, shape=cyl)) + geom_point() + geom_smooth(method=lm)

# Remove confidence intervals and Extend the regression lines
ggplot(mtcars, aes(x=wt, y=mpg, color=cyl, shape=cyl)) + geom_point() + geom_smooth(method=lm, se=FALSE, fullrange=TRUE)


#The fill color of confidence bands can be changed as follow :
ggplot(mtcars, aes(x=wt, y=mpg, color=cyl, shape=cyl))+ geom_point() + geom_smooth(method=lm, aes(fill=cyl))






                       


                       