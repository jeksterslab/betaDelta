#' Estimate Differences of Standardized Slopes
#' and the Corresponding Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object
#'   of class `diffbetadelta` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{fit}{The argument `object`.}
#'     \item{args}{Function arguments.}
#'     \item{vcov}{Sampling covariance matrix of
#'       differences of standardized slopes.}
#'     \item{est}{Vector of
#'       differences of standardized slopes.}
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
#' diff <- DiffBetaDelta(std)
#' # Methods -------------------------------------------------------
#' print(diff)
#' summary(diff)
#' coef(diff)
#' vcov(diff)
#' confint(diff, level = 0.95)
#'
#' @family Beta Delta Functions
#' @keywords betaDelta diff
#' @export
DiffBetaDelta <- function(object,
                          alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      object,
      "betadelta"
    )
  )
  if (object$lm_process$p < 2) {
    stop("Two or more regressors is required.")
  }
  est <- object$lm_process$dif_betastar
  acov <- .ACovDelta(
    jcap = .JacobianDiffBetaStar(
      p = object$lm_process$p
    ),
    acov = object$acov
  )
  colnames(acov) <- rownames(acov) <- names(
    object$lm_process$dif_betastar
  )
  vcov <- (1 / object$lm_process$n) * acov
  out <- list(
    call = match.call(),
    fit = object,
    args = list(
      object = object,
      alpha = alpha
    ),
    acov = acov,
    vcov = vcov,
    est = est
  )
  class(out) <- c(
    "diffbetadelta",
    class(out)
  )
  return(
    out
  )
}
