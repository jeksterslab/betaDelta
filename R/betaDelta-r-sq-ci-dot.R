#' Confidence Intervals for R-Squared and Adjusted R-Squared
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix.
#'
#' @param object Object of class `rsqrdelta`.
#' @param alpha Numeric vector.
#'   Significance level.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta rsq ci internal
#' @noRd
.RSqCI <- function(object,
                   alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    methods::is(
      object,
      "rsqbetadelta"
    )
  )
  return(
    .CIWald(
      object$est,
      se = sqrt(diag(object$vcov)),
      theta = 0,
      alpha = alpha,
      z = FALSE,
      df = object$betadelta$lm_process$df
    )
  )
}
