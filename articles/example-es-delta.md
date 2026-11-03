# betaDelta: Example Using the RSqDelta, SCorDelta, PCorDelta, DeltaRSqDelta, and FSqDelta Functions

Confidence intervals for R-squared, semipartial correlations, squared
partial correlations, the improvement in R-squared, and Cohen’s
f-squared are generated using the
[`RSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md),
[`PCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/PCorDelta.md),
[`DeltaRSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md),
and
[`FSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md)
functions from the `betaDelta` package. In this example, we use the data
set and the model used in [betaDelta: Example Using the BetaDelta
Function](https://github.com/jeksterslab/betaDelta/articles/example-beta-delta.md).

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`betaDelta`](https://github.com/jeksterslab/betaDelta)`)`

\
`df`` ``<-`` ``betaDelta``::`[`nas1982`](https://github.com/jeksterslab/betaDelta/reference/nas1982.md)

## Fit the regression model using the `lm()` function.

\
`object`` ``<-`` `[`lm`](https://rdrr.io/r/stats/lm.html)`(``QUALITY`` ``~`` ``NARTIC`` ``+`` ``PCTGRT`` ``+`` ``PCTSUPP``, data ``=`` ``df``)`

## Estimate the standardized regression slopes and the sampling covariance matrix.

\
`std_mvn`` ``<-`` `[`BetaDelta`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)`(``object``, type ``=`` ``"mvn"``)`\
`std_adf`` ``<-`` `[`BetaDelta`](https://github.com/jeksterslab/betaDelta/reference/BetaDelta.md)`(``object``, type ``=`` ``"adf"``)`

## R-squared and adjusted R-squared

\
[`summary`](https://rdrr.io/r/base/summary.html)`(`[`RSqDelta`](https://github.com/jeksterslab/betaDelta/reference/RSqDelta.md)`(``std_adf``, alpha ``=`` ``0.05``)``)`\
`#> Call:`\
`#> RSqDelta(object = std_adf, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared with ADF standard errors:`\
`#>        est     se       z p   2.5%  97.5%`\
`#> rsq 0.8045 0.0519 15.4910 0 0.7027 0.9063`\
`#> adj 0.7906 0.0556 14.2073 0 0.6815 0.8996`

## Semipartial correlations

\
[`summary`](https://rdrr.io/r/base/summary.html)`(`[`SCorDelta`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md)`(``std_adf``, alpha ``=`` ``0.05``)``)`\
`#> Call:`\
`#> SCorDelta(object = std_adf, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations with ADF standard errors:`\
`#>            est     se      z     p   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0672 6.4202 0e+00 0.2995 0.5628`\
`#> PCTGRT  0.3430 0.0689 4.9812 0e+00 0.2080 0.4780`\
`#> PCTSUPP 0.2385 0.0701 3.4003 7e-04 0.1010 0.3759`

## Squared partial correlations

\
[`summary`](https://rdrr.io/r/base/summary.html)`(`[`PCorDelta`](https://github.com/jeksterslab/betaDelta/reference/PCorDelta.md)`(``std_adf``, alpha ``=`` ``0.05``)``)`\
`#> Call:`\
`#> PCorDelta(object = std_adf, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations with ADF standard errors:`\
`#>            est     se      z      p    2.5%  97.5%`\
`#> NARTIC  0.4874 0.0941 5.1817 0.0000  0.3031 0.6718`\
`#> PCTGRT  0.3757 0.1021 3.6796 0.0002  0.1756 0.5759`\
`#> PCTSUPP 0.2254 0.1157 1.9481 0.0514 -0.0014 0.4521`

## Improvement in R-squared

\
[`summary`](https://rdrr.io/r/base/summary.html)`(`[`DeltaRSqDelta`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md)`(``std_adf``, alpha ``=`` ``0.05``)``)`\
`#> Call:`\
`#> DeltaRSqDelta(object = std_adf, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared with ADF standard errors:`\
`#>            est     se      z      p    2.5%  97.5%`\
`#> NARTIC  0.1859 0.0579 3.2101 0.0013  0.0724 0.2994`\
`#> PCTGRT  0.1177 0.0472 2.4906 0.0128  0.0251 0.2102`\
`#> PCTSUPP 0.0569 0.0335 1.7001 0.0891 -0.0087 0.1224`

## Cohen’s f-squared and local f-squared

\
[`summary`](https://rdrr.io/r/base/summary.html)`(`[`FSqDelta`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md)`(``std_adf``, alpha ``=`` ``0.05``)``)`\
`#> Call:`\
`#> FSqDelta(object = std_adf, alpha = 0.05)`\
`#> `\
`#> Cohen's f-squared (fsq) and local f-squared with ADF standard errors:`\
`#>            est     se      z      p    2.5%  97.5%`\
`#> fsq     4.1158 1.3592 3.0281 0.0025  1.4518 6.7798`\
`#> NARTIC  0.9510 0.3581 2.6560 0.0079  0.2492 1.6528`\
`#> PCTGRT  0.6019 0.2620 2.2970 0.0216  0.0883 1.1155`\
`#> PCTSUPP 0.2909 0.1928 1.5091 0.1313 -0.0869 0.6688`

## Comparing covariance estimators

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(`[`DeltaRSqDelta`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md)`(``std_mvn``)``, level ``=`` ``0.95``)`\
`#>                2.5 %    97.5 %`\
`#> NARTIC   0.055421734 0.3163632`\
`#> PCTGRT   0.017881671 0.2174267`\
`#> PCTSUPP -0.008779331 0.1225237`\
[`confint`](https://rdrr.io/r/stats/confint.html)`(`[`DeltaRSqDelta`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md)`(``std_adf``)``, level ``=`` ``0.95``)`\
`#>                2.5 %    97.5 %`\
`#> NARTIC   0.072394224 0.2993907`\
`#> PCTGRT   0.025067308 0.2102410`\
`#> PCTSUPP -0.008691312 0.1224357`

## References

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*. National
Academies Press. <https://doi.org/10.17226/9781>

Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023). betaDelta and
betaSandwich: Confidence intervals for standardized regression
coefficients in R. *Multivariate Behavioral Research*, *58*(6),
1183–1186. <https://doi.org/10.1080/00273171.2023.2201277>
