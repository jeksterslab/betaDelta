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
#'   Note that if `test = TRUE`, the `ci` columns are omitted.
#'
#' @param func An R function the input of which is `mu`.
#'   The function should return a vector of any length.
#'
#' @param mu Numeric vector.
#'   Input of `func`.
#' @param sigmacap Numeric vector or matrix.
#'   Asymptotic covariance matrix of `mu`.
#' @param n Sample size.
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
#' @param test Logical.
#'   If `TRUE`,
#'   return only the results of hypothesis tests.
#'   If `FALSE`,
#'   return both results of hypothesis tests and confidence intervals.
#'
#' @examples
#' g <- function(x) {
#'   1 / x
#' }
#' mu <- 100
#' sigmasq <- 225
#' n <- 30
#' DeltaGeneric(
#'   func = g,
#'   mu = mu,
#'   sigmacap = sigmasq,
#'   n = n
#' )
#' @importFrom numDeriv jacobian
#' @export
#' @family Delta Method Functions
#' @keywords deltaMethod
DeltaGeneric <- function(func,
                         mu,
                         sigmacap,
                         n,
                         theta = 0,
                         alpha = c(0.05, 0.01, 0.001),
                         z = TRUE,
                         df,
                         test = FALSE) {
  stopifnot(
    is.vector(mu)
  )
  stopifnot(
    is.vector(sigmacap) | is.matrix(sigmacap)
  )
  k <- length(mu)
  j <- numDeriv::jacobian(
    func = func,
    x = mu
  )
  if (k == 1) {
    # univariate
    sigmacap <- as.vector(sigmacap)
    stopifnot(length(sigmacap) == 1)
    vcov <- j^2 * (sigmacap / n)
    se <- as.vector(sqrt(vcov))
  } else {
    # multivariate
    stopifnot(
      sigmacap == t(sigmacap),
      dim(sigmacap)[1] == k
    )
    vcov <- j %*% (sigmacap / n) %*% t(j)
    se <- as.vector(sqrt(diag(vcov)))
  }
  est <- func(mu)
  return(
    .CIWald(
      est = est,
      se = se,
      theta = theta,
      alpha = alpha,
      z = z,
      df = df,
      test = test
    )
  )
}
