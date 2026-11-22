# Confidence Intervals for an Object of Class `esdelta`

Confidence Intervals for an Object of Class `esdelta`

## Usage

``` r
# S3 method for class 'esdelta'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  Object of class `esdelta`.

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

The confidence intervals are \\(\hat{\theta} \pm z\_{1 - \alpha / 2}
\widehat{\operatorname{se}} \left( \hat{\theta} \right)\\), where
\\(\widehat{\operatorname{se}}\\) is the square root of the diagonal of
the delta-method sampling covariance matrix of the effect size, and
\\(z\_{p}\\) is the \\(p\\) quantile of the standard normal
distribution. The test statistic is \\(z = \hat{\theta} /
\widehat{\operatorname{se}} \left( \hat{\theta} \right)\\).

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

# RSqDelta -----------------------------------------------------------------
out <- RSqDelta(object = std)

## Methods -----------------------------------------------------------------
confint(object = out, level = 0.95)
#>         2.5 %    97.5 %
#> rsq 0.7031917 0.9058608
#> adj 0.6819911 0.8991366
```
