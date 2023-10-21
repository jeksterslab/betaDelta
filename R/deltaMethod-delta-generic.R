#' Delta Method Confidence Intervals (Generic)
#'
#' Calculates delta method confidence intervals
#' for a function of parameters
#' using a numerical Jacobian.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix with the following variables:
#'   \describe{
#'     \item{est}{Estimates}
#'     \item{se}{Standard errors}
#'     \item{t or z}{Test statistics}
#'     \item{p}{p value}
#'     \item{ci}{Confidence intervals}
#'   }
#'
#' @param object R object.
#'   Fitted model object with `coef` and `vcov` methods
#'   that return a named vector of
#'   estimated parameters and sampling variance-covariance matrix,
#'   respectively.
#' @param def List of character strings.
#'   A list of defined functions of parameters.
#'   The string should be a valid R expression when parsed
#'   and should result a single value when evaluated.
#' @param theta Numeric vector.
#'   Parameter values when the null hypothesis is true.
#' @param alpha Numeric vector.
#'   Significance level/s.
#' @param z Logical.
#'   If `z = TRUE`,
#'   use the standard normal distribution.
#'   If `z = FALSE`,
#'   use the t distribution.
#' @param df Numeric.
#'   Degrees of freedom if `z = FALSE`.
#'
#' @examples
#' object <- glm(
#'   formula = vs ~ wt + disp,
#'   family = "binomial",
#'   data = mtcars
#' )
#' def <- list("exp(wt)", "exp(disp)")
#' DeltaGeneric(
#'   object = object,
#'   def = def,
#'   alpha = 0.05
#' )
#' @importFrom numDeriv jacobian
#' @export
#' @family Delta Method Functions
#' @keywords deltaMethod
DeltaGeneric <- function(object,
                         def,
                         theta = 0,
                         alpha = c(0.05, 0.01, 0.001),
                         z = TRUE,
                         df) {
  ## function
  func <- function(coef,
                   def) {
    env <- list2env(
      as.list(coef)
    )
    sapply(
      X = def,
      FUN = function(i) {
        return(
          eval(
            parse(text = i),
            envir = env
          )
        )
      }
    )
  }
  ## identify coefficients used and do delta only for them
  defs_exp <- lapply(
    X = def,
    FUN = function(x) {
      parse(text = x)
    }
  )
  def_vars <- unique(
    unlist(
      sapply(
        X = defs_exp,
        FUN = all.vars
      )
    )
  )
  ## def to be used as names
  def_vec <- def
  dim(def_vec) <- NULL
  coef <- stats::coef(object)[def_vars]
  vcov <- stats::vcov(object)[def_vars, def_vars]
  k <- length(coef)
  j <- numDeriv::jacobian(
    func = func,
    x = coef,
    def = def
  )
  if (k == 1) {
    # univariate
    vcov <- as.vector(vcov)
    vcov <- j^2 * vcov
    se <- as.vector(sqrt(vcov))
  } else {
    # multivariate
    vcov <- j %*% vcov %*% t(j)
    se <- as.vector(sqrt(diag(vcov)))
  }
  est <- func(
    coef = coef,
    def = def
  )
  return(
    .CIWald(
      est = est,
      se = se,
      theta = theta,
      alpha = alpha,
      z = z,
      df = df,
      test = FALSE
    )
  )
}
