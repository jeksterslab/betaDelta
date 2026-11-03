#' Estimate Semipartial Correlation Coefficients and the Corresponding Sampling
#' Covariance Matrix
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
#'     \item{vcov}{Sampling covariance matrix of semipartial correlation
#'       coefficients.}
#'     \item{est}{Vector of semipartial correlation coefficients.}
#'     \item{fun}{Function used ("SCorDelta").}
#'   }
#'
#' @inheritParams RSqDelta
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- SCorDelta(std)
#' # Methods -------------------------------------------------------
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#'
#' @family Beta Delta Functions
#' @keywords betaDelta scor
#' @export
SCorDelta <- function(object,
                      alpha = c(0.05, 0.01, 0.001)) {
  .CheckDelta(
    object = object,
    p_min = 2
  )
  lm_process <- object$lm_process
  .ESDelta(
    object = object,
    jcap = .JacSCorWRTThetaStar(
      betastar = lm_process$betastar,
      rhocapx = lm_process$rhocap[
        2:lm_process$k,
        2:lm_process$k,
        drop = FALSE
      ]
    ),
    est = lm_process$scor,
    alpha = alpha,
    fun = "SCorDelta",
    call = match.call()
  )
}
