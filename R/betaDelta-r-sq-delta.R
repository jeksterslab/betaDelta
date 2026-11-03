#' Estimate R-Squared and Adjusted R-Squared and the Corresponding Sampling
#' Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The sampling covariance matrix is obtained by the delta method
#'   from the sampling covariance matrix of the variances and covariances
#'   stored in `object` (normal-theory or asymptotically distribution-free).
#'
#' @return Returns an object of class `esdelta`
#'   which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{fit}{The argument `object`.}
#'     \item{args}{Function arguments.}
#'     \item{vcov}{Sampling covariance matrix of R-squared and adjusted
#'       R-squared.}
#'     \item{est}{Vector of R-squared and adjusted R-squared.}
#'     \item{fun}{Function used ("RSqDelta").}
#'   }
#'
#' @param object Object of class `betadelta`,
#'   that is,
#'   the output of the [BetaDelta()] function.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- RSqDelta(std)
#' # Methods -------------------------------------------------------
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#'
#' @family Beta Delta Functions
#' @keywords betaDelta rsq
#' @export
RSqDelta <- function(object,
                     alpha = c(0.05, 0.01, 0.001)) {
  .CheckDelta(object = object)
  lm_process <- object$lm_process
  jcap <- .JacRSqWRTThetaStar(
    betastar = lm_process$betastar,
    rhocapx = lm_process$rhocap[
      2:lm_process$k,
      2:lm_process$k,
      drop = FALSE
    ]
  )
  .ESDelta(
    object = object,
    jcap = rbind(
      jcap,
      ((lm_process$n - 1) / (lm_process$n - lm_process$k)) * jcap
    ),
    est = lm_process$rsq,
    alpha = alpha,
    fun = "RSqDelta",
    call = match.call()
  )
}
