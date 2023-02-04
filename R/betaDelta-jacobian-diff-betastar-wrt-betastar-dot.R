#' Jacobian Matrix of Differences of Standardized Regression Slopes
#' with Respect to the Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector.
#'   Half-vectorization of the covariance matrix of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}^{\prime}}.
#'
#' @return Returns a matrix.
#' @family Beta Delta Functions
#' @keywords betaDelta derivatives internal
#' @noRd
.JacobianDiffBetastar <- function(x) {
  return(
    numDeriv::jacobian(
      func = .DiffBeta,
      x = x
    )
  )
}
