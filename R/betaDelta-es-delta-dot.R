#' Sampling Covariance Matrix of an Effect Size
#' from a Fitted `betadelta` Object
#'
#' The Jacobian `jcap` of an effect size
#' with respect to the standardized parameter vector
#' \eqn{\boldsymbol{\theta}^{\ast} = \left( \boldsymbol{\beta}^{\ast},
#' \sigma_{y}, \boldsymbol{\sigma}_{\mathbf{x}},
#' \mathrm{vechs} \left( \mathbf{R}_{\mathbf{X}} \right) \right)}
#' is converted to the Jacobian with respect to
#' \eqn{\mathrm{vech} \left( \boldsymbol{\Sigma} \right)}
#' through the inverse of the square Jacobian of
#' \eqn{\mathrm{vech} \left( \boldsymbol{\Sigma} \right)}
#' with respect to \eqn{\boldsymbol{\theta}^{\ast}},
#' and applied to the asymptotic covariance matrix
#' \eqn{\boldsymbol{\Gamma}} stored in `object`.
#' Returns an object of class `esdelta`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `betadelta`.
#' @param jcap Numeric matrix.
#'   Jacobian of the effect size with respect to
#'   \eqn{\boldsymbol{\theta}^{\ast}}.
#' @param est Named numeric vector.
#'   Estimates of the effect size.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#' @param fun Character string.
#'   Name of the calling function.
#' @param call Function call.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta internal
#' @noRd
.ESDelta <- function(object,
                     jcap,
                     est,
                     alpha,
                     fun,
                     call) {
  lm_process <- object$lm_process
  jcap <- jcap %*% solve(
    a = .JacVechSigmaWRTThetaStar(
      betastar = lm_process$betastar,
      sigmay = lm_process$sigma[1],
      sigmax = lm_process$sigma[-1],
      rhocapx = lm_process$rhocap[
        2:lm_process$k,
        2:lm_process$k,
        drop = FALSE
      ],
      q = lm_process$q,
      p = lm_process$p
    )
  )
  acov <- .ACovDelta(
    jcap = jcap,
    acov = object$gamma
  )
  colnames(x = acov) <- rownames(x = acov) <- names(x = est)
  out <- list(
    call = call,
    fit = object,
    args = list(
      object = object,
      alpha = alpha
    ),
    acov = acov,
    vcov = (1 / lm_process$n) * acov,
    est = est,
    fun = fun
  )
  class(x = out) <- c(
    "esdelta",
    class(x = out)
  )
  out
}
