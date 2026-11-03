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

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- RSqDelta(std)
confint(out, level = 0.95)
#>         2.5 %    97.5 %
#> rsq 0.7031917 0.9058608
#> adj 0.6819911 0.8991366
```
