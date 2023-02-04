#' Jacobian Matrix of R-Squared and Adjusted R-Squared
#' with Respect to the Half-Vectorization
#' of the Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector.
#'   Half-vectorization of the covariance matrix of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}^{\prime}}.
#' @param k Positive integer.
#'   `p` regressors plus 1.
#' @param n Positive integer.
#'   Sample size.
#'
#' @return Returns a matrix.
#' @family Derivatives Functions
#' @keywords strRegression derivatives internal
#' @noRd
.JacobianRSqRSqBarWRTVechSigma <- function(x,
                                           k,
                                           n) {
  return(
    numDeriv::jacobian(
      func = .RSqRSqBarofVechSigma,
      x = x,
      k = k,
      n = n
    )
  )
}
