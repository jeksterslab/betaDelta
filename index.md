# betaDelta

Ivan Jacob Agaloos Pesigan 2026-03-01

## Description

Generates confidence intervals for standardized regression coefficients
using delta method standard errors for models fitted by
[`lm()`](https://rdrr.io/r/stats/lm.html) as described in Yuan and Chan
(2011: <http://doi.org/10.1007/s11336-011-9224-6>) and Jones and Waller
(2015: <http://doi.org/10.1007/s11336-013-9380-y>). The package can also
be used to generate confidence intervals for differences of standardized
regression coefficients and as a general approach to performing the
delta method. A description of the package and code examples are
presented in Pesigan, Sun, and Cheung (2023:
<https://doi.org/10.1080/00273171.2023.2201277>).

## Installation

You can install the CRAN release of `betaDelta` with:

``` r

install.packages("betaDelta")
```

You can install the development version of `betaDelta` from
[GitHub](https://github.com/jeksterslab/betaDelta) with:

``` r

if (!require("pak")) install.packages("pak")
pak::pkg_install("jeksterslab/betaDelta")
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
regression coefficients are generated using the
[`BetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)
function from the `betaDelta` package following Yuan & Chan (2011) and
Jones & Waller (2015).

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

BetaDelta(object, type = "mvn", alpha = 0.05)
#> Call:
#> BetaDelta(object = object, type = "mvn", alpha = 0.05)
#> 
#> Standardized regression slopes with MVN standard errors:
#>            est     se      t df     p   2.5%  97.5%
#> NARTIC  0.4951 0.0759 6.5272 42 0.000 0.3421 0.6482
#> PCTGRT  0.3915 0.0770 5.0824 42 0.000 0.2360 0.5469
#> PCTSUPP 0.2632 0.0747 3.5224 42 0.001 0.1124 0.4141
```

#### Asymptotic Distribution-Free Approach

``` r

BetaDelta(object, type = "adf", alpha = 0.05)
#> Call:
#> BetaDelta(object = object, type = "adf", alpha = 0.05)
#> 
#> Standardized regression slopes with ADF standard errors:
#>            est     se      t df      p   2.5%  97.5%
#> NARTIC  0.4951 0.0674 7.3490 42 0.0000 0.3592 0.6311
#> PCTGRT  0.3915 0.0710 5.5164 42 0.0000 0.2483 0.5347
#> PCTSUPP 0.2632 0.0769 3.4231 42 0.0014 0.1081 0.4184
```

## Other Features

The package can also be used to generate confidence intervals for
differences of standardized regression coefficients using the
[`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md)
function. It can also be used as a general approach to performing the
delta method using the
[`Delta()`](https://github.com/jeksterslab/betaDelta/reference/Delta.md)
and
[`DeltaGeneric()`](https://github.com/jeksterslab/betaDelta/reference/DeltaGeneric.md)
functions.

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaDelta/index.html)
for package documentation.

## Citation

To cite `betaDelta` in publications, please cite Pesigan et al. (2023).

## References

Jones, J. A., & Waller, N. G. (2015). The normal-theory and asymptotic
distribution-free (ADF) covariance matrix of standardized regression
coefficients: Theoretical extensions and finite sample behavior.
*Psychometrika*, *80*(2), 365–378.
<https://doi.org/10.1007/s11336-013-9380-y>

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*. National
Academies Press. <https://doi.org/10.17226/9781>

Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023). betaDelta and
betaSandwich: Confidence intervals for standardized regression
coefficients in R. *Multivariate Behavioral Research*, *58*(6),
1183–1186. <https://doi.org/10.1080/00273171.2023.2201277>

Yuan, K.-H., & Chan, W. (2011). Biases and standard errors of
standardized regression coefficients. *Psychometrika*, *76*(4), 670–690.
<https://doi.org/10.1007/s11336-011-9224-6>
