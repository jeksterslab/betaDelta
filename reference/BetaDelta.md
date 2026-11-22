# Estimate Standardized Regression Coefficients and the Corresponding Sampling Covariance Matrix

Estimate Standardized Regression Coefficients and the Corresponding
Sampling Covariance Matrix

## Usage

``` r
BetaDelta(
  object,
  type = "mvn",
  alpha = c(0.05, 0.01, 0.001),
  std_y = TRUE,
  std_x = NULL
)
```

## Arguments

- object:

  Object of class `lm`.

- type:

  Character string. If `type = "mvn"`, use the multivariate
  normal-theory approach. If `type = "adf"`, use the asymptotic
  distribution-free approach.

- alpha:

  Numeric vector. Significance level \\(\alpha\\).

- std_y:

  Logical. Standardize \\(y\\). With `std_y = FALSE`, \\(y\\) is left in
  its original units (\\(b_j \sigma\_{x_j}\\)).

- std_x:

  Character vector or `NULL`. Names of the regressors to standardize.
  `NULL` (default) standardizes all regressors; `character(0)`
  standardizes none (\\(b_j / \sigma_y\\)). Leaving a dummy variable out
  keeps its 0-1 contrast. The delta method accounts for the sampling
  variability of the standard deviations.

## Value

Returns an object of class `betadelta` which is a list with the
following elements:

- call:

  Function call.

- args:

  Function arguments.

- lm_process:

  Processed `lm` object.

- gamma:

  Asymptotic covariance matrix of the sample covariance matrix.

- acov:

  Asymptotic covariance matrix of the standardized slopes.

- vcov:

  Sampling covariance matrix of the standardized slopes.

- est:

  Vector of standardized slopes.

## Details

Partition the covariance matrix of the outcome and the regressors as
\$\$\boldsymbol{\Sigma} = \begin{pmatrix} \sigma^{2}\_{y} &
\boldsymbol{\sigma}\_{yx}^{\prime} \\\\ \boldsymbol{\sigma}\_{yx} &
\boldsymbol{\Sigma}\_{x} \end{pmatrix}.\$\$ The regression slopes and
the standardized regression slopes are \$\$\boldsymbol{\beta} =
\boldsymbol{\Sigma}\_{x}^{-1} \boldsymbol{\sigma}\_{yx}, \quad
\beta^{\ast}\_{j} = \beta\_{j} \frac{\sigma\_{x\_{j}}}{\sigma\_{y}},\$\$
where \\(\sigma\_{x\_{j}}\\) is the standard deviation of regressor
\\(j\\). With `std_y = FALSE`, \\(\sigma\_{y}\\) is replaced by one; for
a regressor left out of `std_x`, \\(\sigma\_{x\_{j}}\\) is replaced by
one.

By the delta method, the sampling covariance matrix of
\\(\hat{\boldsymbol{\beta}}^{\ast}\\) is
\$\$\widehat{\operatorname{var}} \left( \hat{\boldsymbol{\beta}}^{\ast}
\right) = \frac{1}{n} \boldsymbol{J} \hat{\boldsymbol{\Gamma}}
\boldsymbol{J}^{\prime}, \quad \boldsymbol{J} = \frac{\partial
\boldsymbol{\beta}^{\ast}}{\partial \operatorname{vech} \left(
\boldsymbol{\Sigma} \right)^{\prime}},\$\$ where \\(\boldsymbol{J}\\) is
evaluated at the sample covariance matrix \\(\boldsymbol{S}\\), and
\\(\hat{\boldsymbol{\Gamma}}\\) (`gamma`) estimates the asymptotic
covariance matrix of \\(\sqrt{n} \operatorname{vech} \left(
\boldsymbol{S} \right)\\). With `type = "mvn"`,
\$\$\hat{\boldsymbol{\Gamma}} = 2 \boldsymbol{D}^{+} \left(
\boldsymbol{S} \otimes \boldsymbol{S} \right) \boldsymbol{D}^{+
\prime},\$\$ where \\(\boldsymbol{D}^{+}\\) is the Moore-Penrose inverse
of the duplication matrix. With `type = "adf"`,
\\(\hat{\boldsymbol{\Gamma}}\\) is the unbiased asymptotic
distribution-free estimator \$\$\hat{\boldsymbol{\Gamma}} = \frac{n
\left( n - 1 \right)}{\left( n - 2 \right) \left( n - 3 \right)}
\hat{\boldsymbol{\Gamma}}\_{\mathrm{ADF}} - \frac{n}{\left( n - 2
\right) \left( n - 3 \right)} \left(
\hat{\boldsymbol{\Gamma}}\_{\mathrm{N}} - \frac{2}{n - 1}
\operatorname{vech} \left( \tilde{\boldsymbol{S}} \right)
\operatorname{vech} \left( \tilde{\boldsymbol{S}} \right)^{\prime}
\right),\$\$ where \\(\tilde{\boldsymbol{S}}\\) is the covariance matrix
with divisor \\(n\\), \\(\hat{\boldsymbol{\Gamma}}\_{\mathrm{N}}\\) is
the normal-theory matrix at \\(\tilde{\boldsymbol{S}}\\), and
\$\$\hat{\boldsymbol{\Gamma}}\_{\mathrm{ADF}} = \frac{1}{n} \sum\_{i =
1}^{n} \left\[ \operatorname{vech} \left( \boldsymbol{d}\_{i}
\boldsymbol{d}\_{i}^{\prime} \right) - \operatorname{vech} \left(
\tilde{\boldsymbol{S}} \right) \right\] \left\[ \operatorname{vech}
\left( \boldsymbol{d}\_{i} \boldsymbol{d}\_{i}^{\prime} \right) -
\operatorname{vech} \left( \tilde{\boldsymbol{S}} \right)
\right\]^{\prime},\$\$ with \\(\boldsymbol{d}\_{i}\\) the deviation of
observation \\(i\\) from the sample means (Jones & Waller, 2015; Yuan &
Chan, 2011). The confidence intervals are \\(\hat{\beta}^{\ast}\_{j} \pm
t\_{1 - \alpha / 2, n - k} \widehat{\operatorname{se}} \left(
\hat{\beta}^{\ast}\_{j} \right)\\), where \\(k\\) is the number of
regression parameters, including the intercept.

