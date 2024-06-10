#' Estimate Standardized Regression Coefficients
#' and the Corresponding Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a a list with the following elements:
#'   \describe{
#'     \item{gamma}{Asymptotic covariance matrix
#'       of the sample covariance matrix.}
#'     \item{acov}{Asymptotic covariance matrix
#'       of the standardized slopes.}
#'     \item{vcov}{Sampling covariance matrix
#'       of the standardized slopes.}
#'     \item{est}{Vector of standardized slopes.}
#'   }
#'
#' @param lm_object object.
#'   Output of the [.ProcessLM()] function.
#' @param type Character string.
#'   If `type = "mvn"`,
#'   use the multivariate normal-theory approach.
#'   If `type = "adf"`,
#'   use the asymptotic distribution-free approach.
#'
#' @references
#' Jones, J. A., & Waller, N. G. (2015).
#' The normal-theory and asymptotic distribution-free (ADF) covariance matrix
#' of standardized regression coefficients:
#' Theoretical extensions and finite sample behavior.
#' *Psychometrika*, *80*(2), 365–378.
#' \doi{10.1007/s11336-013-9380-y}
#'
#' Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023).
#' betaDelta and betaSandwich:
#' Confidence intervals for standardized regression coefficients in R.
#' *Multivariate Behavioral Research*.
#' \doi{10.1080/00273171.2023.2201277}
#'
#' Yuan, K.-H., & Chan, W. (2011).
#' Biases and standard errors of standardized regression coefficients.
#' *Psychometrika*, *76*(4), 670–690.
#' \doi{10.1007/s11336-011-9224-6}
#'
#' @family Beta Delta Functions
#' @keywords betaDelta std internal
#' @noRd
.BetaDelta <- function(lm_process,
                       type) {
  gamma <- .Gamma(
    object = lm_process,
    type = type
  )
  acov <- .ACovDelta(
    jcap = .JacobianBetaStarWRTVechSigma(
      beta = lm_process$beta,
      sigmay = sqrt(lm_process$sigmacap[1, 1]),
      sigmax = sqrt(diag(lm_process$sigmacap)[-1]),
      invsigmacapx = chol2inv(
        chol(
          lm_process$sigmacap[
            2:lm_process$k,
            2:lm_process$k,
            drop = FALSE
          ]
        )
      ),
      p = lm_process$p,
      k = lm_process$k
    ),
    acov = gamma
  )
  colnames(acov) <- rownames(acov) <- lm_process$xnames
  vcov <- (1 / lm_process$n) * acov
  return(
    list(
      gamma = gamma,
      acov = acov,
      vcov = vcov,
      est = lm_process$betastar
    )
  )
}
