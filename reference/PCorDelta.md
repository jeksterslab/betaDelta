# Estimate Squared Partial Correlation Coefficients and the Corresponding Sampling Covariance Matrix

Estimate Squared Partial Correlation Coefficients and the Corresponding
Sampling Covariance Matrix

## Usage

``` r
PCorDelta(object, alpha = c(0.05, 0.01, 0.001))
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

  Sampling covariance matrix of squared partial correlation
  coefficients.

- est:

  Vector of squared partial correlation coefficients.

- fun:

  Function used ("PCorDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free). Two or
more regressors are required.

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md),
[`RSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- PCorDelta(std)
# Methods -------------------------------------------------------
print(out)
#> Call:
#> PCorDelta(object = std)
#> 
#> Squared partial correlations with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4874 0.1055 4.6192 0.0000  0.1402  0.2156 0.2806 0.6943 0.7593 0.8347
#> PCTGRT  0.3757 0.1128 3.3299 0.0009  0.0044  0.0851 0.1546 0.5969 0.6664 0.7470
#> PCTSUPP 0.2254 0.1084 2.0783 0.0377 -0.1315 -0.0540 0.0128 0.4379 0.5047 0.5822
summary(out)
#> Call:
#> PCorDelta(object = std)
#> 
#> Squared partial correlations with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4874 0.1055 4.6192 0.0000  0.1402  0.2156 0.2806 0.6943 0.7593 0.8347
#> PCTGRT  0.3757 0.1128 3.3299 0.0009  0.0044  0.0851 0.1546 0.5969 0.6664 0.7470
#> PCTSUPP 0.2254 0.1084 2.0783 0.0377 -0.1315 -0.0540 0.0128 0.4379 0.5047 0.5822
coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4874382 0.3757383 0.2253739 
vcov(out)
#>               NARTIC        PCTGRT       PCTSUPP
#> NARTIC  0.0111356142  4.891979e-04  1.943878e-04
#> PCTGRT  0.0004891979  1.273271e-02 -7.224846e-05
#> PCTSUPP 0.0001943878 -7.224846e-05  1.175953e-02
confint(out, level = 0.95)
#>              2.5 %    97.5 %
#> NARTIC  0.28061220 0.6942642
#> PCTGRT  0.15457732 0.5968994
#> PCTSUPP 0.01283274 0.4379151
```
