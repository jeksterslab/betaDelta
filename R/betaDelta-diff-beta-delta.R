#' Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object of class `betadelta`
#' which is a list with the following elements:
#' \describe{
#'   \item{call}{Function call.}
#'   \item{betadelta}{Object of class `betadelta`.}
#'   \item{est}{Vector of differences of standardized regression slopes.}
#'   \item{vcov}{Sampling covariance matrix
#'     of differences of standardized slopes.}
#'   \item{acov}{Asymptotic covariance matrix
#'     of differences of standardized slopes.}
#' }
#' @param object Object of class `betadelta`.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- dif(std)
#' # Methods -------------------------------------------------------
#' print(out)
#' summary(out)
#' coef(out)
#' vcov(out)
#' confint(out, level = 0.95)
#' @method dif betadelta
#' @export
#' @family Beta Delta Functions
#' @keywords betaDelta dif methods
dif.betadelta <- function(object) { # nolint: object_name_linter
  if (object$lm_process$p < 2) {
    stop("Two or more regressors is required.")
  }
  est <- .DiffBeta(object$est)
  varnames <- names(est)
  acov <- .ACov(
    jcap = .JacobianDiffBetastar(
      x = est
    ),
    gammacap = object$acov
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
    "difbetadelta",
    class(out)
  )
  return(
    out
  )
}
