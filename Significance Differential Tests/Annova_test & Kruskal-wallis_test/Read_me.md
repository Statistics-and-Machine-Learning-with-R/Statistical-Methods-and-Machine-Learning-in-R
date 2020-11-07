## ABOUT TESTS
### ANOVA TEST
The one-way analysis of variance (ANOVA) is used to determine whether there are any statistically significant differences between the means of two or more independent (unrelated) groups (although you tend to only see it used when there are a minimum of three, rather than two groups).


#### ABOUT PACKAGE

  The main package for used for this test is "FSA" Package. 
  
  Usage:
  aov(formula, data = NULL, projections = FALSE, qr = TRUE,
    contrasts = NULL, ...)
       
  * Parameters:
  
  formula: a formula specifying the model. <br/>
  data: a data frame in which the variables specified in the formula will be found. If missing, the variables are searched for in the standard way.



### KRUSKAL WALLIS TEST
In statistics, the Mann–Whitney U test is a nonparametric test of the null hypothesis that, for randomly selected values X and Y from two populations, the probability of X being greater than Y is equal to the probability of Y being greater than X.

#### ABOUT PACKAGE
 Usage:
 kruskal.test(x, ...)
           
 * Parameters:

x: a numeric vector of data values, or a list of numeric data vectors. Non-numeric elements of a list will be coerced, with a warning.<br/>
g: a vector or factor object giving the group for the corresponding elements of x. Ignored with a warning if x is a list.<br/>
formula: a formula of the form response ~ group where response gives the data values and group a vector or factor of the corresponding groups.<br/>
data: an optional matrix or data frame (or similar: see model.frame) containing the variables in the formula formula. By default the variables are taken from environment(formula).




## LINK TO THEORY
* [Anova Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/ANOVA)
* [Kruskal-Wallis_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Kruskal-Wallis-Test-(H-Test))

