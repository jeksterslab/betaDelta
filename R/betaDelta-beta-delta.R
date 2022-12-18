#' Estimate Standardized Regression Coefficients
#' and Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object of class `betadelta`
#' which is a list with the following elements:
#' \describe{
#'   \item{call}{Function call.}
#'   \item{type}{Standard error type.}
#'   \item{beta}{Vector of standardized slopes.}
#'   \item{vcov}{Sampling covariance matrix of the standardized slopes.}
#'   \item{n}{Sample size.}
#'   \item{p}{Number of regressors.}
#'   \item{df}{\eqn{n - p - 1} degrees of freedom}
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
#' # Methods -------------------------------------------------------
#' print(std)
#' summary(std)
#' coef(std)
#' vcov(std)
#' confint(std, level = 0.95)
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta
BetaDelta <- function(object, type = "mvn") {
  stopifnot(type %in% c("mvn", "adf"))
  input <- .ProcessLM(object)
  jcap <- .JacobianBetastarWRTVechSigma(
    beta = input$beta,
    sigmay = sqrt(input$sigmacap[1, 1]),
    sigmax = sqrt(diag(input$sigmacap)[-1]),
    invsigmacapx = chol2inv(
      chol(input$sigmacap[2:input$k, 2:input$k, drop = FALSE])
    ),
    p = input$p,
    k = input$k
  )
  sigmacap_consistent <- (
    input$sigmacap * (
      input$n - 1
    ) / input$n
  )
  vechsigmacap_consistent <- .Vech(
    sigmacap_consistent
  )
  pinv_of_dcap <- .PInvDmat(.DMat(input$k))
  if (type == "adf") {
    gammacapmvn_consistent <- .GammaN(
      sigmacap = sigmacap_consistent,
      pinv_of_dcap = pinv_of_dcap
    )
    gammacap <- .GammaADFUnbiased(
      gammacapadf_consistent = .GammaADFConsistent(
        d = .DofMat(
          input$x,
          center = colMeans(input$x),
          n = input$n,
          k = input$k
        ),
        vechsigmacap_consistent = vechsigmacap_consistent,
        n = input$n
      ),
      gammacapmvn_consistent = gammacapmvn_consistent,
      vechsigmacap_consistent = vechsigmacap_consistent,
      n = input$n
    )
  }
  if (type == "mvn") {
    gammacap <- .GammaN(
      sigmacap = input$sigmacap,
      pinv_of_dcap = pinv_of_dcap
    )
  }
  avcov <- .ACov(
    jcap = jcap,
    gammacap = gammacap
  )
  vcov <- (1 / input$n) * avcov
  colnames(vcov) <- rownames(vcov) <- input$xnames
  out <- list(
    call = match.call(),
    type = type,
    beta = input$betastar,
    vcov = vcov,
    n = input$n,
    p = input$p,
    df = input$df
  )
  class(out) <- c(
    "betadelta",
    class(out)
  )
  return(
    out
  )
}
