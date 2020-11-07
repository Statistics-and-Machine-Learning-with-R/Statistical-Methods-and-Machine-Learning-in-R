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

formula: a symbolic description of the model to be fitted. <Br/>
data: a data frame containing the variables specified in formula. <Br/>
hidden: a vector of integers specifying the number of hidden neurons (vertices) in each layer.<Br/>
threshold: a numeric value specifying the threshold for the partial derivatives of the error function as stopping criteria.<Br/>
stepmax: the maximum steps for the training of the neural network. Reaching this maximum leads to a stop of the neural network's training process.<Br/>
rep: the number of repetitions for the neural network's training.<Br/>
startweights: a vector containing starting values for the weights. Set to NULL for random initialization.<Br/>
learningrate.limit: a vector or a list containing the lowest and highest limit for the learning rate. Used only for RPROP and GRPROP.<Br/>
learningrate.factor: a vector or a list containing the multiplication factors for the upper and lower learning rate. Used only for RPROP and GRPROP. <Br/>
learningrate: a numeric value specifying the learning rate used by traditional backpropagation. Used only for traditional backpropagation.<Br/>
lifesign: a string specifying how much the function will print during the calculation of the neural network. 'none', 'minimal' or 'full'. <Br/>
lifesign.step: an integer specifying the stepsize to print the minimal threshold in full lifesign 


## LINK TO THEORY
* [Artificial-Neural-Network](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Artificial-Neural-Network)

