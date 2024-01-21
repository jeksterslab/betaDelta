#' Confidence Intervals for
#' Deltma Method
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   estimates,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `deltamethod`.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'
#' @family Delta Method Functions
#' @keywords deltaMethod ci internal
#' @noRd
.DeltaCI <- function(object,
                     alpha) {
  stopifnot(
    inherits(
      object,
      "deltamethod"
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
      est = object$est,
      se = sqrt(diag(object$vcov)),
      theta = object$args$theta,
      alpha = alpha,
      z = object$args$z,
      df = object$args$df
    )
  )
}
