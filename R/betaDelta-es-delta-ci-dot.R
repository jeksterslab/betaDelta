#' Confidence Intervals for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `esdelta`.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `object`.
#' @return Returns a matrix of estimates, standard errors,
#'   test statistics, p-values, and confidence intervals.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta ci internal
#' @noRd
.ESDeltaCI <- function(object,
                       alpha = NULL) {
  if (is.null(alpha)) {
    alpha <- object$args$alpha
  }
  stopifnot(
    all(alpha > 0 & alpha < 1)
  )
  .CIWald(
    est = object$est,
    se = sqrt(diag(object$vcov)),
    theta = 0,
    alpha = alpha,
    z = TRUE
  )
}
