# betaDelta: Confidence Intervals for Standardized Regression Coefficients

Generates confidence intervals for standardized regression coefficients
using delta method standard errors for models fitted by
[`stats::lm()`](https://rdrr.io/r/stats/lm.html) (Yuan & Chan, 2011;
Jones & Waller, 2015). Sampling covariance matrices are obtained under
multivariate normal theory or the asymptotically distribution-free
approach.

## Standardized regression coefficients

[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md)
estimates the standardized regression coefficients and the corresponding
sampling covariance matrix. The arguments `std_y` and `std_x`
standardize only the outcome or only the named regressors.

## Functions of the standardized coefficients

[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md)
(differences of standardized slopes),
[`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md)
(R-squared and adjusted R-squared),
[`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md)
and
[`SCorSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorSqDelta.md)
(semipartial correlations),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md)
(squared partial correlations),
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md)
(improvement in R-squared), and
[`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md)
(Cohen's f-squared and local f-squared).

## General delta method

[`Delta()`](https://jeksterslab.github.io/betaDelta/reference/Delta.md)
and
[`DeltaGeneric()`](https://jeksterslab.github.io/betaDelta/reference/DeltaGeneric.md)
apply the delta method to any function of the parameters.

## Methods

The [`coef()`](https://rdrr.io/r/stats/coef.html),
[`vcov()`](https://rdrr.io/r/stats/vcov.html),
[`confint()`](https://rdrr.io/r/stats/confint.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`print()`](https://rdrr.io/r/base/print.html) methods are available for
objects of class `betadelta` and `esdelta`.

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

Useful links:

- <https://github.com/jeksterslab/betaDelta>

- <https://jeksterslab.github.io/betaDelta/>

- Report bugs at <https://github.com/jeksterslab/betaDelta/issues>

## Author

**Maintainer**: Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>
([ORCID](https://orcid.org/0000-0003-4818-8420)) \[copyright holder\]

Authors:

- Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-4818-8420)) \[copyright holder\]
