# Sampling Covariance Matrix of the Standardized Regression Slopes

Sampling Covariance Matrix of the Standardized Regression Slopes

## Usage

``` r
# S3 method for class 'betadelta'
vcov(object, ...)
```

## Arguments

- object:

  Object of class `betadelta`.

- ...:

  additional arguments.

## Value

Returns a matrix of the variance-covariance matrix of standardized
slopes.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
vcov(std)
#>               NARTIC       PCTGRT      PCTSUPP
#> NARTIC   0.005754524 -0.003360334 -0.002166127
#> PCTGRT  -0.003360334  0.005933462 -0.001769723
#> PCTSUPP -0.002166127 -0.001769723  0.005585256
```
