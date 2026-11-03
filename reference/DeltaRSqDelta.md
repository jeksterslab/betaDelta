# Estimate Improvement in R-Squared and the Corresponding Sampling Covariance Matrix

Estimate Improvement in R-Squared and the Corresponding Sampling
Covariance Matrix

## Usage

``` r
DeltaRSqDelta(object, alpha = c(0.05, 0.01, 0.001))
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

  Sampling covariance matrix of improvement in R-squared (squared
  semipartial correlation coefficients).

- est:

  Vector of improvement in R-squared (squared semipartial correlation
  coefficients).

- fun:

  Function used ("DeltaRSqDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free). Two or
more regressors are required.

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md),
[`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/PCorDelta.md),
[`RSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- DeltaRSqDelta(std)
# Methods -------------------------------------------------------
print(out)
#> Call:
#> DeltaRSqDelta(object = std)
#> 
#> Improvement in R-squared with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%    2.5%  97.5%  99.5%
#> NARTIC  0.1859 0.0666 2.7925 0.0052 -0.0332  0.0144  0.0554 0.3164 0.3574
#> PCTGRT  0.1177 0.0509 2.3112 0.0208 -0.0499 -0.0135  0.0179 0.2174 0.2488
#> PCTSUPP 0.0569 0.0335 1.6979 0.0895 -0.0533 -0.0294 -0.0088 0.1225 0.1432
#>         99.95%
#> NARTIC  0.4049
#> PCTGRT  0.2852
#> PCTSUPP 0.1671
summary(out)
#> Call:
#> DeltaRSqDelta(object = std)
#> 
#> Improvement in R-squared with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%    2.5%  97.5%  99.5%
#> NARTIC  0.1859 0.0666 2.7925 0.0052 -0.0332  0.0144  0.0554 0.3164 0.3574
#> PCTGRT  0.1177 0.0509 2.3112 0.0208 -0.0499 -0.0135  0.0179 0.2174 0.2488
#> PCTSUPP 0.0569 0.0335 1.6979 0.0895 -0.0533 -0.0294 -0.0088 0.1225 0.1432
#>         99.95%
#> NARTIC  0.4049
#> PCTGRT  0.2852
#> PCTSUPP 0.1671
coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.1858925 0.1176542 0.0568722 
vcov(out)
#>                NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.0044312888 -0.0008495891 -0.0004238760
#> PCTGRT  -0.0008495891  0.0025913464 -0.0002900515
#> PCTSUPP -0.0004238760 -0.0002900515  0.0011220018
confint(out, level = 0.95)
#>                2.5 %    97.5 %
#> NARTIC   0.055421734 0.3163632
#> PCTGRT   0.017881671 0.2174267
#> PCTSUPP -0.008779331 0.1225237
```
