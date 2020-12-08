## ABOUT SCRIPTS
### DECISION TREE
A decision tree is one of the supervised machine learning algorithms. This algorithm can be used for regression and classification problems, is mostly used for classification problems. A decision tree follows a set of if-else conditions to visualize the data and classify it according to the conditions.

## ABOUT PACKAGE

  The main packages for used for this test is "RPART" and "RPART.PLOT" Packages. 
  
  **Usage:**<br/>
  rpart(formula, data, weights, subset, na.action = na.rpart, method,
      model = FALSE, x = FALSE, y = TRUE, parms, control, cost, ...)

       
  **Arguments:**
  
  **formula:** a formula, with a response but no interaction terms. If this a a data frame, that is taken as the model frame. <br/>
  **data:** an optional data frame in which to interpret the variables named in the formula. <br/>
  **method:** one of "anova", "poisson", "class" or "exp". If method is missing then the routine tries to make an intelligent guess. If y is a survival object, then    method = "exp" is assumed, if y has 2 columns then method = "poisson" is assumed, if y is a factor then method = "class" is assumed, otherwise method = "anova" is assumed. It is wisest to specify the method directly, especially as more criteria may added to the function in future.

Alternatively, method can be a list of functions named init, split and eval. Examples are given in the file ‘tests/usersplits.R’ in the sources, and in the vignettes ‘User Written Split Functions’.



## LINK TO THEORY
* [Desicion Tree](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Decision-Tree)
 
