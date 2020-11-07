# 
## ABOUT TESTS
### ANOSIM-TEST
The ANOSIM test is similar to an ANOVA hypothesis test, but it uses a dissimilarity matrix as input instead of raw data. It is also non-parametric, meaning it doesn’t assume much about your data (like normal distribution etc), so it’s a good bet for often-skewed microbial abundance data. As a non-parametric test, ANOSIM uses ranked dissimilarities instead of actual distances. 


* t is the t-test statistic value
* df is the degrees of freedom
* p-value is the significance level of the t-test 
* conf.int is the confidence interval of the mean at 95%
* sample estimates is he mean value of the sample


#### ABOUT PACKAGE

  Usage:
  t.test(x, y = NULL,
       alternative = c("two.sided", "less", "greater"),
       mu = 0, paired = FALSE, var.equal = FALSE,
       conf.level = 0.95, ...)
       
  Parameters:

  x: a (non-empty) numeric vector of data values.
  y: an optional (non-empty) numeric vector of data values.
  data: an optional matrix or data frame containing the variables in the formula formula. By default the variables are taken from environment(formula).



### PERMANOVA-TEST
In statistics, the Mann–Whitney U test is a nonparametric test of the null hypothesis that, for randomly selected values X and Y from two populations, the probability of X being greater than Y is equal to the probability of Y being greater than X.

#### ABOUT PACKAGE
 Usage:
 wilcox.test(x, y = NULL,
            alternative = c("two.sided", "less", "greater"),
            mu = 0, paired = FALSE, exact = NULL, correct = TRUE,
            conf.int = FALSE, conf.level = 0.95,
            tol.root = 1e-4, digits.rank = Inf, ...)
           
 Parameters:
 x:numeric vector of data values. Non-finite (e.g., infinite or missing) values will be omitted.
 y: an optional numeric vector of data values: as with x non-finite values will be omitted.
 data: an optional matrix or data frame containing the variables in the formula formula. By default the variables are taken from environment(formula).




## LINK TO THEORY
* [T_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/T-Test)
* [U_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/U-Test)

