#' R-Squared as a Function
#' of the Half-Vectorization
#' of the Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param vechsigmacap Numeric vector.
#'   Half-vectorization of the covariance matrix of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}^{\prime}}.
#' @param k Positive integer.
#'   `p` regressors plus 1.
#'
#' @family R-squared Functions
#' @keywords strRegression rsq dot
#' @noRd
.RSqofVechSigma <- function(vechsigmacap,
                            k) {
  return(
    .RSqofSigma(
      sigmacap = .SymofVech(
        x = vechsigmacap,
        k = k
      ),
      k = k
    )
  )
}
