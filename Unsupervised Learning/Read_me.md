## Unsupervised learning

Unsupervised learning is a type of machine learning that looks for previously undetected patterns in a data set with no pre-existing labels and with a minimum of human supervision.
Two of the main methods used in unsupervised learning are principal component and cluster analysis. Cluster analysis is used in unsupervised learning to group, or segment, datasets with shared attributes in order to extrapolate algorithmic relationships.[2] Cluster analysis is a branch of machine learning that groups the data that has not been labelled, classified or categorized. Instead of responding to feedback, cluster analysis identifies commonalities in the data and reacts based on the presence or absence of such commonalities in each new piece of data.
Apart from these methods, we have done **PCoA**, **RDA** and **NMDS** too.
Please see theory for details of each of the method in link given at the end.

### ABOUT ORDINATION PACKAGES

The main packages used for these tests are "PCA" , "PCoA" "RDA" and "NMDS" Functions in "factoextra" Package. 
 
 
 ### PCA
 
 **Usage:**<br/>
 PCA(X, scale.unit = TRUE, ncp = 5, graph = TRUE)

 **Arguments:**<br/>

**X:** a data frame. Rows are individuals and columns are numeric variables<br/>
**scale.unit:** a logical value. If TRUE, the data are scaled to unit variance before the analysis. This standardization to the same scale avoids some variables to become dominant just because of their large measurement units. It makes variable comparable.<br/>
**ncp:** number of dimensions kept in the final results.<br/>
**graph:** a logical value. If TRUE a graph is displayed.<br/>


### RDA

**Usage:**<br/>
rda(X, Y, scaling = 1)


 **Arguments:**<br/>
 
 **X:** matrix of x variables

**Y:**  matrix of y variables

**scaling:** caling used for x and y variables. 0: x and y only centered. 1: x and y standardized


### PCoA

**Usage:**<br/>
pcoa(D, correction="none", rn=NULL)


 **Arguments:**<br/>

**D:** A distance matrix of class dist or matrix.<br/>
**correction:** Correction methods for negative eigenvalues (details below): "lingoes" and "cailliez". Default value: "none" . <br/>



### ABOUT CLUSTERING PACKAGES

**NbClust Package** is for determining the best number of clusters. NbClust package provides 30 indices for determining the number of clusters and proposes to user the best clustering scheme from the different results obtained by varying all combinations of number of clusters, distance measures, and clustering methods.
**eclust Package** is for providing solution for enhancing the workflow of clustering analyses and ggplot2-based elegant data visualization


### NBClust


**Usage:**<br/>
NbClust(data = NULL, diss = NULL, distance = "euclidean", min.nc = 2, max.nc = 15, 
method = NULL, index = "all", alphaBeale = 0.1)

 **Arguments:**<br/>

**data:** matrix or dataset.<br/>
**diss:** dissimilarity matrix to be used. By default, diss=NULL, but if it is replaced by a dissimilarity matrix, distance should be "NULL".<br/>
**distance:** the distance measure to be used to compute the dissimilarity matrix. This must be one of: "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski" or "NULL". By default, distance="euclidean". If the distance is "NULL", the dissimilarity matrix (diss) should be given by the user. If distance is not "NULL", the dissimilarity matrix should be "NULL".<br/>
**min.nc:** minimal number of clusters, between 1 and (number of objects - 1).<br/>
**max.nc:** maximal number of clusters, between 2 and (number of objects - 1), greater or equal to min.nc. By default, max.nc=15.<br/>
**method:** the cluster analysis method to be used. This should be one of: "ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", "centroid", "kmeans".<br/>
**index:** the index to be calculated. This should be one of : "kl", "ch", "hartigan", "ccc", "scott", "marriot", "trcovw", "tracew", "friedman", "rubin", "cindex", "db", "silhouette", "duda", "pseudot2", "beale", "ratkowsky", "ball", "ptbiserial", "gap", "frey", "mcclain", "gamma", "gplus", "tau", "dunn", "hubert", "sdindex", "dindex", "sdbw", "all" (all indices except GAP, Gamma, Gplus and Tau), "alllong" (all indices with Gap, Gamma, Gplus and Tau included).<br/>
**alphaBeale:** significance value for Beale's index. . <br/>


### eclust


**Usage:**<br/>
eclust(x, FUNcluster = c("kmeans", "pam", "clara", "fanny", "hclust", "agnes",
  "diana"), k = NULL, k.max = 10, stand = FALSE, graph = TRUE,
  hc_metric = "euclidean", hc_method = "ward.D2", gap_maxSE = list(method
  = "firstSEmax", SE.factor = 1), nboot = 100, verbose = interactive(),
  seed = 123, ...)

**Arguments:**<br/>

x
numeric vector, data matrix or data frame

FUNcluster
a clustering function including "kmeans", "pam", "clara", "fanny", "hclust", "agnes" and "diana". Abbreviation is allowed.

k
the number of clusters to be generated. If NULL, the gap statistic is used to estimate the appropriate number of clusters. In the case of kmeans, k can be either the number of clusters, or a set of initial (distinct) cluster centers.

k.max
the maximum number of clusters to consider, must be at least two.

stand
logical value; default is FALSE. If TRUE, then the data will be standardized using the function scale(). Measurements are standardized for each variable (column), by subtracting the variable's mean value and dividing by the variable's standard deviation.

graph
logical value. If TRUE, cluster plot is displayed.

hc_metric
character string specifying the metric to be used for calculating dissimilarities between observations. Allowed values are those accepted by the function dist() [including "euclidean", "manhattan", "maximum", "canberra", "binary", "minkowski"] and correlation based distance measures ["pearson", "spearman" or "kendall"]. Used only when FUNcluster is a hierarchical clustering function such as one of "hclust", "agnes" or "diana".

hc_method
the agglomeration method to be used (?hclust): "ward.D", "ward.D2", "single", "complete", "average", ...

gap_maxSE
a list containing the parameters (method and SE.factor) for determining the location of the maximum of the gap statistic (Read the documentation ?cluster::maxSE).

nboot
integer, number of Monte Carlo ("bootstrap") samples. Used only for determining the number of clusters using gap statistic.

verbose
logical value. If TRUE, the result of progress is printed.

seed
integer used for seeding the random number generator.

...
other arguments to be passed to FUNcluster.
## LINK TO THEORY
* [Unsupervised-Learning](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Unsupervised-Learning)

