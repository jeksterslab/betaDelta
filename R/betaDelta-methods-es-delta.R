#' Print Method for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of
#'   estimates,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param x Object of class `esdelta`.
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
#' out <- RSqDelta(std)
#' print(out)
#'
#' @keywords methods
#' @export
print.esdelta <- function(x,
                          alpha = NULL,
                          digits = 4,
                          ...) {
  print.summary.esdelta(
    x = summary.esdelta(
      object = x,
      alpha = alpha,
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   estimates,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `esdelta`.
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
#' out <- RSqDelta(std)
#' summary(out)
#'
#' @keywords methods
#' @export
summary.esdelta <- function(object,
                            alpha = NULL,
                            digits = 4,
                            ...) {
  ci <- .ESDeltaCI(
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
  class(x = ci) <- "summary.esdelta"
  ci
}

#' Print Method for an Object of Class `summary.esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of
#'   estimates,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param x Object of class `summary.esdelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- RSqDelta(std)
#' summary(out)
#'
#' @keywords methods
#' @export
print.summary.esdelta <- function(x,
                                  ...) {
  print_summary <- attr(
    x = x,
    which = "print_summary"
  )
  object <- attr(
    x = x,
    which = "fit"
  )
  label <- switch(
    EXPR = object$fun,
    RSqDelta = "R-squared and adjusted R-squared",
    SCorDelta = "Semipartial correlations",
    PCorDelta = "Squared partial correlations",
    DeltaRSqDelta = "Improvement in R-squared",
    FSqDelta = "Cohen's f-squared (fsq) and local f-squared",
    DiffBetaDelta = "Differences of standardized regression slopes"
  )
  cat("Call:\n")
  base::print(x = object$call)
  cat(
    "\n",
    label,
    " with ",
    toupper(x = object$fit$args$type),
    " standard errors:\n",
    sep = ""
  )
  print(x = print_summary)
  invisible(x = x)
}

#' Sampling Covariance Matrix for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of the
#'   variance-covariance matrix
#'   of the estimates.
#'
#' @param object Object of class `esdelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- RSqDelta(std)
#' vcov(out)
#'
#' @keywords methods
#' @export
vcov.esdelta <- function(object,
                         ...) {
  object$vcov
}

#' Estimates for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of estimates.
#'
#' @param object Object of class `esdelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- RSqDelta(std)
#' coef(out)
#'
#' @keywords methods
#' @export
coef.esdelta <- function(object,
                         ...) {
  object$est
}

#' Confidence Intervals for an Object of Class `esdelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @param object Object of class `esdelta`.
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
#' out <- RSqDelta(std)
#' confint(out, level = 0.95)
#'
#' @keywords methods
#' @export
confint.esdelta <- function(object,
                            parm = NULL,
                            level = 0.95,
                            ...) {
  if (is.null(x = parm)) {
    parm <- seq_along(
      along.with = object$est
    )
  }
  ci <- .ESDeltaCI(
    object = object,
    alpha = 1 - level[1]
  )[parm, 5:6, drop = FALSE]
  varnames <- colnames(x = ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(x = ci) <- varnames
  ci
}
