#' Confidence Intervals for Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix.
#'
#' @param object Object of class `difbetadelta`.
#' @param alpha Numeric vector.
#'   Significance level.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta dif ci internal
#' @noRd
.DiffBetaCI <- function(object,
                        alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    methods::is(
      object,
      "difbetadelta"
    )
  )
  return(
    .CIWald(
      object$est,
      se = sqrt(diag(object$vcov)),
      theta = 0,
      alpha = alpha,
      z = TRUE
    )
  )
}