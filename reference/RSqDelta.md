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

  Sampling covariance matrix of R-squared and adjusted R-squared.

- est:

  Vector of R-squared and adjusted R-squared.

- fun:

  Function used ("RSqDelta").

## Details

The sampling covariance matrix is obtained by the delta method from the
sampling covariance matrix of the variances and covariances stored in
`object` (normal-theory or asymptotically distribution-free).

Let \\(\boldsymbol{\beta}^{\ast}\\) be the vector of standardized
slopes, \\(\boldsymbol{R}\_{x}\\) the correlation matrix of the
regressors, \\(r^{jj}\\) the \\(j\\)th diagonal element of
\\(\boldsymbol{R}\_{x}^{-1}\\), and \\(R^{2} =
\boldsymbol{\beta}^{\ast\prime} \boldsymbol{R}\_{x}
\boldsymbol{\beta}^{\ast}\\). The R-squared and the adjusted R-squared
are \$\$R^{2} = \boldsymbol{\beta}^{\ast\prime} \boldsymbol{R}\_{x}
\boldsymbol{\beta}^{\ast}, \quad \bar{R}^{2} = 1 - \left( 1 - R^{2}
\right) \frac{n - 1}{n - k},\$\$ where \\(n\\) is the sample size and
\\(k\\) is the number of parameters in the regression model, including
the intercept. For an effect size \\(g\left( \boldsymbol{\theta}^{\ast}
\right)\\) that is a function of the standardized parameters, the
sampling variance is approximated by the delta method,
\$\$\widehat{\operatorname{var}} \left( \hat{g} \right) =
\boldsymbol{J}\_{g} \\,
\widehat{\boldsymbol{\Sigma}}\_{\boldsymbol{\theta}^{\ast}} \\,
\boldsymbol{J}\_{g}^{\prime},\$\$ where \\(\boldsymbol{J}\_{g}\\) is the
Jacobian of \\(g\\) and
\\(\widehat{\boldsymbol{\Sigma}}\_{\boldsymbol{\theta}^{\ast}}\\) is the
sampling covariance matrix stored in `object`
([`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)).

## See also

Other Beta Delta Method Functions:
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md),
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

# RSqDelta -----------------------------------------------------------------
out <- RSqDelta(object = std)

## Methods -----------------------------------------------------------------
print(x = out)
#> Call:
#> RSqDelta(object = std)
#> 
#> R-squared and adjusted R-squared with MVN standard errors:
#>        est     se       z p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 15.5608 0 0.6344 0.6714 0.7032 0.9059 0.9377 0.9747
#> adj 0.7906 0.0554 14.2713 0 0.6083 0.6479 0.6820 0.8991 0.9333 0.9728
summary(object = out)
#> Call:
#> RSqDelta(object = std)
#> 
#> R-squared and adjusted R-squared with MVN standard errors:
#>        est     se       z p  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 15.5608 0 0.6344 0.6714 0.7032 0.9059 0.9377 0.9747
#> adj 0.7906 0.0554 14.2713 0 0.6083 0.6479 0.6820 0.8991 0.9333 0.9728
coef(object = out)
#>       rsq       adj 
#> 0.8045263 0.7905638 
vcov(object = out)
#>             rsq         adj
#> rsq 0.002673125 0.002864062
#> adj 0.002864062 0.003068638
confint(object = out, level = 0.95)
#>         2.5 %    97.5 %
#> rsq 0.7031917 0.9058608
#> adj 0.6819911 0.8991366
```
