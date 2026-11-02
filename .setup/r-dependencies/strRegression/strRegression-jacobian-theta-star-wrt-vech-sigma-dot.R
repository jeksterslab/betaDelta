#' Jacobian of the Standardized Parameters
#' with Respect to the Covariance Matrix
#'
#' Jacobian of
#' \eqn{\left( \boldsymbol{\beta}^{\ast}, \sigma_{y},
#' \boldsymbol{\sigma}_{\mathbf{x}} \right)}
#' with respect to
#' \eqn{\mathrm{vech} \left( \boldsymbol{\Sigma} \right)},
#' where \eqn{\boldsymbol{\Sigma}} is the covariance matrix of
#' \eqn{\left( y, \mathbf{x} \right)}.
#' Rows `1:p` are [.JacobianBetaStarWRTVechSigma()].
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams .JacobianBetaStarWRTVechSigma
#' @return Returns a `2 * p + 1` by `k * (k + 1) / 2` numeric matrix.
#'
#' @family Structure of Regression Functions
#' @keywords strRegression internal
#' @noRd
.JacobianThetaStarWRTVechSigma <- function(beta,
                                           sigmay,
                                           sigmax,
                                           invsigmacapx,
                                           p,
                                           k) {
  u_k <- 0.5 * k * (k + 1)
  diags <- .DiagofVech(
    x = seq_len(u_k),
    k = k,
    loc = FALSE
  )
  jcap_sigma <- matrix(
    data = 0.0,
    nrow = k,
    ncol = u_k
  )
  sigma <- c(sigmay, sigmax)
  for (i in seq_len(k)) {
    jcap_sigma[i, diags[i]] <- 0.5 / sigma[i]
  }
  jcap <- rbind(
    .JacobianBetaStarWRTVechSigma(
      beta = beta,
      sigmay = sigmay,
      sigmax = sigmax,
      invsigmacapx = invsigmacapx,
      p = p,
      k = k
    ),
    jcap_sigma
  )
  rownames(jcap) <- NULL
  jcap
}
