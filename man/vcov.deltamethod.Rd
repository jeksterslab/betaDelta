% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deltaMethod-methods.R
\name{vcov.deltamethod}
\alias{vcov.deltamethod}
\title{Sampling Covariance Matrix}
\usage{
\method{vcov}{deltamethod}(object, ...)
}
\arguments{
\item{object}{Object of class \code{deltamethod}.}

\item{...}{additional arguments.}
}
\value{
Returns a matrix of the
variance-covariance matrix.
}
\description{
Sampling Covariance Matrix
}
\examples{
object <- glm(
  formula = vs ~ wt + disp,
  family = "binomial",
  data = mtcars
)
def <- list("exp(wt)", "exp(disp)")
out <- DeltaGeneric(
  object = object,
  def = def,
  alpha = 0.05
)
vcov(out)

}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{methods}
