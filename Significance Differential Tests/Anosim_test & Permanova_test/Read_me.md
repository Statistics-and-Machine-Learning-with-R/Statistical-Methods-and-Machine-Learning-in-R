# 
## ABOUT TESTS
### ANOSIM-TEST
The ANOSIM test is similar to an ANOVA hypothesis test, but it uses a dissimilarity matrix as input instead of raw data. It is also non-parametric, meaning it doesn’t assume much about your data (like normal distribution etc), so it’s a good bet for often-skewed microbial abundance data. As a non-parametric test, ANOSIM uses ranked dissimilarities instead of actual distances. The main point of the ANOSIM test is to determine if the differences between two or more groups are significant. We are performing ANOSIM-Test and PERMANOVA-Test on 'Input_file_Anosim&Permanova' and their Groupings using 'Groupings_file_Anosim&Permanova' , provided with the code.


#### ABOUT PACKAGE

  Usage:
  anosim(dat, grouping, permutations = 999, distance = "bray", strata = NULL,
    parallel = getOption("mc.cores"))
       
  Arguments:

  dat: Data matrix or data frame in which rows are samples and columns are response variable(s), or a dissimilarity object or a symmetric square matrix of dissimilarities.
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

