# Print Method for an Object of Class `summary.esdelta`

Print Method for an Object of Class `summary.esdelta`

## Usage

``` r
# S3 method for class 'summary.esdelta'
print(x, ...)
```

## Arguments

- x:

  Object of class `summary.esdelta`.

- ...:

  additional arguments.

## Value

Prints a matrix of estimates, standard errors, test statistics,
p-values, and confidence intervals.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- RSqDelta(std)
summary(out)
#> Call:
#> RSqDelta(object = std)
#> 
#> R-squared and adjusted R-squared with MVN standard errors:
#>        est     se       z p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 15.5608 0 0.6344 0.6714 0.7032 0.9059 0.9377 0.9747
#> adj 0.7906 0.0554 14.2713 0 0.6083 0.6479 0.6820 0.8991 0.9333 0.9728
```
