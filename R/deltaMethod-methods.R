#' Print Method for an Object of Class `deltamethod`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   coefficients,
#'   standard errors,
#'   test statistics,
#'   degrees of freedom (if z = FALSE),
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param x Object of class `deltamethod`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `x`.
#' @param digits Digits to print.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' out <- DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' print(out)
#'
#' @keywords methods
#' @export
print.deltamethod <- function(x,
                              alpha = NULL,
                              digits = 4,
                              ...) {
  cat("Call:\n")
  base::print(x$call)
  base::print(
    round(
      .DeltaCI(
        object = x,
        alpha = alpha
      ),
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class `deltamethod`
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
#' @param object Object of class `deltamethod`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `object`.
#' @param digits Digits to print.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' out <- DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' summary(out)
#'
#' @keywords methods
#' @export
summary.deltamethod <- function(object,
                                alpha = NULL,
                                digits = 4,
                                ...) {
  cat("Call:\n")
  base::print(object$call)
  return(
    round(
      .DeltaCI(
        object = object,
        alpha = alpha
      ),
      digits = digits
    )
  )
}

#' Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of the
#'   variance-covariance matrix.
#'
#' @param object Object of class `deltamethod`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' out <- DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' vcov(out)
#'
#' @keywords methods
#' @export
vcov.deltamethod <- function(object,
                             ...) {
  return(
    object$vcov
  )
}

#' Estimates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of estimates.
#'
#' @param object Object of class `deltamethod`.
#' @param ... additional arguments.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' out <- DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' coef(out)
#'
#' @keywords methods
#' @export
coef.deltamethod <- function(object,
                             ...) {
  return(
    object$est
  )
}

#' Confidence Intervals
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @param object Object of class `deltamethod`.
#' @param ... additional arguments.
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' out <- DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' confint(out, level = 0.95)
#'
#' @keywords methods
#' @export
confint.deltamethod <- function(object,
                                parm = NULL,
                                level = 0.95,
                                ...) {
  if (is.null(parm)) {
    parm <- seq_len(
      length(object$est)
    )
  }
  ci <- .DeltaCI(
    object = object,
    alpha = 1 - level[1]
  )
  if (object$args$z) {
    ci <- ci[parm, 5:6, drop = FALSE]
  } else {
    ci <- ci[parm, 6:7, drop = FALSE]
  }
  varnames <- colnames(ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(ci) <- varnames
  return(
    ci
  )
}
