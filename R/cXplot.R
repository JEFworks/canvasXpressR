# Functions to create interactive plots

#' Writes HTML page with an interactive heatmap for input matrix
#'
#' @param mat Matrix
#'
#' @examples
#' data(mtcars)
#' mtcars <- scale(mtcars)
#' mtcars <- t(scale(t(mtcars)))
#' write(cXheatmap(mtcars), file="heatmap.html")
#'
#' @export
#'
cXheatmap <- function(mat) {
dataString <- writeDataString(mat)
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

#' Writes HTML page with interactive boxplots for each row of an input matrix
#'
#' @param mat Matrix
#'
#' @examples
#' data(mtcars)
#' write(cXboxplot(t(mtcars[, c("mpg", "hp", "wt")]), mtcars$cyl), file="boxplot.html")
#'
#' @export
#'
cXboxplot <- function(mat, groups) {
  dataString <- writeDataString(mat)
  groupsString <- paste0("{ 'groups' : [", paste0(paste0('"', groups, '"'), collapse=", "), "] }")
  paste0('<html>
         <head>
         <link rel="stylesheet" href="http://www.canvasxpress.org/css/canvasXpress.css" type="text/css"/>
         <script type="text/javascript" src="http://www.canvasxpress.org/js/canvasXpress.min.js"></script>
         <script>
         var initPage = function () {
         var cX = new CanvasXpress("canvasId",
         {
         "x" :',
         groupsString,
         ', "y" :',
         dataString,
         '}, {"graphOrientation": "vertical",
         "graphType": "Boxplot",
         "legendBox": false,
         "smpLabelRotate": 90,
         "xAxis2Show": false
         }
         );
         cX.groupSamples(["groups"]);
         }
         </script>
         </head>
         <body onload="initPage();">
         <canvas id="canvasId" width="540" height="540"></canvas>
         </body>
         </html>
         ', collapse="")
}
