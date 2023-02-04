#' Estimate Coefficient of Determination
#' (R-Squared and Adjusted R-Squared)
#' and Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object used to select a method.
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta rsq methods
rsq <- function(object) {
  UseMethod("rsq")
}
