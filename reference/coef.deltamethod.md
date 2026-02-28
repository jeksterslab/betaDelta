# Estimates

Estimates

## Usage

``` r
# S3 method for class 'deltamethod'
coef(object, ...)
```

## Arguments

- object:

  Object of class `deltamethod`.

- ...:

  additional arguments.

## Value

Returns a vector of estimates.

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
coef(out)
#>   exp(wt) exp(disp) 
#> 5.0852960 0.9661524 
```
