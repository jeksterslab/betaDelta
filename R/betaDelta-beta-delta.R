#' Estimate Standardized Regression Coefficients
#' and Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object of class `betadelta`
#' which is a list with the following elements:
#' \describe{
#'   \item{call}{Function call.}
#'   \item{lm}{Object of class `lm`.}
#'   \item{lm_process}{Pre-processed object of class `lm`.}
#'   \item{type}{Standard error type.}
#'   \item{gamma}{Asymptotic covariance matrix of the sample covariance matrix.}
#'   \item{acov}{Asymptotic covariance matrix of the standardized slopes.}
#'   \item{vcov}{Sampling covariance matrix of the standardized slopes.}
#'   \item{est}{Vector of standardized slopes.}
#' }
#' @param object Object of class `lm`.
#' @param type Character string.
#'   If `type = "mvn"`, use the multivariate normal-theory approach.
#'   If `type = "adf"`, use the asymptotic distribution-free approach.
#' @references
#' Jones, J. A., & Waller, N. G. (2015).
#' The normal-theory and asymptotic distribution-free (ADF) covariance matrix
#' of standardized regression coefficients:
#' Theoretical extensions and finite sample behavior.
#' *Psychometrika*, *80*(2), 365–378.
#' \doi{10.1007/s11336-013-9380-y}
#'
#' Yuan, K.-H., & Chan, W. (2011).
#' Biases and standard errors of standardized regression coefficients.
#' *Psychometrika*, *76*(4), 670–690.
#' \doi{10.1007/s11336-011-9224-6}
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' # Methods ----------------------------------------------------
#' print(std)
#' summary(std)
#' coef(std)
#' vcov(std)
#' confint(std, level = 0.95)
#' ## Differences of standardized regression coefficients -------
#' out <- dif(std)
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta
BetaDelta <- function(object,
                      type = "mvn") {
  stopifnot(
    type %in% c(
      "mvn",
      "adf"
    )
  )
  lm_process <- .ProcessLM(object)
  gamma <- .Gamma(
    x = lm_process,
    type = type
  )
  acov <- .ACov(
    jcap = .JacobianBetastarWRTVechSigma(
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
    gammacap = gamma
  )
  colnames(acov) <- rownames(acov) <- lm_process$xnames
  vcov <- (1 / lm_process$n) * acov
  out <- list(
    call = match.call(),
    lm = object,
    lm_process = lm_process,
    type = type,
    gamma = gamma,
    acov = acov,
    vcov = vcov,
    est = lm_process$betastar
  )
  class(out) <- c(
    "betadelta",
    class(out)
  )
  return(
    out
  )
}
