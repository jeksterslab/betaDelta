# Confidence Intervals for Differences of Standardized Regression Slopes

Confidence Intervals for Differences of Standardized Regression Slopes

## Usage

``` r
# S3 method for class 'diffbetadelta'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  Object of class `diffbetadelta`.

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
diff <- DiffBetaDelta(std)
confint(diff)
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.16226855 0.3695814
#> NARTIC-PCTSUPP -0.01346652 0.4772614
#> PCTGRT-PCTSUPP -0.11226950 0.3687516
```
