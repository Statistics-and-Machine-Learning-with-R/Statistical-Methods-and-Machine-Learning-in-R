### ARTIFICIAL NEURAL NETWORK
Unsupervised learning is a type of machine learning that looks for previously undetected patterns in a data set with no pre-existing labels and with a minimum of human supervision.
Two of the main methods used in unsupervised learning are principal component and cluster analysis. Cluster analysis is used in unsupervised learning to group, or segment, datasets with shared attributes in order to extrapolate algorithmic relationships.[2] Cluster analysis is a branch of machine learning that groups the data that has not been labelled, classified or categorized. Instead of responding to feedback, cluster analysis identifies commonalities in the data and reacts based on the presence or absence of such commonalities in each new piece of data.
Apart from these methods, we have done **PCoA**, **CCA** and **NMDS** too.
Please see theory for details of each of the method in link given at the end.

#### ABOUT PACKAGE
The main packages for used for this test is "NEURALNET" AND "CARET" Packages. 
 **Usage:**<br/>
 neuralnet(formula, data, hidden = 1, threshold = 0.01,
  stepmax = 1e+05, rep = 1, startweights = NULL,
  learningrate.limit = NULL, learningrate.factor = list(minus = 0.5,
  plus = 1.2), learningrate = NULL, lifesign = "none",
  lifesign.step = 1000, algorithm = "rprop+", err.fct = "sse",
  act.fct = "logistic", linear.output = TRUE, exclude = NULL,
  constant.weights = NULL, likelihood = FALSE)

           
 **Arguments:**<br/>

**formula:** a symbolic description of the model to be fitted. <Br/>
**data:** a data frame containing the variables specified in formula. <Br/>
**hidden:** a vector of integers specifying the number of hidden neurons (vertices) in each layer.<Br/>
**threshold:** a numeric value specifying the threshold for the partial derivatives of the error function as stopping criteria.<Br/>
**stepmax:** the maximum steps for the training of the neural network. Reaching this maximum leads to a stop of the neural network's training process.<Br/>
**rep:** the number of repetitions for the neural network's training.<Br/>
**startweights:** a vector containing starting values for the weights. Set to NULL for random initialization.<Br/>
**learningrate.limit:** a vector or a list containing the lowest and highest limit for the learning rate. Used only for RPROP and GRPROP.<Br/>
**learningrate.factor:** a vector or a list containing the multiplication factors for the upper and lower learning rate. Used only for RPROP and GRPROP. <Br/>
**learningrate:** a numeric value specifying the learning rate used by traditional backpropagation. Used only for traditional backpropagation.<Br/>
**lifesign:** a string specifying how much the function will print during the calculation of the neural network. 'none', 'minimal' or 'full'. <Br/>
**lifesign.step:** an integer specifying the stepsize to print the minimal threshold in full lifesign 


## LINK TO THEORY
* [Artificial-Neural-Network](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Artificial-Neural-Network)

