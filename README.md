# About KUVI

`KUVI` is an R package that helps you share results with collaborators. After performing analysis in R, use `KUVI` to generate HTML pages with interactive visualizations that collaborators can then explore. `KUVI` builds on the [CanvasXpress JavaScript library for Reproducible Research](http://canvasxpress.org/html/index.html). `KUVI` is named after the Mongolian word for "share."

# Install

```
require(devtools)
devtools::install_github("jefworks/KUVI")
```

# Usage Example
```
## Process Data
data(mtcars)
mtcars <- scale(mtcars)
mtcars <- t(scale(t(mtcars)))

## Write an HTML file with an interactive heatmap visualization of the data
write(cXheatmap(mtcars), file="heatmap.html")

## Now just send the HTML file to your collaborators!
```

Check out the results: http://jef.works/kuvi/
