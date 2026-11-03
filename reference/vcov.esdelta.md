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
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- RSqDelta(std)
vcov(out)
#>             rsq         adj
#> rsq 0.002673125 0.002864062
#> adj 0.002864062 0.003068638
```
