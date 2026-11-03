# Estimate R-Squared and Adjusted R-Squared and the Corresponding Sampling Covariance Matrix

Estimate R-Squared and Adjusted R-Squared and the Corresponding Sampling
Covariance Matrix

## Usage

``` r
RSqDelta(object, alpha = c(0.05, 0.01, 0.001))
```

## Arguments

- object:

  Object of class `betadelta`, that is, the output of the
  [`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)
  function.

- alpha:

  Numeric vector. Significance level \\(\alpha\\).

## Value

Returns an object of class `esdelta` which is a list with the following
elements:

- call:

  Function call.

- fit:

  The argument `object`.

- args:

  Function arguments.

- vcov:

  Sampling covariance matrix of R-squared and adjusted R-squared.

- est:

  Vector of R-squared and adjusted R-squared.

- fun:

  Function used ("RSqDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free).

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/PCorDelta.md),
[`SCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- RSqDelta(std)
# Methods -------------------------------------------------------
print(out)
#> Call:
#> RSqDelta(object = std)
#> 
#> R-squared and adjusted R-squared with MVN standard errors:
#>        est     se       z p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 15.5608 0 0.6344 0.6714 0.7032 0.9059 0.9377 0.9747
#> adj 0.7906 0.0554 14.2713 0 0.6083 0.6479 0.6820 0.8991 0.9333 0.9728
summary(out)
#> Call:
#> RSqDelta(object = std)
#> 
#> R-squared and adjusted R-squared with MVN standard errors:
#>        est     se       z p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 15.5608 0 0.6344 0.6714 0.7032 0.9059 0.9377 0.9747
#> adj 0.7906 0.0554 14.2713 0 0.6083 0.6479 0.6820 0.8991 0.9333 0.9728
coef(out)
#>       rsq       adj 
#> 0.8045263 0.7905638 
vcov(out)
#>             rsq         adj
#> rsq 0.002673125 0.002864062
#> adj 0.002864062 0.003068638
confint(out, level = 0.95)
#>         2.5 %    97.5 %
#> rsq 0.7031917 0.9058608
#> adj 0.6819911 0.8991366
```
