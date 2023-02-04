#' Print Method for an Object of Class `rsqbetadelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `rsqbetadelta`.
#' @param ... additional arguments.
#' @param alpha Significance level.
#' @param digits Digits to print.
#' @return Returns a matrix of standardized regression slopes,
#'   standard errors, test statistics, p-values, and confidence intervals.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' print(out)
#' @export
#' @keywords methods
print.rsqbetadelta <- function(x,
                               alpha = c(0.05, 0.01, 0.001),
                               digits = 4,
                               ...) {
  cat(
    "R-squared with",
    toupper(x$betadelta$type),
    "standard errors:\n"
  )
  base::print(
    round(
      .RSqCI(
        object = x,
        alpha = alpha
      ),
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class `rsqbetadelta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `rsqbetadelta`.
#' @param ... additional arguments.
#' @param alpha Significance level.
#' @param digits Digits to print.
#' @return Returns a matrix of standardized regression slopes,
#'   standard errors, test statistics, p-values, and confidence intervals.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' summary(out)
#' @export
#' @keywords methods
summary.rsqbetadelta <- function(object,
                                 alpha = c(0.05, 0.01, 0.001),
                                 digits = 4,
                                 ...) {
  cat(
    "R-squared with",
    toupper(object$betadelta$type),
    "standard errors:\n"
  )
  return(
    round(
      .RSqCI(
        object = object,
        alpha = alpha
      ),
      digits = digits
    )
  )
}

#' Sampling Covariance Matrix of R-Squared and Adjusted R-Squared
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `rsqbetadelta`.
#' @param ... additional arguments.
#' @return Returns a matrix of the variance-covariance matrix
#'   of R-squared and adjusted R-squared.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' vcov(out)
#' @export
#' @keywords methods
vcov.rsqbetadelta <- function(object,
                              ...) {
  return(
    object$vcov
  )
}

#' R-Squared and Adjusted R-Squared
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `rsqrdelta`.
#' @param ... additional arguments.
#' @return Returns a vector of R-squared and adjusted R-squared.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' coef(out)
#' @export
#' @keywords methods
coef.rsqbetadelta <- function(object,
                              ...) {
  return(
    object$est
  )
}

#' Confidence Intervals for R-Squared and Adjusted R-Squared
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `rsqrdelta`.
#' @param ... additional arguments.
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
#' @return Returns a matrix of confidence intervals.
#' @examples
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' std <- BetaDelta(object)
#' out <- rsq(std)
#' confint(out, level = 0.95)
#' @export
#' @keywords methods
confint.rsqbetadelta <- function(object,
                                 parm = NULL,
                                 level = 0.95,
                                 ...) {
  if (is.null(parm)) {
    parm <- 1:2
  }
  return(
    .RSqCI(
      object = object,
      alpha = 1 - level[1]
    )[parm, 5:6]
  )
}
