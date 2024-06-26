% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deltaMethod-delta.R
\name{Delta}
\alias{Delta}
\title{Delta Method}
\usage{
Delta(
  coef,
  vcov,
  func,
  ...,
  theta = 0,
  alpha = c(0.05, 0.01, 0.001),
  z = TRUE,
  df = NULL
)
}
\arguments{
\item{coef}{Numeric vector.
Vector of parameters.}

\item{vcov}{Numeric matrix.
Matrix of sampling variance-covariance matrix of parameters.}

\item{func}{R function.
\enumerate{
\item The first argument \code{x} is the argument \code{coef}.
\item The function algebraically manipulates \code{coef}
to return a new numeric vector.
It is best to have a named vector as an output.
\item The function can take additional named arguments
passed using \code{...}.
}}

\item{...}{Additional arguments to pass to \code{func}.}

\item{theta}{Numeric vector.
Parameter values when the null hypothesis is true.}

\item{alpha}{Numeric vector.
Significance level/s.}

\item{z}{Logical.
If \code{z = TRUE},
use the standard normal distribution.
If \code{z = FALSE},
use the t distribution.}

\item{df}{Numeric.
Degrees of freedom if \code{z = FALSE}.}
}
\value{
Returns an object
of class \code{deltamethod} which is a list with the following elements:
\describe{
\item{call}{Function call.}
\item{args}{Function arguments.}
\item{coef}{Estimates.}
\item{vcov}{Sampling variance-covariance matrix.}
\item{jacobian}{Jacobian matrix.}
\item{fun}{Function used ("Delta").}
}
}
\description{
Calculates delta method sampling variance-covariance matrix
for a function of parameters
using a numerical Jacobian.
}
\examples{
object <- glm(
  formula = vs ~ wt + disp,
  family = "binomial",
  data = mtcars
)
func <- function(x) {
  y <- exp(x)
  names(y) <- paste0("exp", "(", names(x), ")")
  return(y[-1])
}
Delta(
  coef = coef(object),
  vcov = vcov(object),
  func = func,
  alpha = 0.05
)
}
\seealso{
Other Delta Method Functions: 
\code{\link{DeltaGeneric}()}
}
\author{
Ivan Jacob Agaloos Pesigan
}
\concept{Delta Method Functions}
\keyword{deltaMethod}
