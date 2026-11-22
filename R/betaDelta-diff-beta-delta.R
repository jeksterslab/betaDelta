#' Estimate Differences of Standardized Regression Coefficients
#' and the Corresponding Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details
#' For every pair of regressors \eqn{j < l},
#' the difference of the standardized regression slopes (see [BetaDelta()]) is
#' \deqn{\Delta \beta^{\ast}_{jl} = \beta^{\ast}_{j} - \beta^{\ast}_{l}.}
#' Collect the differences as \eqn{\boldsymbol{C} \boldsymbol{\beta}^{\ast}},
#' where each row of \eqn{\boldsymbol{C}} has \eqn{1} in column \eqn{j},
#' \eqn{-1} in column \eqn{l}, and zeros elsewhere.
#' The sampling covariance matrix is
#' \deqn{\widehat{\operatorname{var}} \left( \boldsymbol{C}
#' \hat{\boldsymbol{\beta}}^{\ast} \right) = \boldsymbol{C}
#' \widehat{\operatorname{var}} \left( \hat{\boldsymbol{\beta}}^{\ast} \right)
#' \boldsymbol{C}^{\prime},}
#' and the confidence intervals are
#' \eqn{\Delta \hat{\beta}^{\ast}_{jl} \pm z_{1 - \alpha / 2}
#' \widehat{\operatorname{se}} \left( \Delta \hat{\beta}^{\ast}_{jl} \right)}.
#' The slopes must be fully standardized
#' (`std_y = TRUE` and `std_x = NULL` in [BetaDelta()]).
#'
#' @return Returns an object
#'   of class `esdelta` (and `diffbetadelta`)
#'   which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{fit}{The argument `object`.}
#'     \item{args}{Function arguments.}
#'     \item{vcov}{Sampling covariance matrix of
#'       differences of standardized slopes.}
#'     \item{est}{Vector of
#'       differences of standardized slopes.}
#'     \item{fun}{Function used ("DiffBetaDelta").}
#'   }
#'
#' @param object Object of class `betadelta`,
#'   that is,
#'   the output of the [BetaDelta()] function.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'
#' @examples
#' # Data ---------------------------------------------------------------------
#' data("nas1982", package = "betaDelta")
#'
#' # Fit Model in lm ----------------------------------------------------------
#' object <- stats::lm(
#'   formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
#'   data = nas1982
#' )
#'
#' # BetaDelta ----------------------------------------------------------------
#' std <- BetaDelta(object = object)
#'
#' # DiffBetaDelta ------------------------------------------------------------
#' diff <- DiffBetaDelta(object = std)
#'
#' ## Methods -----------------------------------------------------------------
#' print(x = diff)
#' summary(object = diff)
#' coef(object = diff)
#' vcov(object = diff)
#' confint(object = diff, level = 0.95)
#'
#' @family Beta Delta Method Functions
#' @keywords betaDelta diff
#' @export
DiffBetaDelta <- function(object,
                          alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      x = object,
      what = "betadelta"
    )
  )
  if (object$lm_process$p < 2) {
    stop("Two or more regressors is required.")
  }
  if (isFALSE(x = attributes(x = object)$std)) {
    stop("Differences need fully standardized slopes.")
  }
  est <- object$lm_process$dif_betastar
  acov <- .ACovDelta(
    jcap = .JacDiffBetaStar(
      p = object$lm_process$p
    ),
    acov = object$acov
  )
  colnames(x = acov) <- rownames(x = acov) <- names(
    x = object$lm_process$dif_betastar
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
    est = est,
    fun = "DiffBetaDelta"
  )
  class(x = out) <- c(
    "esdelta",
    "diffbetadelta",
    class(x = out)
  )
  out
}
