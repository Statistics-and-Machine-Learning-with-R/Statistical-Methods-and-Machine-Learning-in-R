## ABOUT SCRIPTS
### DECISION TREE
A decision tree is one of the supervised machine learning algorithms. This algorithm can be used for regression and classification problems — yet, is mostly used for classification problems. A decision tree follows a set of if-else conditions to visualize the data and classify it according to the conditions.

#### ABOUT PACKAGE

  The main packages for used for this test is "RPART" and "RPART.PLOT" Packages. 
  
  Usage:
  rpart(formula, data, weights, subset, na.action = na.rpart, method,
      model = FALSE, x = FALSE, y = TRUE, parms, control, cost, ...)

       
  * Parameters:
  
  formula: a formula, with a response but no interaction terms. If this a a data frame, that is taken as the model frame. <br/>
  data: an optional data frame in which to interpret the variables named in the formula. <br/>
  method: one of "anova", "poisson", "class" or "exp". If method is missing then the routine tries to make an intelligent guess. If y is a survival object, then    method = "exp" is assumed, if y has 2 columns then method = "poisson" is assumed, if y is a factor then method = "class" is assumed, otherwise method = "anova" is assumed. It is wisest to specify the method directly, especially as more criteria may added to the function in future.

Alternatively, method can be a list of functions named init, split and eval. Examples are given in the file ‘tests/usersplits.R’ in the sources, and in the vignettes ‘User Written Split Functions’.



### ARTIFICIAL NEURAL NETWORK
An artificial neural network (ANN) is the component of artificial intelligence that is meant to simulate the functioning of a human brain. Processing units make up ANNs, which in turn consist of inputs and outputs. The inputs are what the ANN learns from to produce the desired output.

#### ABOUT PACKAGE
The main packages for used for this test is "NEURALNET" AND "CARET" Packages. 
 Usage:
 neuralnet(formula, data, hidden = 1, threshold = 0.01,
  stepmax = 1e+05, rep = 1, startweights = NULL,
  learningrate.limit = NULL, learningrate.factor = list(minus = 0.5,
  plus = 1.2), learningrate = NULL, lifesign = "none",
  lifesign.step = 1000, algorithm = "rprop+", err.fct = "sse",
  act.fct = "logistic", linear.output = TRUE, exclude = NULL,
  constant.weights = NULL, likelihood = FALSE)

           
 * Parameters:

formula: a symbolic description of the model to be fitted.
data: a data frame containing the variables specified in formula.
hidden: a vector of integers specifying the number of hidden neurons (vertices) in each layer.
threshold: a numeric value specifying the threshold for the partial derivatives of the error function as stopping criteria.
stepmax: the maximum steps for the training of the neural network. Reaching this maximum leads to a stop of the neural network's training process.
rep: the number of repetitions for the neural network's training.
startweights: a vector containing starting values for the weights. Set to NULL for random initialization.
learningrate.limit: a vector or a list containing the lowest and highest limit for the learning rate. Used only for RPROP and GRPROP.
learningrate.factor: a vector or a list containing the multiplication factors for the upper and lower learning rate. Used only for RPROP and GRPROP.
learningrate: a numeric value specifying the learning rate used by traditional backpropagation. Used only for traditional backpropagation.
lifesign: a string specifying how much the function will print during the calculation of the neural network. 'none', 'minimal' or 'full'.
lifesign.step: an integer specifying the stepsize to print the minimal threshold in full lifesign 




## LINK TO THEORY
* [Desicion Tree](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Decision-Tree)


