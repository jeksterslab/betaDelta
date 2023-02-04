#' Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an vector of differences of standardized regression slopes.
#'
#' @param betastar Numeric vector.
#'   Vector of standardized regression slopes.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta dif internal
#' @noRd
.DiffBeta <- function(betastar) {
  idx <- utils::combn(seq_len(length(betastar)), 2)
  q <- dim(idx)[2]
  out <- rep(x = 0.0, times = q)
  xnames <- names(betastar)
  varnames <- rep(x = 0.0, times = q)
  for (i in seq_len(q)) {
    out[i] <- betastar[idx[1, i]] - betastar[idx[2, i]]
    varnames[i] <- paste0(xnames[idx[1, i]], "-", xnames[idx[2, i]])
  }
  names(out) <- varnames
  return(out)
}
