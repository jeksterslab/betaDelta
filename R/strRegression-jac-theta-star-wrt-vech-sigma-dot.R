#' Jacobian of the Standardized Parameters
#' with Respect to the Covariance Matrix
#'
#' Jacobian of
#' \eqn{\left( \boldsymbol{\beta}^{\ast}, \sigma_{y},
#' \boldsymbol{\sigma}_{\boldsymbol{x}} \right)}
#' with respect to
#' \eqn{\operatorname{vech} \left( \boldsymbol{\Sigma} \right)},
#' where \eqn{\boldsymbol{\Sigma}} is the covariance matrix of
#' \eqn{\left( y, \boldsymbol{x} \right)}.
#' Rows `1:p` are `.JacBetaStarWRTVechSigma()`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams .JacBetaStarWRTVechSigma
#' @return Returns a `2 * p + 1` by `k * (k + 1) / 2` numeric matrix.
#'
#' @examples
#' beta <- c(0.5, 0.3)
#' sigmacapx <- matrix(data = c(1, 0.2, 0.2, 2), nrow = 2)
#' sigmacap <- matrix(
#'   data = c(0.89, 0.56, 0.7, 0.56, 1, 0.2, 0.7, 0.2, 2),
#'   nrow = 3
#' )
#' strRegression:::.JacThetaStarWRTVechSigma(
#'   beta = beta,
#'   sigmay = sqrt(0.89),
#'   sigmax = sqrt(diag(sigmacapx)),
#'   invsigmacapx = solve(sigmacapx),
#'   p = 2,
#'   k = 3
#' )
#'
#' @family Structure of Regression Functions
#' @keywords strRegression internal
#' @noRd
.JacThetaStarWRTVechSigma <- function(beta,
                                      sigmay,
                                      sigmax,
                                      invsigmacapx,
                                      p,
                                      k) {
  u_k <- 0.5 * k * (k + 1)
  diags <- .DiagofVech(
    x = seq_len(length.out = u_k),
    k = k,
    loc = FALSE
  )
  jcap_sigma <- matrix(
    data = 0.0,
    nrow = k,
    ncol = u_k
  )
  sigma <- c(sigmay, sigmax)
  for (i in seq_len(length.out = k)) {
    jcap_sigma[i, diags[i]] <- 0.5 / sigma[i]
  }
  jcap <- rbind(
    .JacBetaStarWRTVechSigma(
      beta = beta,
      sigmay = sigmay,
      sigmax = sigmax,
      invsigmacapx = invsigmacapx,
      p = p,
      k = k
    ),
    jcap_sigma
  )
  rownames(x = jcap) <- NULL
  jcap
}
