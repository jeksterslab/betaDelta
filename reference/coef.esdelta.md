# Estimates for an Object of Class `esdelta`

Estimates for an Object of Class `esdelta`

## Usage

``` r
# S3 method for class 'esdelta'
coef(object, ...)
```

## Arguments

- object:

  Object of class `esdelta`.

- ...:

  additional arguments.

## Value

Returns a vector of estimates.

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
coef(object = out)
#>       rsq       adj 
#> 0.8045263 0.7905638 
```
