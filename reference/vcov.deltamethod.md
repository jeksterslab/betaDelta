# Sampling Covariance Matrix

Sampling Covariance Matrix

## Usage

``` r
# S3 method for class 'deltamethod'
vcov(object, ...)
```

## Arguments

- object:

  Object of class `deltamethod`.

- ...:

  additional arguments.

## Value

Returns a matrix of the variance-covariance matrix.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- glm(
  formula = vs ~ wt + disp,
  family = "binomial",
  data = mtcars
)
def <- list("exp(wt)", "exp(disp)")
out <- DeltaGeneric(
  object = object,
  def = def,
  alpha = 0.05
)
vcov(out)
#>               exp(wt)     exp(disp)
#> exp(wt)   57.46443026 -0.0977480169
#> exp(disp) -0.09774802  0.0002203662
```
