# Confidence Intervals for Standardized Regression Slopes

Confidence Intervals for Standardized Regression Slopes

## Usage

``` r
# S3 method for class 'betadelta'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  Object of class `betadelta`.

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required.

- ...:

  additional arguments.

## Value

Returns a matrix of confidence intervals.

## Details

The confidence intervals are \\(\hat{\theta} \pm t\_{1 - \alpha / 2, n -
k} \widehat{\operatorname{se}} \left( \hat{\theta} \right)\\), where
\\(\widehat{\operatorname{se}}\\) is the square root of the diagonal of
the delta-method sampling covariance matrix (see
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)),
\\(n\\) is the sample size, and \\(k\\) is the number of regression
parameters, including the intercept. The test statistic is
\\(\hat{\theta} / \widehat{\operatorname{se}} \left( \hat{\theta}
\right)\\) with \\(n - k\\) degrees of freedom.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaDelta")

# Fit Model in lm ----------------------------------------------------------
object <- stats::lm(
  formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
  data = nas1982
)

# BetaDelta ----------------------------------------------------------------
std <- BetaDelta(object = object)

## Methods -----------------------------------------------------------------
confint(object = std, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.3420563 0.6482339
#> PCTGRT  0.2360380 0.5469395
#> PCTSUPP 0.1124272 0.4140682
```
