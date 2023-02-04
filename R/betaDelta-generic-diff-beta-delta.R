#' Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object used to select a method.
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta dif methods
dif <- function(object) {
  UseMethod("dif")
}
