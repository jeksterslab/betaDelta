#' R-Squared and Adjusted R-Squared
#' as a Function of the Half-Vectorization
#' of the Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param vechsigmacap Numeric vector.
#'   Half-vectorization of the covariance matrix of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}^{\prime}}.
#' @param k Positive integer.
#'   `p` regressors plus 1.
#' @param n Positive integer.
#'   Sample size.
#'
#' @family R-squared Functions
#' @keywords strRegression rsq dot
#' @noRd
.RSqRSqBarofVechSigma <- function(vechsigmacap,
                                  k,
                                  n) {
  rsq <- .RSqofVechSigma(
    vechsigmacap = vechsigmacap,
    k = k
  )
  return(
    c(
      rsq,
      1 - (1 - rsq) * ((n - 1) / (n - k))
    )
  )
}
