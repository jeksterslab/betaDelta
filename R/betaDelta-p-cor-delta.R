#' Estimate Squared Partial Correlation Coefficients and the Corresponding
#' Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The sampling covariance matrix is obtained by the delta method
#'   from the sampling covariance matrix of the variances and covariances
#'   stored in `object` (normal-theory or asymptotically distribution-free).
#'   Two or more regressors are required.
#'
#' @return Returns an object of class `esdelta`
#'   which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{fit}{The argument `object`.}
#'     \item{args}{Function arguments.}
#'     \item{vcov}{Sampling covariance matrix of squared partial correlation
#'       coefficients.}
#'     \item{est}{Vector of squared partial correlation coefficients.}
#'     \item{fun}{Function used ("PCorDelta").}
#'   }
#'
#' @inheritParams RSqDelta
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- PCorDelta(std)
#' # Methods -------------------------------------------------------
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#'
#' @family Beta Delta Functions
#' @keywords betaDelta pcor
#' @export
PCorDelta <- function(object,
                      alpha = c(0.05, 0.01, 0.001)) {
  .CheckDelta(
    object = object,
    p_min = 2
  )
  lm_process <- object$lm_process
  .ESDelta(
    object = object,
    jcap = .JacPCorSqWRTThetaStar(
      betastar = lm_process$betastar,
      rhocapx = lm_process$rhocap[
        2:lm_process$k,
        2:lm_process$k,
        drop = FALSE
      ]
    ),
    est = lm_process$pcor,
    alpha = alpha,
    fun = "PCorDelta",
    call = match.call()
  )
}
