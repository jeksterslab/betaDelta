#' Check the Input of the Effect-Size Delta Functions
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `betadelta`.
#' @param p_min Positive integer.
#'   Minimum number of regressors.
#'
#' @family Beta Delta Functions
#' @keywords betaDelta internal
#' @noRd
.CheckDelta <- function(object,
                        p_min = 1) {
  stopifnot(
    inherits(
      x = object,
      what = "betadelta"
    )
  )
  if (object$lm_process$p < p_min) {
    stop("Two or more regressors is required.")
  }
  invisible(x = TRUE)
}
