# Print Method for an Object of Class `deltamethod`

Print Method for an Object of Class `deltamethod`

## Usage

``` r
# S3 method for class 'deltamethod'
print(x, alpha = NULL, digits = 4, ...)
```

## Arguments

- x:

  Object of class `deltamethod`.

- alpha:

  Numeric vector. Significance level \\\alpha\\. If `alpha = NULL`, use
  the argument `alpha` used in `x`.

- digits:

  Digits to print.

- ...:

  additional arguments.

## Value

Returns a matrix of coefficients, standard errors, test statistics,
degrees of freedom (if z = FALSE), p-values, and confidence intervals.

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
print(out)
#> Call:
#> DeltaGeneric(object = object, def = def, alpha = 0.05)
#>              est     se       z      p    2.5%   97.5%
#> exp(wt)   5.0853 7.5805  0.6708 0.5023 -9.7723 19.9429
#> exp(disp) 0.9662 0.0148 65.0838 0.0000  0.9371  0.9952
```
