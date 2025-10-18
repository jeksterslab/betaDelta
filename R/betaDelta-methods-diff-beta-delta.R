#' Print Method for an Object of Class `diffbetadelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of
#'   standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   degrees of freedom,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param x Object of class `diffbetadelta`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `x`.
#' @param digits Digits to print.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' diff <- DiffBetaDelta(std)
#' print(diff)
#'
#' @keywords methods
#' @export
print.diffbetadelta <- function(x,
                                alpha = NULL,
                                digits = 4,
                                ...) {
  print.summary.diffbetadelta(
    summary.diffbetadelta(
      object = x,
      alpha = alpha,
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class `diffbetadelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   degrees of freedom,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `diffbetadelta`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `object`.
#' @param digits Digits to print.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' diff <- DiffBetaDelta(std)
#' summary(diff)
#'
#' @keywords methods
#' @export
summary.diffbetadelta <- function(object,
                                  alpha = NULL,
                                  digits = 4,
                                  ...) {
  ci <- .DiffBetaCI(
    object = object,
    alpha = alpha
  )
  print_summary <- round(
    x = ci,
    digits = digits
  )
  attr(
    x = ci,
    which = "fit"
  ) <- object
  attr(
    x = ci,
    which = "print_summary"
  ) <- print_summary
  attr(
    x = ci,
    which = "alpha"
  ) <- alpha
  attr(
    x = ci,
    which = "digits"
  ) <- digits
  class(ci) <- "summary.diffbetadelta"
  ci
}

#' @noRd
#' @keywords internal
#' @exportS3Method print summary.diffbetadelta
print.summary.diffbetadelta <- function(x,
                                        ...) {
  print_summary <- attr(
    x = x,
    which = "print_summary"
  )
  object <- attr(
    x = x,
    which = "fit"
  )
  cat("Call:\n")
  base::print(object$call)
  cat(
    "\nDifference between standardized regression coefficients with",
    toupper(object$fit$args$type),
    "standard errors:\n"
  )
  print(print_summary)
  invisible(x)
}

#' Sampling Covariance Matrix of
#' Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of the
#'   variance-covariance matrix
#'   of differences of standardized regression slopes.
#'
#' @param object Object of class `diffbetadelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' diff <- DiffBetaDelta(std)
#' vcov(diff)
#'
#' @keywords methods
#' @export
vcov.diffbetadelta <- function(object,
                               ...) {
  object$vcov
}

#' Differences of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of differences of standardized regression slopes.
#'
#' @param object Object of class `diffbetadelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' diff <- DiffBetaDelta(std)
#' coef(diff)
#'
#' @keywords methods
#' @export
coef.diffbetadelta <- function(object,
                               ...) {
  object$est
}

#' Confidence Intervals for Differences
#' of Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @param object Object of class `diffbetadelta`.
#' @param ... additional arguments.
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' diff <- DiffBetaDelta(std)
#' confint(diff)
#'
#' @keywords methods
#' @export
confint.diffbetadelta <- function(object,
                                  parm = NULL,
                                  level = 0.95,
                                  ...) {
  if (is.null(parm)) {
    parm <- seq_len(
      length(object$est)
    )
  }
  ci <- .DiffBetaCI(
    object = object,
    alpha = 1 - level[1]
  )[parm, 5:6, drop = FALSE] # always z
  varnames <- colnames(ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(ci) <- varnames
  ci
}
