#' Delta Method (Generic Object Input)
#'
#' Calculates delta method sampling variance-covariance matrix
#' for a function of parameters
#' using a numerical Jacobian.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object
#'   of class `deltamethod` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{est}{Estimates.}
#'     \item{vcov}{Sampling variance-covariance matrix.}
#'     \item{jacobian}{Jacobian matrix.}
#'     \item{fun}{Function used ("DeltaGeneric").}
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
#' object <- stats::glm(
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
#' @export
#' @family Delta Method Functions
#' @keywords deltaMethod
DeltaGeneric <- function(object,
                         def,
                         theta = 0,
                         alpha = c(0.05, 0.01, 0.001),
                         z = TRUE,
                         df = NULL) {
  if (!z) {
    if (is.null(x = df)) {
      stop(
        paste0(
          "Please provide a value for the argument `df`.\n",
          "Otherwise, set `z = TRUE`.\n"
        )
      )
    }
  }
  args <- list(
    object = object,
    def = def,
    theta = theta,
    alpha = alpha,
    z = z,
    df = df
  )
  ## function
  func <- function(coef,
                   def) {
    env <- list2env(
      x = as.list(x = coef)
    )
    sapply(
      X = def,
      FUN = function(i) {
        eval(
          expr = parse(text = i),
          envir = env
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
    x = unlist(
      x = sapply(
        X = defs_exp,
        FUN = all.vars
      )
    )
  )
  ## def to be used as names
  def_vec <- def
  dim(x = def_vec) <- NULL
  coef <- stats::coef(object = object)[def_vars]
  vcov <- stats::vcov(object = object)[def_vars, def_vars]
  j <- numDeriv::jacobian(
    func = func,
    x = coef,
    def = def
  )
  # J V J' for any number of coefficients and definitions
  vcov <- j %*% tcrossprod(
    x = as.matrix(x = vcov),
    y = j
  )
  est <- func(
    coef = coef,
    def = def
  )
  def <- do.call(
    what = "rbind",
    args = def
  )
  dim(x = def) <- NULL
  names(x = est) <- def
  colnames(x = vcov) <- rownames(x = vcov) <- def
  out <- list(
    call = match.call(),
    args = args,
    est = est,
    vcov = vcov,
    jacobian = j,
    fun = "DeltaGeneric"
  )
  class(x = out) <- c(
    "deltamethod",
    class(x = out)
  )
  out
}
