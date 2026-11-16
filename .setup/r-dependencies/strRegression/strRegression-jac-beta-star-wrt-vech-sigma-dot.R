#' Jacobian Matrix of the Standardized Partial Regression Slopes
#' with Respect to the Half-Vectorization
#' of the Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param beta Numeric vector.
#'   Regression slopes.
#' @param sigmay Numeric.
#'   Standard deviation of the regressand variable.
#' @param sigmax Numeric vector.
#'   Standard deviations of the regressor variables.
#' @param invsigmacapx Numeric matrix.
#'   Inverse of the covariance matrix of the regressors.
#' @param p Positive integer.
#'   `p` regressors.
#' @param k Positive integer.
#'   `k = p + 1`.
#'
#' @return Returns a matrix.
#' @examples
#' beta <- c(0.5, 0.3)
#' sigmacapx <- matrix(data = c(1, 0.2, 0.2, 2), nrow = 2)
#' sigmacap <- matrix(
#'   data = c(0.89, 0.56, 0.7, 0.56, 1, 0.2, 0.7, 0.2, 2),
#'   nrow = 3
#' )
#' strRegression:::.JacBetaStarWRTVechSigma(
#'   beta = beta,
#'   sigmay = sqrt(0.89),
#'   sigmax = sqrt(diag(sigmacapx)),
#'   invsigmacapx = solve(sigmacapx),
#'   p = 2,
#'   k = 3
#' )
#'
#' @family Derivatives Functions
#' @keywords strRegression derivatives internal
#' @noRd
.JacBetaStarWRTVechSigma <- function(beta,
                                     sigmay,
                                     sigmax,
                                     invsigmacapx,
                                     p,
                                     k) {
  iden <- diag(x = p)
  dsigmax <- iden
  dinvsigmax <- iden
  diag(x = dsigmax) <- sigmax
  diag(x = dinvsigmax) <- 1 / sigmax
  u_p <- 0.5 * p * (p + 1)
  u_k <- 0.5 * k * (k + 1)
  diags <- .DiagofVech(
    x = seq_len(length.out = u_p),
    k = p,
    loc = FALSE
  )
  v <- matrix(
    data = 0,
    nrow = p,
    ncol = u_p
  )
  for (i in seq_along(along.with = diags)) {
    v[i, diags[i]] <- 1
  }
  moments <- .MomentsIndex(p = p)
  jcap <- matrix(
    data = 0,
    nrow = p,
    ncol = u_k
  )
  colnames(x = jcap) <- c(
    moments$sigmaysq,
    moments$sigmayx,
    moments$vechsigmacapx
  )
  rownames(x = jcap) <- paste0(
    "betastar",
    seq_len(length.out = p)
  )
  jcap[
    ,
    moments$sigmaysq
  ] <- (-0.5 / sigmay^3) * dsigmax %*% beta
  jcap[
    ,
    moments$sigmayx
  ] <- (1 / sigmay) * (dsigmax %*% invsigmacapx)
  betastar_wrt_vechsigmacapx <- iden
  diag(x = betastar_wrt_vechsigmacapx) <- .Vec(x = dinvsigmax %*% beta)
  betastar_wrt_vechsigmacapx <- (0.5 / sigmay) * diag(
    x = betastar_wrt_vechsigmacapx
  ) * v - (
    (
      1 / sigmay
    ) * dsigmax %*% kronecker(
      X = matrix(
        data = beta,
        nrow = 1
      ),
      Y = invsigmacapx
    ) %*% .DMat(k = p)
  )
  jcap[
    ,
    moments$vechsigmacapx
  ] <- betastar_wrt_vechsigmacapx
  jcap
}
