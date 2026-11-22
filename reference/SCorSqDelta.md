# Estimate Squared Semipartial Correlation Coefficients and the Corresponding Confidence Intervals From the Signed Intervals

Square the signed interval as a set, with lower limit zero if it
contains zero. This differs from an interval of squared draws. No draws
are generated and no endpoints are clipped to one. Failed signed
endpoints remain missing.

## Usage

``` r
SCorSqDelta(object, level = 0.95)
```

## Arguments

- object:

  Context accepted by
  [`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md).

- level:

  Single confidence level in (0, 1).

## Value

Data frame with est, lower and upper columns and predictor row names.
The point estimate is the squared signed estimate. No standard error is
implied by this interval transformation.

## Details

The semipartial correlation \\(sr\_{j}\\) (see
[`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md))
is signed, and its confidence interval \\(\left\[ l, u \right\]\\) may
contain zero. The interval for \\(sr^{2}\_{j}\\) is the image of that
interval under squaring. The squared interval is \\(\left\[ l^{2}, u^{2}
\right\]\\) if \\(0 \< l\\), \\(\left\[ u^{2}, l^{2} \right\]\\) if \\(u
\< 0\\), and \\(\left\[ 0, \max \left( l^{2}, u^{2} \right) \right\]\\)
if the signed interval contains zero. This is not the interval of
squared draws, and it is not an interval for
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
which is based on the delta method.

## See also

Other Beta Delta Method Functions:
[`BetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/BetaDelta.md),
[`DeltaRSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/DeltaRSqDelta.md),
[`DiffBetaDelta()`](https://jeksterslab.github.io/betaDelta/reference/DiffBetaDelta.md),
[`FSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/FSqDelta.md),
[`PCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/PCorDelta.md),
[`RSqDelta()`](https://jeksterslab.github.io/betaDelta/reference/RSqDelta.md),
[`SCorDelta()`](https://jeksterslab.github.io/betaDelta/reference/SCorDelta.md)

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

# SCorSqDelta --------------------------------------------------------------
SCorSqDelta(object = std, level = 0.95)
#>               est      lower     upper
#> NARTIC  0.1858925 0.07831483 0.3392563
#> PCTGRT  0.1176542 0.03903381 0.2385788
#> PCTSUPP 0.0568722 0.01016720 0.1414703
```
