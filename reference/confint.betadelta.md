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

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
confint(std, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.3420563 0.6482339
#> PCTGRT  0.2360380 0.5469395
#> PCTSUPP 0.1124272 0.4140682
```
