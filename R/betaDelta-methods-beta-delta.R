#' Print Method for an Object of Class `betadelta`
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
#' @param x Object of class `betadelta`.
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
#' print(std)
#'
#' @keywords methods
#' @export
print.betadelta <- function(x,
                            alpha = NULL,
                            digits = 4,
                            ...) {
  summary.betadelta(
    object = x,
    alpha = alpha,
    digits = digits
  )
}

#' Summary Method for an Object of Class `betadelta`
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
#' @param object Object of class `betadelta`.
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
#' summary(std)
#'
#' @keywords methods
#' @export
summary.betadelta <- function(object,
                              alpha = NULL,
                              digits = 4,
                              ...) {
  ci <- .BetaCI(
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
  class(ci) <- "summary.betadelta"
  ci
}

#' @noRd
#' @keywords internal
#' @exportS3Method print summary.betadelta
print.summary.betadelta <- function(x,
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
    "\nStandardized regression slopes with",
    toupper(object$args$type),
    "standard errors:\n"
  )
  print(print_summary)
  invisible(x)
}

#' Sampling Covariance Matrix of the Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of the
#'   variance-covariance matrix
#'   of standardized slopes.
#'
#' @param object Object of class `betadelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' vcov(std)
#'
#' @keywords methods
#' @export
vcov.betadelta <- function(object,
                           ...) {
  object$vcov
}

#' Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of standardized regression slopes.
#'
#' @param object Object of class `betadelta`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' coef(std)
#'
#' @keywords methods
#' @export
coef.betadelta <- function(object,
                           ...) {
  object$est
}

#' Confidence Intervals for Standardized Regression Slopes
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @param object Object of class `betadelta`.
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
#' confint(std, level = 0.95)
#'
#' @keywords methods
#' @export
confint.betadelta <- function(object,
                              parm = NULL,
                              level = 0.95,
                              ...) {
  if (is.null(parm)) {
    parm <- seq_len(
      length(object$est)
    )
  }
  ci <- .BetaCI(
    object = object,
    alpha = 1 - level[1]
  )[parm, 6:7, drop = FALSE] # always t
  varnames <- colnames(ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(ci) <- varnames
  ci
}
