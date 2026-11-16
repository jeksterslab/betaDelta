#' betaDelta: Confidence Intervals for Standardized Regression Coefficients
#'
#' Generates confidence intervals for standardized regression coefficients
#' using delta method standard errors for models fitted by [stats::lm()]
#' (Yuan & Chan, 2011; Jones & Waller, 2015). Sampling covariance matrices are
#' obtained under multivariate normal theory or the asymptotically
#' distribution-free approach.
#'
#' @section Standardized regression coefficients:
#' [BetaDelta()] estimates the standardized regression coefficients
#' and the corresponding sampling covariance matrix.
#' The arguments `std_y` and `std_x` standardize only the outcome
#' or only the named regressors.
#'
#' @section Functions of the standardized coefficients:
#' [DiffBetaDelta()] (differences of standardized slopes),
#' [RSqDelta()] (R-squared and adjusted R-squared),
#' [SCorDelta()] and [SCorSqDelta()] (semipartial correlations),
#' [PCorDelta()] (squared partial correlations),
#' [DeltaRSqDelta()] (improvement in R-squared), and
#' [FSqDelta()] (Cohen's f-squared and local f-squared).
#'
#' @section General delta method:
#' [Delta()] and [DeltaGeneric()] apply the delta method
#' to any function of the parameters.
#'
#' @section Methods:
#' The `coef()`, `vcov()`, `confint()`, `summary()`, and `print()` methods are
#' available for objects of class `betadelta` and `esdelta`.
#'
#' @references
#' Jones, J. A., & Waller, N. G. (2015).
#' The normal-theory and asymptotic distribution-free (ADF) covariance matrix
#' of standardized regression coefficients:
#' Theoretical extensions and finite sample behavior.
#' *Psychometrika*, *80*(2), 365--378.
#' \doi{10.1007/s11336-013-9380-y}
#'
#' Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023).
#' betaDelta and betaSandwich:
#' Confidence intervals for standardized regression coefficients in R.
#' *Multivariate Behavioral Research*.
#' \doi{10.1080/00273171.2023.2201277}
#'
#' Yuan, K.-H., & Chan, W. (2011).
#' Biases and standard errors of standardized regression coefficients.
#' *Psychometrika*, *76*(4), 670--690.
#' \doi{10.1007/s11336-011-9224-6}
#'
#' @aliases betaDelta-package
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
