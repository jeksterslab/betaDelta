# Estimate Cohen's f-Squared and Local f-Squared and the Corresponding Sampling Covariance Matrix

Estimate Cohen's f-Squared and Local f-Squared and the Corresponding
Sampling Covariance Matrix

## Usage

``` r
FSqDelta(object, alpha = c(0.05, 0.01, 0.001))
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

  Sampling covariance matrix of Cohen's f-squared (fsq) and the local
  f-squared of each regressor.

- est:

  Vector of Cohen's f-squared (fsq) and the local f-squared of each
  regressor.

- fun:

  Function used ("FSqDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free).

## See also

Other Beta Delta Functions:
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md),
[`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
out <- FSqDelta(std)
# Methods -------------------------------------------------------
print(out)
#> Call:
#> FSqDelta(object = std)
#> 
#> Cohen's f-squared (fsq) and local f-squared with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%    2.5%  97.5%  99.5%
#> fsq     4.1158 1.3531 3.0417 0.0024 -0.3367  0.6304  1.4637 6.7678 7.6012
#> NARTIC  0.9510 0.4017 2.3676 0.0179 -0.3707 -0.0836  0.1637 1.7382 1.9856
#> PCTGRT  0.6019 0.2896 2.0787 0.0376 -0.3509 -0.1439  0.0344 1.1694 1.3477
#> PCTSUPP 0.2909 0.1807 1.6099 0.1074 -0.3037 -0.1746 -0.0633 0.6452 0.7565
#>         99.95%
#> fsq     8.5682
#> NARTIC  2.2727
#> PCTGRT  1.5547
#> PCTSUPP 0.8856
summary(out)
#> Call:
#> FSqDelta(object = std)
#> 
#> Cohen's f-squared (fsq) and local f-squared with MVN standard errors:
#>            est     se      z      p   0.05%    0.5%    2.5%  97.5%  99.5%
#> fsq     4.1158 1.3531 3.0417 0.0024 -0.3367  0.6304  1.4637 6.7678 7.6012
#> NARTIC  0.9510 0.4017 2.3676 0.0179 -0.3707 -0.0836  0.1637 1.7382 1.9856
#> PCTGRT  0.6019 0.2896 2.0787 0.0376 -0.3509 -0.1439  0.0344 1.1694 1.3477
#> PCTSUPP 0.2909 0.1807 1.6099 0.1074 -0.3037 -0.1746 -0.0633 0.6452 0.7565
#>         99.95%
#> fsq     8.5682
#> NARTIC  2.2727
#> PCTGRT  1.5547
#> PCTSUPP 0.8856
coef(out)
#>       fsq    NARTIC    PCTGRT   PCTSUPP 
#> 4.1157764 0.9509843 0.6018924 0.2909455 
vcov(out)
#>                fsq      NARTIC        PCTGRT       PCTSUPP
#> fsq     1.83090366 0.292190379  0.1757962533  0.0810437672
#> NARTIC  0.29219038 0.161335262  0.0047781399  0.0012330834
#> PCTGRT  0.17579625 0.004778140  0.0838405969 -0.0003089663
#> PCTSUPP 0.08104377 0.001233083 -0.0003089663  0.0326604105
confint(out, level = 0.95)
#>               2.5 %    97.5 %
#> fsq      1.46373175 6.7678211
#> NARTIC   0.16373420 1.7382345
#> PCTGRT   0.03438011 1.1694047
#> PCTSUPP -0.06326298 0.6451539
```
