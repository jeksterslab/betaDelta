# Differences of Standardized Regression Slopes

Differences of Standardized Regression Slopes

## Usage

``` r
# S3 method for class 'diffbetadelta'
coef(object, ...)
```

## Arguments

- object:

  Object of class `diffbetadelta`.

- ...:

  additional arguments.

## Value

Returns a vector of differences of standardized regression slopes.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
std <- BetaDelta(object)
diff <- DiffBetaDelta(std)
coef(diff)
#>  NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP 
#>      0.1036564      0.2318974      0.1282410 
```
