# Standardized Regression Slopes

Standardized Regression Slopes

## Usage

``` r
# S3 method for class 'betadelta'
coef(object, ...)
```

## Arguments

- object:

  Object of class `betadelta`.

- ...:

  additional arguments.

## Value

Returns a vector of standardized regression slopes.

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
coef(object = std)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4951451 0.3914887 0.2632477 
```
