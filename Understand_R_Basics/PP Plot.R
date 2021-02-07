#--------------------------------------------------
"PP-plot"
#--------------------------------------------------
if(!require("qualityTools")) install.packages("qualityTools")       #package for PP-plots
library(qualityTools)

#Set up the plotting window for plots with specific margins
par(mar=c(4,4,2,1)) 

#Probability Plot:
ppPlot(p, "normal")         #'p' contains p values resulting from test your are performing