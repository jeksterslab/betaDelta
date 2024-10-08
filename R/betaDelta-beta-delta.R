#' Estimate Standardized Regression Coefficients
#' and the Corresponding Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object
#'   of class `betadelta` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{lm_process}{Processed `lm` object.}
#'     \item{gamma}{Asymptotic covariance matrix
#'       of the sample covariance matrix.}
#'     \item{acov}{Asymptotic covariance matrix
#'       of the standardized slopes.}
#'     \item{vcov}{Sampling covariance matrix
#'       of the standardized slopes.}
#'     \item{est}{Vector of standardized slopes.}
#'   }
#'
#' @param object Object of class `lm`.
#' @param type Character string.
#'   If `type = "mvn"`,
#'   use the multivariate normal-theory approach.
#'   If `type = "adf"`,
#'   use the asymptotic distribution-free approach.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
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
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' # Methods -------------------------------------------------------
#' print(std)
#' summary(std)
#' coef(std)
#' vcov(std)
#' confint(std, level = 0.95)
#'
#' @family Beta Delta Functions
#' @keywords betaDelta std
#' @export
BetaDelta <- function(object,
                      type = "mvn",
                      alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      x = object,
      what = "lm"
    )
  )
  stopifnot(
    type %in% c(
      "mvn",
      "adf"
    )
  )
  lm_process <- .ProcessLM(object)
  std <- .BetaDelta(
    lm_process = lm_process,
    type = type
  )
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      type = type,
      alpha = alpha
    ),
    lm_process = lm_process,
    gamma = std$gamma,
    acov = std$acov,
    vcov = std$vcov,
    est = lm_process$betastar
  )
  attributes(out)$mi <- FALSE
  class(out) <- c(
    "betadelta",
    class(out)
  )
  return(
    out
  )
}
