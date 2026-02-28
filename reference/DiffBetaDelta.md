# Estimate Differences of Standardized Slopes and the Corresponding Sampling Covariance Matrix

Estimate Differences of Standardized Slopes and the Corresponding
Sampling Covariance Matrix

## Usage

``` r
DiffBetaDelta(object, alpha = c(0.05, 0.01, 0.001))
```

## Arguments

- object:

  Object of class `betadelta`, that is, the output of the
  [`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)
  function.

- alpha:

  Numeric vector. Significance level \\\alpha\\.

## Value

Returns an object of class `diffbetadelta` which is a list with the
following elements:

- call:

  Function call.

- fit:

  The argument `object`.

- args:

  Function arguments.

- vcov:

  Sampling covariance matrix of differences of standardized slopes.

- est:

  Vector of differences of standardized slopes.

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
diff <- DiffBetaDelta(std)
# Methods -------------------------------------------------------
print(diff)
#> Call:
#> DiffBetaDelta(object = std)
#> 
#> Difference between standardized regression coefficients with MVN standard errors:
#>                   est     se      z      p   0.05%    0.5%    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1357 0.7640 0.4449 -0.3428 -0.2458 -0.1623 0.3696
#> NARTIC-PCTSUPP 0.2319 0.1252 1.8524 0.0640 -0.1800 -0.0906 -0.0135 0.4773
#> PCTGRT-PCTSUPP 0.1282 0.1227 1.0451 0.2960 -0.2755 -0.1878 -0.1123 0.3688
#>                 99.5% 99.95%
#> NARTIC-PCTGRT  0.4531 0.5501
#> NARTIC-PCTSUPP 0.5544 0.6438
#> PCTGRT-PCTSUPP 0.4443 0.5320
summary(diff)
#> Call:
#> DiffBetaDelta(object = std)
#> 
#> Difference between standardized regression coefficients with MVN standard errors:
#>                   est     se      z      p   0.05%    0.5%    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1357 0.7640 0.4449 -0.3428 -0.2458 -0.1623 0.3696
#> NARTIC-PCTSUPP 0.2319 0.1252 1.8524 0.0640 -0.1800 -0.0906 -0.0135 0.4773
#> PCTGRT-PCTSUPP 0.1282 0.1227 1.0451 0.2960 -0.2755 -0.1878 -0.1123 0.3688
#>                 99.5% 99.95%
#> NARTIC-PCTGRT  0.4531 0.5501
#> NARTIC-PCTSUPP 0.5544 0.6438
#> PCTGRT-PCTSUPP 0.4443 0.5320
coef(diff)
#>  NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP 
#>      0.1036564      0.2318974      0.1282410 
vcov(diff)
#>                NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP
#> NARTIC-PCTGRT    0.018408653    0.009511262   -0.008897391
#> NARTIC-PCTSUPP   0.009511262    0.015672035    0.006160773
#> PCTGRT-PCTSUPP  -0.008897391    0.006160773    0.015058164
confint(diff, level = 0.95)
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.16226855 0.3695814
#> NARTIC-PCTSUPP -0.01346652 0.4772614
#> PCTGRT-PCTSUPP -0.11226950 0.3687516
```
