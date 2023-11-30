#' Delta Method
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
#'     \item{coef}{Estimates.}
#'     \item{vcov}{Sampling variance-covariance matrix.}
#'     \item{jacobian}{Jacobian matrix.}
#'     \item{fun}{Function used ("Delta").}
#'   }
#'
#' @param coef Numeric vector.
#'   Vector of parameters.
#' @param vcov Numeric matrix.
#'   Matrix of sampling variance-covariance matrix of parameters.
#' @param func R function.
#'   1. The first argument `x` is the argument `coef`.
#'   2. The function algebraically manipulates `coef`
#'      to return at a new numeric vector.
#'      It is best to have a named vector as an output.
#'   3. The function can take additional named arguments
#'      passed using `...`.
#' @param ... Additional arguments to pass to `func`.
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
#' func <- function(x) {
#'   y <- exp(x)
#'   names(y) <- paste0("exp", "(", names(x), ")")
#'   return(y[-1])
#' }
#' Delta(
#'   coef = coef(object),
#'   vcov = vcov(object),
#'   func = func,
#'   alpha = 0.05
#' )
#' @export
#' @family Delta Method Functions
#' @keywords deltaMethod
Delta <- function(coef,
                  vcov,
                  func,
                  ...,
                  theta = 0,
                  alpha = c(0.05, 0.01, 0.001),
                  z = TRUE,
                  df = NULL) {
  if (!z) {
    if (is.null(df)) {
      stop(
        paste0(
          "Please provide a value for the argument `df`.\n",
          "Otherwise, set `z = TRUE`.\n"
        )
      )
    }
  }
  args <- list(
    coef = coef,
    vcov = vcov,
    func = func,
    args = list(...),
    theta = theta,
    alpha = alpha,
    z = z,
    df = df
  )
  j <- numDeriv::jacobian(
    func = func,
    x = coef,
    ...
  )
  k <- length(coef)
  if (k == 1) {
    # univariate
    vcov <- as.vector(vcov)
    vcov <- matrix(
      data = j^2 * vcov,
      nrow = 1,
      ncol = 1
    )
  } else {
    # multivariate
    vcov <- j %*% vcov %*% t(j)
  }
  est <- func(
    x = coef,
    ...
  )
  colnames(vcov) <- rownames(vcov) <- names(est)
  out <- list(
    call = match.call(),
    args = args,
    est = est,
    vcov = vcov,
    jacobian = j,
    fun = "Delta"
  )
  class(out) <- c(
    "deltamethod",
    class(out)
  )
  return(
    out
  )
}
