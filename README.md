# canvasXpressR
an R package to help you share results with collaborators using canvasXpress


## About 
***canvasXpress*** was developed as the core visualization component for bioinformatics and systems biology analysis at Bristol-Myers Squibb. It supports a large number of [visualizations ](http://www.canvasxpress.org/html/gallery.html)to display scientific and non-scientific
data. ***canvasXpress*** also includes a simple and unobtrusive [user interface](http://www.canvasxpress.org/html/user-interface.html) to explore complex data sets, a sofisticated and unique mechanism to keep track of all user customization for [Reproducible Research ](http://www.canvasxpress.org/html/reproducible-research.html) purposes, as well as an 'out of the box'
broadcasting capability to synchronize selected data points in all ***canvasXpress*** plots in a page. Data can
be easily sorted, grouped, transposed, transformed or clustered dynamically. The fully customizable mouse events
as well as the zooming, panning and drag'n drop capabilities are features that make this library unique in its
class.

***canvasXpressR*** lets you create HTML pages with interactive visualizations and portable results using ***canvasXpress***. HTML pages can then be easily shared with collaborators to allow them to interactively browse the data and make their own visualizations. ***canvasXpressR*** is forked from the [canvasXpress R Library](https://github.com/neuhausi/canvasXpress), which allows you to make ***canvasXpress*** objects in R-studio or seamlessly embeded in [Shiny](http://shiny.rstudio.com) web applications.


## Install

```
require(devtools)
devtools::install_github('jefworks/canvasXpressR')
```


## Sharing sample single cell analysis with canvasXpressR

```{r}
library(canvasXpressR)

## Load rt-qpcr data from Guo et al.
data(mat)
```

### Scatterplot

First, we will perform principal component analysis with k-means clustering and visualize the first and second PCs with a scatterplot.

```{r}
## Principal components analysis with K means clustering
set.seed(0)
basePca <- prcomp(mat)
data <- basePca$x[,1:2]
sg <- kmeans(data, centers=3)$cluster
sg[sg==1] <- 'TE'; sg[sg==2] <- 'PE'; sg[sg==3] <- 'EPI';
names(sg) <- rownames(data)
varAnnot <- data.frame(sg)
colnames(varAnnot) <- 'Cell Type'
cx <- canvasXpress(data, varAnnot=varAnnot, graphType='Scatter2D', colorBy='Cell Type')
write(canvasXpressHTML(cx), "pca.html")
```

We can now share the [pca.html](http://jef.works/canvasXpressR/pca.html) page directly to our collaborators for them to explore further. Note that all data are contained within this HTML page so you do not need to worry about uploading the data somewhere. Just open the HTML page and click to explore!

### Heatmap

Next, we will plot a heatmap with cells as rows and genes as columns. We will keep the cell type groups we found from the PCA and visualize them as row side colors.

```{r}
## Expression heatmap
cmat <- t(mat)
cx <- canvasXpress(cmat, smpAnnot=varAnnot, graphType='Heatmap',
                   smpOverlays=list('Cell Type'),
                   colorSpectrum=list("blue", "white", "red"),
                   heatmapIndicatorHeight=50,
                   heatmapIndicatorHistogram=TRUE,
                   heatmapIndicatorPosition='topLeft',
                   heatmapIndicatorWidth=60,
                   samplesClustered=TRUE,
                   variablesClustered=TRUE,
                   showSampleNames=FALSE)
write(canvasXpressHTML(cx), "heatmap.html")
```

We can now share the [heatmap.html](http://jef.works/canvasXpressR/heatmap.html) page directly to our collaborators for them to explore further. This is most helpful for collaborators to pick and choose which genes they want included in the final heatmap.

### Boxplots

Now (my favorite utility), we will plot boxplots of each gene for each cell type.

```{r}
## Boxplots
cx <- canvasXpress(t(mat), smpAnnot=varAnnot,
                   graphType='Boxplot',
                   groupingFactors=list('Cell Type'),
                   graphOrientation="vertical")
write(canvasXpressHTML(cx, width=1200), "boxplot.html")
```

We can now share the [boxplot.html](http://jef.works/canvasXpressR/boxplot.html) page directly to our collaborators for them to explore further. Collaborators can interactively explore and visualize individual genes.

### Trajectories

For networks and pseudo-time trajectories, we can plot a tree structure.

```{r}
## Trajectories / Trees
library(igraph)
dis <- dist(mat[1:50,]) ## small tree
g  <- graph.adjacency(as.matrix(dis), weighted=TRUE)
gmst <- mst(g) ## igraph object
nodeData <- lapply(names(V(gmst)), function(x) list(name=x, id=x, group=sg[x]))
edgeData <- apply(get.edgelist(gmst), 1, function(x) list(id1=x[1], id2=x[2]))
cx <- canvasXpress(nodeData=nodeData,
                   edgeData=edgeData,
                   graphType="Network",
                   colorNodeBy="group",
                   nodeSize=30,
                   showAnimation=TRUE)
write(canvasXpressHTML(cx), "graph.html")
```

We can now share the [graph.html](http://jef.works/canvasXpressR/graph.html) page directly to our collaborators for them to explore further.
	
# Happy sharing!

