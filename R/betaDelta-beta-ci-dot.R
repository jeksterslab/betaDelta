#' Confidence Intervals for
#' Standardized Regression Coefficients
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `betadelta`.
#' @param alpha Numeric vector.
#'   Significance level.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta ci internal
#' @noRd
.BetaCI <- function(object,
                    alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      object,
      "betadelta"
    )
  )
  return(
    .CIWald(
      object$est,
      se = sqrt(diag(object$vcov)),
      theta = 0,
      alpha = alpha,
      z = FALSE,
      df = object$lm_process$df
    )
  )
}
