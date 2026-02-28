# Sampling Covariance Matrix of Differences of Standardized Regression Slopes

Sampling Covariance Matrix of Differences of Standardized Regression
Slopes

## Usage

``` r
# S3 method for class 'diffbetadelta'
vcov(object, ...)
```

## Arguments

- object:

  Object of class `diffbetadelta`.

- ...:

  additional arguments.

## Value

Returns a matrix of the variance-covariance matrix of differences of
standardized regression slopes.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
diff <- DiffBetaDelta(std)
vcov(diff)
#>                NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP
#> NARTIC-PCTGRT    0.018408653    0.009511262   -0.008897391
#> NARTIC-PCTSUPP   0.009511262    0.015672035    0.006160773
#> PCTGRT-PCTSUPP  -0.008897391    0.006160773    0.015058164
```
