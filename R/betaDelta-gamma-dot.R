#' Asymptotic Covariance Matrix of the Sample Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix.
#'
#' @param x Object.
#'   Result of `.ProcessLM()`.
#' @param type Character string.
#'   If `type = "mvn"`, use the multivariate normal-theory approach.
#'   If `type = "adf"`, use the asymptotic distribution-free approach.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta gamma internal
#' @noRd
.Gamma <- function(x,
                   type) {
  if (type == "adf") {
    gammacapmvn_consistent <- .GammaN(
      sigmacap = x$sigmacap_consistent,
      pinv_of_dcap = x$pinv_of_dcap
    )
    gammacap <- .GammaADFUnbiased(
      gammacapadf_consistent = .GammaADFConsistent(
        d = .DofMat(
          x$x,
          center = colMeans(x$x),
          n = x$n,
          k = x$k
        ),
        vechsigmacap_consistent = x$vechsigmacap_consistent,
        n = x$n
      ),
      gammacapmvn_consistent = gammacapmvn_consistent,
      vechsigmacap_consistent = x$vechsigmacap_consistent,
      n = x$n
    )
  }
  if (type == "mvn") {
    gammacap <- .GammaN(
      sigmacap = x$sigmacap,
      pinv_of_dcap = x$pinv_of_dcap
    )
  }
  return(gammacap)
}
