#' Delta Method Asymptotic Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param jcap Numeric matrix.
#'   Jacobian matrix.
#' @param acov Numeric matrix.
#'   Asymptotic covariance matrix.
#' @family Delta Method Functions
#' @keywords deltaMethod acov internal
#' @noRd
.ACovDelta <- function(jcap,
                       acov) {
  return(
    jcap %*% tcrossprod(
      acov,
      jcap
    )
  )
}
