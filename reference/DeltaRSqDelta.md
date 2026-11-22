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

Let \\(\boldsymbol{\beta}^{\ast}\\) be the vector of standardized
slopes, \\(\boldsymbol{R}\_{x}\\) the correlation matrix of the
regressors, \\(r^{jj}\\) the \\(j\\)th diagonal element of
\\(\boldsymbol{R}\_{x}^{-1}\\), and \\(R^{2} =
\boldsymbol{\beta}^{\ast\prime} \boldsymbol{R}\_{x}
\boldsymbol{\beta}^{\ast}\\). The semipartial correlation of regressor
\\(j\\) is \$\$sr\_{j} = \beta^{\ast}\_{j} / \sqrt{r^{jj}} =
\beta^{\ast}\_{j} \sqrt{1 - R^{2}\_{j \cdot -j}},\$\$ where \\(R^{2}\_{j
\cdot -j}\\) is the R-squared from regressing regressor \\(j\\) on the
other regressors. Its square, \\(sr^{2}\_{j}\\), is the change in
\\(R^{2}\\) when regressor \\(j\\) is added last. Because \\(1 / r^{jj}
= 1 - R^{2}\_{j \cdot -j}\\), \\(sr\_{j}\\) shrinks toward zero as
regressor \\(j\\) becomes more redundant with the other regressors. The
improvement in R-squared for regressor \\(j\\) is \$\$\Delta R^{2}\_{j}
= R^{2} - R^{2}\_{-j} = sr^{2}\_{j}.\$\$ For an effect size \\(g\left(
\boldsymbol{\theta}^{\ast} \right)\\) that is a function of the
standardized parameters, the sampling variance is approximated by the
delta method, \$\$\widehat{\operatorname{var}} \left( \hat{g} \right) =
\boldsymbol{J}\_{g} \\,
\widehat{\boldsymbol{\Sigma}}\_{\boldsymbol{\theta}^{\ast}} \\,
\boldsymbol{J}\_{g}^{\prime},\$\$ where \\(\boldsymbol{J}\_{g}\\) is the
Jacobian of \\(g\\) and
\\(\widehat{\boldsymbol{\Sigma}}\_{\boldsymbol{\theta}^{\ast}}\\) is the
sampling covariance matrix stored in `object`
([`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)).

## References

Algina, J., Keselman, H. J., & Penfield, R. D. (2007). Confidence
intervals for an effect size measure in multiple linear regression.
*Educational and Psychological Measurement*, *67*(2), 207–218.
[doi:10.1177/0013164406292030](https://doi.org/10.1177/0013164406292030)

Algina, J., Keselman, H. J., & Penfield, R. D. (2008a). Confidence
intervals for the squared multiple semipartial correlation coefficient.
*Journal of Modern Applied Statistical Methods*, *7*(1), 2–10.
[doi:10.22237/jmasm/1209614460](https://doi.org/10.22237/jmasm/1209614460)

Algina, J., Keselman, H. J., & Penfield, R. D. (2008b). Note on a
confidence interval for the squared semipartial correlation coefficient.
*Educational and Psychological Measurement*, *68*(5), 734–741.
[doi:10.1177/0013164407313371](https://doi.org/10.1177/0013164407313371)

Algina, J., Keselman, H. J., & Penfield, R. D. (2010). Confidence
intervals for squared semipartial correlation coefficients: The effect
of nonnormality. *Educational and Psychological Measurement*, *70*(6),
926–940.
[doi:10.1177/0013164410379335](https://doi.org/10.1177/0013164410379335)

## See also

Other Beta Delta Method Functions:
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md),
[`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md),
[`SCorSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorSqDelta.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaDelta")

# Fit Model in lm ----------------------------------------------------------
object <- stats::lm(
  formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
  data = nas1982
)

# BetaDelta ----------------------------------------------------------------
std <- BetaDelta(object = object)

# DeltaRSqDelta ------------------------------------------------------------
out <- DeltaRSqDelta(object = std)

## Methods -----------------------------------------------------------------
print(x = out)
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
summary(object = out)
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
coef(object = out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.1858925 0.1176542 0.0568722 
vcov(object = out)
#>                NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.0044312888 -0.0008495891 -0.0004238760
#> PCTGRT  -0.0008495891  0.0025913464 -0.0002900515
#> PCTSUPP -0.0004238760 -0.0002900515  0.0011220018
confint(object = out, level = 0.95)
#>                2.5 %    97.5 %
#> NARTIC   0.055421734 0.3163632
#> PCTGRT   0.017881671 0.2174267
#> PCTSUPP -0.008779331 0.1225237
```