## References

Jones, J. A., & Waller, N. G. (2015). The normal-theory and asymptotic
distribution-free (ADF) covariance matrix of standardized regression
coefficients: Theoretical extensions and finite sample behavior.
*Psychometrika*, *80*(2), 365–378.
[doi:10.1007/s11336-013-9380-y](https://doi.org/10.1007/s11336-013-9380-y)

Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023). betaDelta and
betaSandwich: Confidence intervals for standardized regression
coefficients in R. *Multivariate Behavioral Research*.
[doi:10.1080/00273171.2023.2201277](https://doi.org/10.1080/00273171.2023.2201277)

Yuan, K.-H., & Chan, W. (2011). Biases and standard errors of
standardized regression coefficients. *Psychometrika*, *76*(4), 670–690.
[doi:10.1007/s11336-011-9224-6](https://doi.org/10.1007/s11336-011-9224-6)

## See also

Other Beta Delta Method Functions:
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
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

## Methods -----------------------------------------------------------------
print(x = std)
#> Call:
#> BetaDelta(object = object)
#> 
#> Standardized regression slopes with MVN standard errors:
#>            est     se      t df     p   0.05%   0.5%   2.5%  97.5%  99.5%
#> NARTIC  0.4951 0.0759 6.5272 42 0.000  0.2268 0.2905 0.3421 0.6482 0.6998
#> PCTGRT  0.3915 0.0770 5.0824 42 0.000  0.1190 0.1837 0.2360 0.5469 0.5993
#> PCTSUPP 0.2632 0.0747 3.5224 42 0.001 -0.0011 0.0616 0.1124 0.4141 0.4649
#>         99.95%
#> NARTIC  0.7635
#> PCTGRT  0.6640
#> PCTSUPP 0.5276
summary(object = std)
#> Call:
#> BetaDelta(object = object)
#> 
#> Standardized regression slopes with MVN standard errors:
#>            est     se      t df     p   0.05%   0.5%   2.5%  97.5%  99.5%
#> NARTIC  0.4951 0.0759 6.5272 42 0.000  0.2268 0.2905 0.3421 0.6482 0.6998
#> PCTGRT  0.3915 0.0770 5.0824 42 0.000  0.1190 0.1837 0.2360 0.5469 0.5993
#> PCTSUPP 0.2632 0.0747 3.5224 42 0.001 -0.0011 0.0616 0.1124 0.4141 0.4649
#>         99.95%
#> NARTIC  0.7635
#> PCTGRT  0.6640
#> PCTSUPP 0.5276
coef(object = std)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4951451 0.3914887 0.2632477 
vcov(object = std)
#>               NARTIC       PCTGRT      PCTSUPP
#> NARTIC   0.005754524 -0.003360334 -0.002166127
#> PCTGRT  -0.003360334  0.005933462 -0.001769723
#> PCTSUPP -0.002166127 -0.001769723  0.005585256
confint(object = std, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.3420563 0.6482339
#> PCTGRT  0.2360380 0.5469395
#> PCTSUPP 0.1124272 0.4140682
```
