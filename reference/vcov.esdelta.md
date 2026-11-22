# Sampling Covariance Matrix for an Object of Class `esdelta`

Sampling Covariance Matrix for an Object of Class `esdelta`

## Usage

``` r
# S3 method for class 'esdelta'
vcov(object, ...)
```

## Arguments

- object:

  Object of class `esdelta`.

- ...:

  additional arguments.

## Value

Returns a matrix of the variance-covariance matrix of the estimates.

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
vcov(object = out)
#>             rsq         adj
#> rsq 0.002673125 0.002864062
#> adj 0.002864062 0.003068638
```
