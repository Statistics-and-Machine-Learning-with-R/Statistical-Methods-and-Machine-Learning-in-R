### Unsupervised learning

Unsupervised learning is a type of machine learning that looks for previously undetected patterns in a data set with no pre-existing labels and with a minimum of human supervision.
Two of the main methods used in unsupervised learning are principal component and cluster analysis. Cluster analysis is used in unsupervised learning to group, or segment, datasets with shared attributes in order to extrapolate algorithmic relationships.[2] Cluster analysis is a branch of machine learning that groups the data that has not been labelled, classified or categorized. Instead of responding to feedback, cluster analysis identifies commonalities in the data and reacts based on the presence or absence of such commonalities in each new piece of data.
Apart from these methods, we have done **PCoA**, **CCA** and **NMDS** too.
Please see theory for details of each of the method in link given at the end.

#### ABOUT ORDINATION PACKAGES
The main packages used for these tests are "PCA" , "PCoA" "CCA" and "NMDS" Functions in "factoextra" Package. 
 **Usage:**<br/>
 PCA(X, scale.unit = TRUE, ncp = 5, graph = TRUE)

           
 **Arguments:**<br/>

**X:** a data frame. Rows are individuals and columns are numeric variables<br/>
**scale.unit:** a logical value. If TRUE, the data are scaled to unit variance before the analysis. This standardization to the same scale avoids some variables to become dominant just because of their large measurement units. It makes variable comparable.<br/>
**ncp:** number of dimensions kept in the final results.<br/>
**graph:** a logical value. If TRUE a graph is displayed.<br/>


## LINK TO THEORY
* [Artificial-Neural-Network](https://github.com/Rizvix0/Statistical-Methods-and-Machine-Learning-in-R/wiki/Artificial-Neural-Network)

