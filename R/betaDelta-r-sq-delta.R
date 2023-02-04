#' Estimate Coefficient of Determination
#' (R-Squared and Adjusted R-Squared)
#' and Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object of class `rsqbetadelta`
#' which is a list with the following elements:
#' \describe{
#'   \item{betadelta}{Object of class `betadelta`.}
#'   \item{est}{R-squared (\eqn{R^{2}}) and
#'     adjusted R-squared (\eqn{\bar{R}^{2}}).}
#'   \item{vcov}{Sampling covariance matrix of R-squared (\eqn{R^{2}}) and
#'     adjusted R-squared (\eqn{\bar{R}^{2}}).}
#'   \item{acov}{Asymptotic covariance matrix of R-squared (\eqn{R^{2}}) and
#'     adjusted R-squared (\eqn{\bar{R}^{2}}).}
#' }
#' @param object Object of class `betadelta`.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' # Methods -------------------------------------------------------
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#' @method rsq betadelta
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta rsq methods
rsq.betadelta <- function(object) {
  varnames <- c("R-squared", "Adjusted")
  est <- .RSqRSqBarofVechSigma(
    vechsigmacap = object$lm_process$vechsigmacap,
    k = object$lm_process$k,
    n = object$lm_process$n
  )
  names(est) <- varnames
  acov <- .ACov(
    jcap = .JacobianRSqRSqBarWRTVechSigma(
      x = object$lm_process$vechsigmacap,
      k = object$lm_process$k,
      n = object$lm_process$n
    ),
    gammacap = object$gamma
  )
  colnames(acov) <- rownames(acov) <- varnames
  vcov <- (1 / object$lm_process$n) * acov
  out <- list(
    betadelta = object,
    est = est,
    vcov = vcov,
    acov = acov
  )
  class(out) <- c(
    "rsqbetadelta",
    class(out)
  )
  return(
    out
  )
}
