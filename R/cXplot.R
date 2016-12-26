# Functions to create interactive plots

#' Writes HTML page for an interactive heatmap for input matrix
#'
#' @param mat Matrix
#'
#' @examples
#' data(mtcars)
#' mtcars <- scale(mtcars)
#' mtcars <- t(scale(t(mtcars)))
#' write(cxHeatmap(mtcars), file="index.html")
#'
#' @export
#'
cXheatmap <- function(mat) {
dataString <- writeDataString(mtcars)
paste0('<html>
    <head>
<link rel="stylesheet" href="http://www.canvasxpress.org/css/canvasXpress.css" type="text/css"/>
<script type="text/javascript" src="http://www.canvasxpress.org/js/canvasXpress.min.js"></script>
<script>
var initPage = function () {
var cX = new CanvasXpress("canvasId",
{
"y" :',
  dataString,
'}, {"colorSpectrum": ["blue", "white", "red"],
"graphType": "Heatmap",
"heatmapIndicatorHeight": 50,
"heatmapIndicatorHistogram": true,
"heatmapIndicatorPosition": "topLeft",
"heatmapIndicatorWidth": 60,
"samplesClustered": true,
"variablesClustered": true
}
);
}
</script>
</head>
<body onload="initPage();">
<canvas id="canvasId" width="540" height="540"></canvas>
</body>
</html>
', collapse="")
}
