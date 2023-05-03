#' Asymptotic Covariance Matrix of the
#' Sample Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix.
#'
#' @param object Object.
#'   Result of [.ProcessLM()].
#' @param type Character string.
#'   If `type = "mvn"`, use the multivariate normal-theory approach.
#'   If `type = "adf"`, use the asymptotic distribution-free approach.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta gamma internal
#' @noRd
.Gamma <- function(object,
                   type) {
  if (type == "adf") {
    gammacapmvn_consistent <- .GammaN(
      sigmacap = object$sigmacap_consistent,
      pinv_of_dcap = object$pinv_of_dcap
    )
    gammacap <- .GammaADFUnbiased(
      gammacapadf_consistent = .GammaADFConsistent(
        d = .DofMat(
          object$x,
          center = colMeans(object$x),
          n = object$n,
          k = object$k
        ),
        vechsigmacap_consistent = object$vechsigmacap_consistent,
        n = object$n
      ),
      gammacapmvn_consistent = gammacapmvn_consistent,
      vechsigmacap_consistent = object$vechsigmacap_consistent,
      n = object$n
    )
  }
  if (type == "mvn") {
    gammacap <- .GammaN(
      sigmacap = object$sigmacap,
      pinv_of_dcap = object$pinv_of_dcap
    )
  }
  return(gammacap)
}
