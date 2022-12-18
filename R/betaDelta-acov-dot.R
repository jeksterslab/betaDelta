#' Asymptotic Covariance Matrix of the Standardized Parameter Vector
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param jcap Numeric matrix.
#'   Jacobian matrix of the half-vectorization
#'   of the covariance matrix
#'   with respect to the standardized slopes vector.
#' @param gammacap Numeric matrix.
#'   Asymptotic covariance matrix of the sample covariance matrix.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta acov internal
#' @noRd
.ACov <- function(jcap,
                  gammacap) {
  return(
    jcap %*% tcrossprod(gammacap, jcap)
  )
}
