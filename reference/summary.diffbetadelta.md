# Summary Method for an Object of Class `diffbetadelta`

Summary Method for an Object of Class `diffbetadelta`

## Usage

``` r
# S3 method for class 'diffbetadelta'
summary(object, alpha = NULL, digits = 4, ...)
```

## Arguments

- object:

  Object of class `diffbetadelta`.

- alpha:

  Numeric vector. Significance level \\\alpha\\. If `alpha = NULL`, use
  the argument `alpha` used in `object`.

- digits:

  Digits to print.

- ...:

  additional arguments.

## Value

Returns a matrix of standardized regression slopes, standard errors,
test statistics, degrees of freedom, p-values, and confidence intervals.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
diff <- DiffBetaDelta(std)
summary(diff)
#> Call:
#> DiffBetaDelta(object = std)
#> 
#> Difference between standardized regression coefficients with MVN standard errors:
#>                   est     se      z      p   0.05%    0.5%    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1357 0.7640 0.4449 -0.3428 -0.2458 -0.1623 0.3696
#> NARTIC-PCTSUPP 0.2319 0.1252 1.8524 0.0640 -0.1800 -0.0906 -0.0135 0.4773
#> PCTGRT-PCTSUPP 0.1282 0.1227 1.0451 0.2960 -0.2755 -0.1878 -0.1123 0.3688
#>                 99.5% 99.95%
#> NARTIC-PCTGRT  0.4531 0.5501
#> NARTIC-PCTSUPP 0.5544 0.6438
#> PCTGRT-PCTSUPP 0.4443 0.5320
```
