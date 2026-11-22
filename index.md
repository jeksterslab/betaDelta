# betaDelta

Ivan Jacob Agaloos Pesigan 2026-11-22

## Description

Generates confidence intervals for standardized regression coefficients
using delta method standard errors for models fitted by
[`lm()`](https://rdrr.io/r/stats/lm.html) as described in Yuan and Chan
(2011,
[doi:10.1007/s11336-011-9224-6](https://doi.org/10.1007/s11336-011-9224-6))
and Jones and Waller (2015,
[doi:10.1007/s11336-013-9380-y](https://doi.org/10.1007/s11336-013-9380-y)).
The package also generates delta method confidence intervals for
differences of standardized regression coefficients, R-squared and
adjusted R-squared, semipartial and squared partial correlations, the
improvement in R-squared, and Cohen’s f-squared, with normal-theory or
asymptotically distribution-free standard errors. It can also be used as
a general approach to performing the delta method. A description of the
package and code examples are presented in Pesigan, Sun, and Cheung
(2023,
[doi:10.1080/00273171.2023.2201277](https://doi.org/10.1080/00273171.2023.2201277)).

## Installation

You can install the CRAN release of `betaDelta` with:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"betaDelta"``)`

You can install the development version of `betaDelta` from
[GitHub](https://github.com/jeksterslab/betaDelta) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"jeksterslab/betaDelta"``)`

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
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)
function from the `betaDelta` package following Yuan & Chan (2011) and
Jones & Waller (2015).

\
[`library`](https://rdrr.io/r/base/library.html)`(``package ``=`` ``"betaDelta"``)`

\
`df`` ``<-`` ``betaDelta``::`[`nas1982`](https://jeksterslab.github.io/betaDelta/reference/nas1982.md)

### Fit the regression model using the `lm()` function.

\
`object`` ``<-`` ``stats``::`[`lm`](https://rdrr.io/r/stats/lm.html)`(``formula ``=`` ``QUALITY`` ``~`` ``NARTIC`` ``+`` ``PCTGRT`` ``+`` ``PCTSUPP``, data ``=`` ``df``)`

### Estimate the standardized regression slopes and the corresponding sampling covariance matrix.

\
[`BetaDelta`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)`(``object ``=`` ``object``, type ``=`` ``"mvn"``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> BetaDelta(object = object, type = "mvn", alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes with MVN standard errors:`\
`#>            est     se      t df     p   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0759 6.5272 42 0.000 0.3421 0.6482`\
`#> PCTGRT  0.3915 0.0770 5.0824 42 0.000 0.2360 0.5469`\
`#> PCTSUPP 0.2632 0.0747 3.5224 42 0.001 0.1124 0.4141`

## Other Features

The package provides the following functions.

| Function | Purpose |
|----|----|
| [`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md) | Standardized regression coefficients with a normal-theory (`type = "mvn"`) or asymptotically distribution-free (`type = "adf"`) sampling covariance matrix |
| [`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md) | R-squared and adjusted R-squared |
| [`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md) | Differences of standardized regression coefficients |
| [`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md) | Semipartial correlations |
| [`SCorSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorSqDelta.md) | Squared semipartial correlations (squared signed interval) |
| [`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md) | Squared partial correlations |
| [`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md) | Improvement in R-squared |
| [`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md) | Cohen’s f-squared and local f-squared |
| [`Delta()`](https://jeksterslab.github.io/betaDelta/reference/Delta.md), [`DeltaGeneric()`](https://jeksterslab.github.io/betaDelta/reference/DeltaGeneric.md) | The delta method for a function of the parameters of a fitted model |

The [`coef()`](https://rdrr.io/r/stats/coef.html),
[`vcov()`](https://rdrr.io/r/stats/vcov.html),
[`confint()`](https://rdrr.io/r/stats/confint.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`print()`](https://rdrr.io/r/base/print.html) methods are available for
the returned objects. The effect-size functions take the output of
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
so the normal-theory or asymptotically distribution-free approach is
chosen once. Examples for each function are in the package vignettes.

## Effect Sizes

The definitions, formulas, and notes on effect sizes near zero are in
the help pages of the functions and in the vignette [betaDelta: Example
Using the RSqDelta, SCorDelta, PCorDelta, DeltaRSqDelta, and FSqDelta
Functions](https://jeksterslab.github.io/betaDelta/articles/example-es-delta.html).

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

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>

Yuan, K.-H., & Chan, W. (2011). Biases and standard errors of
standardized regression coefficients. *Psychometrika*, *76*(4), 670–690.
<https://doi.org/10.1007/s11336-011-9224-6>
