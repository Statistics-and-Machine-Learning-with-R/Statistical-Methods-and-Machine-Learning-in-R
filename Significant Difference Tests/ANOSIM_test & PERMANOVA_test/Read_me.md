# 
## ABOUT TESTS
### ANOSIM-TEST
The ANOSIM test is similar to an ANOVA hypothesis test, but it uses a dissimilarity matrix as input instead of raw data. It is also non-parametric, meaning it doesn’t assume much about your data (like normal distribution etc), so it’s a good bet for often-skewed microbial abundance data. As a non-parametric test, ANOSIM uses ranked dissimilarities instead of actual distances. The main point of the ANOSIM test is to determine if the differences between two or more groups are significant. We are performing ANOSIM-Test and PERMANOVA-Test on 'Input_file_Anosim&Permanova' and their Groupings using 'Groupings_file_Anosim&Permanova' , provided with the code.


#### ABOUT PACKAGE

  **Usage:**<br/>
  anosim(dat, grouping, permutations = 999, distance = "bray", strata = NULL,
    parallel = getOption("mc.cores"))
       
  **Arguments:**

  **dat:**          Data matrix or data frame in which rows are samples and columns are response variable(s), or a dissimilarity object or a symmetric square matrix of                               dissimilarities. <br />
  **grouping:**     Factor for grouping observations.<br />
  **permutations:** a list of control values for the permutations as returned by the function how, or the number of permutations required, or a permutation matrix where each row                     gives the permuted indices. We are just giving the script number of permutations.<br />
  **distance:**     Choice of distance metric that measures the dissimilarity between two observations. See vegdist for options. This will be used if dat was not a dissimilarity                     structure or a symmetr.<br />
  **strata:**       An integer vector or factor specifying the strata for permutation. If supplied, observations are permuted only within the specified strata.<br />
  **parallel:**     Number of parallel processes or a predefined socket cluster. With parallel = 1 uses ordinary, non-parallel processing. The parallel processing is done with                       parallel package.<br />



### PERMANOVA-TEST
PERMANOVA is a Multivariate ANOVA with permutations. It is meant to test differences between groups like an ANOVA test, but with a lot of variables.
PERMANOVA tests whether distances differ between groups.

#### ABOUT PACKAGE
 **Usage:**<br/>
 adonis(formula, data, permutations = 999, method = "bray",
       strata = NULL, contr.unordered = "contr.sum",
       contr.ordered = "contr.poly", parallel = getOption("mc.cores"), ...)
           
 **Arguments:**
 
 **formula:**                        a typical model formula such as Y ~ A + B*C, but where Y is either a dissimilarity object (inheriting from class "dist") or data frame or a                                      matrix; A, B, and C may be factors or continuous variables. If a dissimilarity object is supplied, no species coefficients can be                                                calculated<br /> 
 **data:**                           the data frame from which A, B, and C would be drawn.<br />
 **permutations:**                   a list of control values for the permutations as returned by the function how, or the number of permutations required, or a permutation                                          matrix where each row gives the permuted indices. We are just giving the script number of permutations.<br />
 **strata:**                         An integer vector specifying the strata for permutation. If given, observations are permuted only within the specified strata.<br />
 **method:**                         the name of any method used in vegdist to calculate pairwise distances.<br />
 **contr.unordered, contr.ordered:** contrasts used for the design matrix (default in R is dummy or treatment contrasts for unordered factors)..<br />
 **parallel:**                       Number of parallel processes or a predefined socket cluster. With parallel = 1 uses ordinary, non-parallel processing. The parallel                                              processing is done with parallel package.<br />
 **...**                             Other arguments passed to vegdist.



## LINK TO THEORY
* [ANOSIM_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/ANOSIM)
* [PERMANOVA_Test](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Permutational-Multivariate-Analysis-of-Variance)

