#' Estimate Standardized Regression Coefficients
#' and the Corresponding Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details
#' Partition the covariance matrix of the outcome and the regressors as
#' \deqn{\boldsymbol{\Sigma} = \begin{pmatrix} \sigma^{2}_{y} &
#' \boldsymbol{\sigma}_{yx}^{\prime} \\ \boldsymbol{\sigma}_{yx} &
#' \boldsymbol{\Sigma}_{x} \end{pmatrix}.}
#' The regression slopes and the standardized regression slopes are
#' \deqn{\boldsymbol{\beta} = \boldsymbol{\Sigma}_{x}^{-1}
#' \boldsymbol{\sigma}_{yx}, \quad \beta^{\ast}_{j} = \beta_{j}
#' \frac{\sigma_{x_{j}}}{\sigma_{y}},}
#' where \eqn{\sigma_{x_{j}}} is the standard deviation of regressor \eqn{j}.
#' With `std_y = FALSE`, \eqn{\sigma_{y}} is replaced by one;
#' for a regressor left out of `std_x`, \eqn{\sigma_{x_{j}}} is replaced by one.
#'
#' By the delta method,
#' the sampling covariance matrix of \eqn{\hat{\boldsymbol{\beta}}^{\ast}} is
#' \deqn{\widehat{\operatorname{var}} \left( \hat{\boldsymbol{\beta}}^{\ast}
#' \right) = \frac{1}{n} \boldsymbol{J} \hat{\boldsymbol{\Gamma}}
#' \boldsymbol{J}^{\prime}, \quad \boldsymbol{J} = \frac{\partial
#' \boldsymbol{\beta}^{\ast}}{\partial \operatorname{vech} \left(
#' \boldsymbol{\Sigma} \right)^{\prime}},}
#' where \eqn{\boldsymbol{J}} is evaluated at the sample covariance matrix
#' \eqn{\boldsymbol{S}},
#' and \eqn{\hat{\boldsymbol{\Gamma}}} (`gamma`) estimates the asymptotic
#' covariance matrix of \eqn{\sqrt{n} \operatorname{vech} \left( \boldsymbol{S}
#' \right)}.
#' With `type = "mvn"`,
#' \deqn{\hat{\boldsymbol{\Gamma}} = 2 \boldsymbol{D}^{+} \left( \boldsymbol{S}
#' \otimes \boldsymbol{S} \right) \boldsymbol{D}^{+ \prime},}
#' where \eqn{\boldsymbol{D}^{+}} is the Moore-Penrose inverse of the
#' duplication matrix.
#' With `type = "adf"`, \eqn{\hat{\boldsymbol{\Gamma}}} is the unbiased
#' asymptotic distribution-free estimator
#' \deqn{\hat{\boldsymbol{\Gamma}} = \frac{n \left( n - 1 \right)}{\left( n - 2
#' \right) \left( n - 3 \right)} \hat{\boldsymbol{\Gamma}}_{\mathrm{ADF}} -
#' \frac{n}{\left( n - 2 \right) \left( n - 3 \right)} \left(
#' \hat{\boldsymbol{\Gamma}}_{\mathrm{N}} - \frac{2}{n - 1} \operatorname{vech}
#' \left( \tilde{\boldsymbol{S}} \right) \operatorname{vech} \left(
#' \tilde{\boldsymbol{S}} \right)^{\prime} \right),}
#' where \eqn{\tilde{\boldsymbol{S}}} is the covariance matrix with divisor
#' \eqn{n},
#' \eqn{\hat{\boldsymbol{\Gamma}}_{\mathrm{N}}} is the normal-theory matrix
#' at \eqn{\tilde{\boldsymbol{S}}}, and
#' \deqn{\hat{\boldsymbol{\Gamma}}_{\mathrm{ADF}} = \frac{1}{n}
#' \sum_{i = 1}^{n} \left[ \operatorname{vech} \left( \boldsymbol{d}_{i}
#' \boldsymbol{d}_{i}^{\prime} \right) - \operatorname{vech} \left(
#' \tilde{\boldsymbol{S}} \right) \right] \left[ \operatorname{vech} \left(
#' \boldsymbol{d}_{i} \boldsymbol{d}_{i}^{\prime} \right) - \operatorname{vech}
#' \left( \tilde{\boldsymbol{S}} \right) \right]^{\prime},}
#' with \eqn{\boldsymbol{d}_{i}} the deviation of observation \eqn{i} from the
#' sample means (Jones & Waller, 2015; Yuan & Chan, 2011).
#' The confidence intervals are
#' \eqn{\hat{\beta}^{\ast}_{j} \pm t_{1 - \alpha / 2, n - k}
#' \widehat{\operatorname{se}} \left( \hat{\beta}^{\ast}_{j} \right)},
#' where \eqn{k} is the number of regression parameters,
#' including the intercept.
#'
#' @return Returns an object
#'   of class `betadelta` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{lm_process}{Processed `lm` object.}
#'     \item{gamma}{Asymptotic covariance matrix
#'       of the sample covariance matrix.}
#'     \item{acov}{Asymptotic covariance matrix
#'       of the standardized slopes.}
#'     \item{vcov}{Sampling covariance matrix
#'       of the standardized slopes.}
#'     \item{est}{Vector of standardized slopes.}
#'   }
#'
#' @param object Object of class `lm`.
#' @param type Character string.
#'   If `type = "mvn"`,
#'   use the multivariate normal-theory approach.
#'   If `type = "adf"`,
#'   use the asymptotic distribution-free approach.
#' @param std_y Logical.
#'   Standardize \eqn{y}.
#'   With `std_y = FALSE`, \eqn{y} is left in its original units
#'   (\eqn{b_j \sigma_{x_j}}).
#' @param std_x Character vector or `NULL`.
#'   Names of the regressors to standardize.
#'   `NULL` (default) standardizes all regressors;
#'   `character(0)` standardizes none (\eqn{b_j / \sigma_y}).
#'   Leaving a dummy variable out keeps its 0-1 contrast.
#'   The delta method accounts for the sampling variability
#'   of the standard deviations.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
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
#' @examples
#' # Data ---------------------------------------------------------------------
#' data("nas1982", package = "betaDelta")
#'
#' # Fit Model in lm ----------------------------------------------------------
#' object <- stats::lm(
#'   formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
#'   data = nas1982
#' )
#'
#' # BetaDelta ----------------------------------------------------------------
#' std <- BetaDelta(object = object)
#'
#' ## Methods -----------------------------------------------------------------
#' print(x = std)
#' summary(object = std)
#' coef(object = std)
#' vcov(object = std)
#' confint(object = std, level = 0.95)
#'
#' @family Beta Delta Method Functions
#' @keywords betaDelta std
#' @export
BetaDelta <- function(object,
                      type = "mvn",
                      alpha = c(0.05, 0.01, 0.001),
                      std_y = TRUE,
                      std_x = NULL) {
  stopifnot(
    inherits(
      x = object,
      what = "lm"
    )
  )
  stopifnot(
    type %in% c(
      "mvn",
      "adf"
    )
  )
  lm_process <- .ProcessLM(object = object)
  index <- .BetaStarSelectIndex(
    std_x = std_x,
    xnames = lm_process$xnames
  )
  std <- .BetaDelta(
    lm_process = lm_process,
    type = type,
    std_y = std_y,
    std_x = index
  )
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      type = type,
      alpha = alpha,
      std_y = std_y,
      std_x = std_x
    ),
    lm_process = lm_process,
    gamma = std$gamma,
    acov = std$acov,
    vcov = std$vcov,
    est = std$est
  )
  attributes(x = out)$std <- std_y && all(index)
  attributes(x = out)$mi <- FALSE
  class(x = out) <- c(
    "betadelta",
    class(x = out)
  )
  out
}
