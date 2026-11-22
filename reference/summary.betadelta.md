# Summary Method for an Object of Class `betadelta`

Summary Method for an Object of Class `betadelta`

## Usage

``` r
# S3 method for class 'betadelta'
summary(object, alpha = NULL, digits = 4, ...)
```

## Arguments

- object:

  Object of class `betadelta`.

- alpha:

  Numeric vector. Significance level \\(\alpha\\). If `alpha = NULL`,
  use the argument `alpha` used in `object`.

- digits:

  Digits to print.

- ...:

  additional arguments.

## Value

Returns a matrix of standardized regression slopes, standard errors,
test statistics, degrees of freedom, p-values, and confidence intervals.

## Details

The confidence intervals are \\(\hat{\theta} \pm t\_{1 - \alpha / 2, n -
k} \widehat{\operatorname{se}} \left( \hat{\theta} \right)\\), where
\\(\widehat{\operatorname{se}}\\) is the square root of the diagonal of
the delta-method sampling covariance matrix (see
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)),
\\(n\\) is the sample size, and \\(k\\) is the number of regression
parameters, including the intercept. The test statistic is
\\(\hat{\theta} / \widehat{\operatorname{se}} \left( \hat{\theta}
\right)\\) with \\(n - k\\) degrees of freedom.

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
```
