#' Confidence Intervals for
#' Differences of Standardized Regression Coefficients
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   differences of standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `difbetadelta`.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta diff ci internal
#' @noRd
.DiffBetaCI <- function(object,
                        alpha = NULL) {
  stopifnot(
    inherits(
      object,
      "diffbetadelta"
    )
  )
  if (is.null(alpha)) {
    alpha <- object$args$alpha
  }
  stopifnot(
    all(alpha > 0 & alpha < 1)
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
