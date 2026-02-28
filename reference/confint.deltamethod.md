# Confidence Intervals

Confidence Intervals

## Usage

``` r
# S3 method for class 'deltamethod'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  Object of class `deltamethod`.

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required.

- ...:

  additional arguments.

## Value

Returns a matrix of confidence intervals.

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
confint(out, level = 0.95)
#>                2.5 %     97.5 %
#> exp(wt)   -9.7722691 19.9428612
#> exp(disp)  0.9370572  0.9952475
```
