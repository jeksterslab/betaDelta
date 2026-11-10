# Estimate Semipartial Correlation Coefficients and the Corresponding Sampling Covariance Matrix

Estimate Semipartial Correlation Coefficients and the Corresponding
Sampling Covariance Matrix

## Usage

``` r
SCorDelta(object, alpha = c(0.05, 0.01, 0.001))
```

## Arguments

- object:

  Object of class `betadelta`, that is, the output of the
  [`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)
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

  Sampling covariance matrix of semipartial correlation coefficients.

- est:

  Vector of semipartial correlation coefficients.

- fun:

  Function used ("SCorDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free). Two or
more regressors are required.

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md),
[`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- SCorDelta(std)
# Methods -------------------------------------------------------
print(out)
#> Call:
#> SCorDelta(object = std)
#> 
#> Semipartial correlations with MVN standard errors:
#>            est     se      z     p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0772 5.5850 0e+00 0.1771 0.2323 0.2798 0.5825 0.6300 0.6852
#> PCTGRT  0.3430 0.0742 4.6225 0e+00 0.0988 0.1519 0.1976 0.4884 0.5341 0.5872
#> PCTSUPP 0.2385 0.0702 3.3957 7e-04 0.0074 0.0576 0.1008 0.3761 0.4194 0.4696
summary(out)
#> Call:
#> SCorDelta(object = std)
#> 
#> Semipartial correlations with MVN standard errors:
#>            est     se      z     p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0772 5.5850 0e+00 0.1771 0.2323 0.2798 0.5825 0.6300 0.6852
#> PCTGRT  0.3430 0.0742 4.6225 0e+00 0.0988 0.1519 0.1976 0.4884 0.5341 0.5872
#> PCTSUPP 0.2385 0.0702 3.3957 7e-04 0.0074 0.0576 0.1008 0.3761 0.4194 0.4696
coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4311525 0.3430075 0.2384789 
vcov(out)
#>               NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.005959479 -0.0014361982 -0.0010306185
#> PCTGRT  -0.001436198  0.0055062785 -0.0008864647
#> PCTSUPP -0.001030619 -0.0008864647  0.0049321187
confint(out, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.2798479 0.5824571
#> PCTGRT  0.1975698 0.4884453
#> PCTSUPP 0.1008325 0.3761253
```
