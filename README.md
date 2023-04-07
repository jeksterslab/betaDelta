betaDelta
================
Ivan Jacob Agaloos Pesigan
2023-04-07

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![CRAN
Status](https://www.r-pkg.org/badges/version/betaDelta)](https://cran.r-project.org/package=betaDelta)
[![R-Universe
Status](https://jeksterslab.r-universe.dev/badges/betaDelta)](https://jeksterslab.r-universe.dev)
[![R-CMD-check](https://github.com/jeksterslab/betaDelta/workflows/R-CMD-check/badge.svg)](https://github.com/jeksterslab/betaDelta/actions)
[![test-coverage](https://github.com/jeksterslab/betaDelta/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/jeksterslab/betaDelta/actions/workflows/test-coverage.yaml)
[![lint](https://github.com/jeksterslab/betaDelta/actions/workflows/lint.yaml/badge.svg)](https://github.com/jeksterslab/betaDelta/actions/workflows/lint.yaml)
[![codecov](https://codecov.io/gh/jeksterslab/betaDelta/branch/main/graph/badge.svg?token=KVLUET3DJ6)](https://codecov.io/gh/jeksterslab/betaDelta)
<!-- badges: end -->

## Description

Generates confidence intervals for standardized regression coefficients
using delta method standard errors for models fitted by `lm()` as
described in Yuan and Chan (2011:
<http://doi.org/10.1007/s11336-011-9224-6>) and Jones and Waller (2015:
<http://doi.org/10.1007/s11336-013-9380-y>). A description of the
package and code examples are presented in Pesigan, Sun, and Cheung
(2023: <https://doi.org/10.1080/00273171.2023.2201277>).

## Installation

You can install the CRAN release of `betaDelta` with:

``` r
install.packages("betaDelta")
```

You can install the development version of `betaDelta` from
[GitHub](https://github.com/jeksterslab/betaDelta) with:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("jeksterslab/betaDelta")
```

## Example

In this example, a multiple regression model is fitted using program
quality ratings (`QUALITY`) as the regressand/outcome variable and
number of published articles attributed to the program faculty members
(`NARTIC`), percent of faculty members holding research grants
(`PCTGRT`), and percentage of program graduates who received support
(`PCTSUPP`) as regressor/predictor variables using a data set from 1982
ratings of 46 doctoral programs in psychology in the USA (National
Research Council, 1982). Confidence intervals for the standardized
regression coefficients are generated using the `BetaDelta()` function
from the `betaDelta` package following Yuan and Chan (2011) and Jones
and Waller (2015).

``` r
library(betaDelta)
```

``` r
df <- betaDelta::nas1982
```

### Fit the regression model using the `lm()` function.

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = df)
```

### Estimate the standardized regression slopes and the corresponding sampling covariance matrix.

#### Multivariate Normal-Theory Approach

``` r
BetaDelta(object, type = "mvn")
#> Call:
#> BetaDelta(object = object, type = "mvn")
#> 
#> Standardized regression slopes with MVN standard errors:
#>            est     se      t     p   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0759 6.5272 0.000  0.2268 0.2905 0.3421 0.6482 0.6998 0.7635
#> PCTGRT  0.3915 0.0770 5.0824 0.000  0.1190 0.1837 0.2360 0.5469 0.5993 0.6640
#> PCTSUPP 0.2632 0.0747 3.5224 0.001 -0.0011 0.0616 0.1124 0.4141 0.4649 0.5276
```

#### Asymptotic Distribution-Free Approach

``` r
BetaDelta(object, type = "adf")
#> Call:
#> BetaDelta(object = object, type = "adf")
#> 
#> Standardized regression slopes with ADF standard errors:
#>            est     se      t      p   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0674 7.3490 0.0000  0.2568 0.3134 0.3592 0.6311 0.6769 0.7335
#> PCTGRT  0.3915 0.0710 5.5164 0.0000  0.1404 0.2000 0.2483 0.5347 0.5830 0.6426
#> PCTSUPP 0.2632 0.0769 3.4231 0.0014 -0.0088 0.0558 0.1081 0.4184 0.4707 0.5353
```

### References

Jones, J. A., & Waller, N. G. (2015). The normal-theory and asymptotic
distribution-free (ADF) covariance matrix of standardized regression
coefficients: Theoretical extensions and finite sample behavior.
*Psychometrika*, *80*(2), 365–378.
<https://doi.org/10.1007/s11336-013-9380-y>

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*.
<https://doi.org/10.17226/9781>. Reproduced with permission from the
National Academy of Sciences, Courtesy of the National Academies Press,
Washington, D.C.

Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023). betaDelta and
betaSandwich: Confidence intervals for standardized regression
coefficients in R. *Multivariate Behavioral Research*.
<https://doi.org/10.1080/00273171.2023.2201277>

Yuan, K.-H., & Chan, W. (2011). Biases and standard errors of
standardized regression coefficients. *Psychometrika*, *76*(4), 670–690.
<https://doi.org/10.1007/s11336-011-9224-6>

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaDelta/index.html)
for package documentation.
