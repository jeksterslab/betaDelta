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
#'   Significance level.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta diff ci internal
#' @noRd
.DiffBetaCI <- function(object,
                        alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    methods::is(
      object,
      "diffbetadelta"
    )
  )
  return(
    .CIWald(
      object$est,
      se = sqrt(diag(object$vcov)),
      theta = 0,
      alpha = alpha,
      z = FALSE,
      df = object$fit$lm_process$df
    )
  )
}
