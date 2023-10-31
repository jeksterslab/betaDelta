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
#' @family Derivatives Functions
#' @keywords strRegression derivatives internal
#' @noRd
.JacobianBetaStarWRTVechSigma <- function(beta,
                                          sigmay,
                                          sigmax,
                                          invsigmacapx,
                                          p,
                                          k) {
  iden <- diag(p)
  dsigmax <- iden
  dinvsigmax <- iden
  diag(dsigmax) <- sigmax
  diag(dinvsigmax) <- 1 / sigmax
  u_p <- 0.5 * p * (p + 1)
  u_k <- 0.5 * k * (k + 1)
  diags <- .DiagofVech(
    x = seq_len(u_p),
    k = p,
    loc = FALSE
  )
  v <- matrix(
    data = 0,
    nrow = p,
    ncol = u_p
  )
  for (i in seq_along(diags)) {
    v[i, diags[i]] <- 1
  }
  moments <- .MomentsIndex(p)
  jcap <- matrix(
    0,
    nrow = p,
    ncol = u_k
  )
  colnames(jcap) <- c(
    moments$sigmaysq,
    moments$sigmayx,
    moments$vechsigmacapx
  )
  rownames(jcap) <- paste0(
    "betastar",
    seq_len(p)
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
  diag(betastar_wrt_vechsigmacapx) <- .Vec(dinvsigmax %*% beta)
  betastar_wrt_vechsigmacapx <- (0.5 / sigmay) * diag(
    betastar_wrt_vechsigmacapx
  ) * v - (
    (
      1 / sigmay
    ) * dsigmax %*% kronecker(
      matrix(
        data = beta,
        nrow = 1
      ),
      invsigmacapx
    ) %*% .DMat(p)
  )
  jcap[
    ,
    moments$vechsigmacapx
  ] <- betastar_wrt_vechsigmacapx
  return(
    jcap
  )
}
