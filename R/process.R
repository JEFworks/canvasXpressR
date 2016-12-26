# Functions to output data

#' Converts matrix to Javascript array data structure
#'
#' @param mat Matrix
#'
#' @examples
#' data(mtcars)
#' writeDataString(head(mtcars))
#'
#' @export
#'
writeDataString <- function(mat) {
  smps = paste0("[", paste0(paste0('"', colnames(mat),'"'), collapse=", "), "]")
  vars = paste0("[", paste0(paste0('"', rownames(mat),'"'), collapse=", "), "]")
  data = paste0("[", paste0(apply(mat, 1, function(x) {
    paste0("[", paste0(x, collapse=", "), "]")
  }), collapse=", "), "]")
  dataString = paste0("{ 'smps':", smps, ", 'vars':", vars, ", 'data':", data, "}", collapse="")
  return(dataString)
}
