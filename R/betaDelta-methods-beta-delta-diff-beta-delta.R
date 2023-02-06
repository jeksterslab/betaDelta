#' @rdname dif
#' @method dif betadelta
#' @export
dif.betadelta <- function(object, # nolint: object_name_linter
                          ...) {
  if (object$lm_process$p < 2) {
    stop("Two or more regressors is required.")
  }
  est <- .DiffBeta(object$est)
  varnames <- names(est)
  acov <- .ACov(
    jcap = .JacobianDiffBetastar(
      p = object$lm_process$p
    ),
    gammacap = object$acov
  )
  colnames(acov) <- rownames(acov) <- varnames
  vcov <- (1 / object$lm_process$n) * acov
  out <- list(
    betadelta = object,
    acov = acov,
    vcov = vcov,
    est = est
  )
  class(out) <- c(
    "difbetadelta",
    class(out)
  )
  return(
    out
  )
}
