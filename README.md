# About KUVI

`KUVI` is an R package that helps you share results with collaborators. After performing analysis in R, use `KUVI` to generate HTML pages with interactive visualizations that collaborators can then explore. `KUVI` builds on the [CanvasXpress JavaScript library for Reproducible Research](http://canvasxpress.org/html/index.html). `KUVI` is named after the Mongolian word for "share."

# Example
```
data(mtcars)
mtcars <- scale(mtcars)
mtcars <- t(scale(t(mtcars)))
write(cxHeatmap(mtcars), file="index.html")
```
Check out the results: http://jef.works/kuvi/
