## ABOUT TESTS
### T-TEST
The t-test is any statistical hypothesis test in which the test statistic follows a Student's t-distribution under the null hypothesis. A t-test is the most commonly applied when the test statistic would follow a normal distribution if the value of a scaling term in the test statistic were known. We are performing T-Test and U-Test on Meta Protein Dataset, provided with the code. 


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
  
  x: a (non-empty) numeric vector of data values.<br/>
  y: an optional (non-empty) numeric vector of data values.<br/>
  data: an optional matrix or data frame containing the variables in the formula formula. By default the variables are taken from environment(formula).



### U-TEST
In statistics, the Mann–Whitney U test is a nonparametric test of the null hypothesis that, for randomly selected values X and Y from two populations, the probability of X being greater than Y is equal to the probability of Y being greater than X.

#### ABOUT PACKAGE
 Usage:
 wilcox.test(x, y = NULL,
            alternative = c("two.sided", "less", "greater"),
            mu = 0, paired = FALSE, exact = NULL, correct = TRUE,
            conf.int = FALSE, conf.level = 0.95,
            tol.root = 1e-4, digits.rank = Inf, ...)
           
 Parameters:
 
 x: numeric vector of data values. Non-finite (e.g., infinite or missing) values will be omitted.<br/>
 y: an optional numeric vector of data values: as with x non-finite values will be omitted.<br/>
 data: an optional matrix or data frame containing the variables in the formula formula. By default the variables are taken from environment(formula).




## LINK TO THEORY
* [T_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/T-Test)
* [U_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/U-Test)

