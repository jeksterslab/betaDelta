# Delta Method (Generic Object Input)

Calculates delta method sampling variance-covariance matrix for a
function of parameters using a numerical Jacobian.

## Usage

``` r
DeltaGeneric(
  object,
  def,
  theta = 0,
  alpha = c(0.05, 0.01, 0.001),
  z = TRUE,
  df = NULL
)
```

## Arguments

- object:

  R object. Fitted model object with `coef` and `vcov` methods that
  return a named vector of estimated parameters and sampling
  variance-covariance matrix, respectively.

- def:

  List of character strings. A list of defined functions of parameters.
  The string should be a valid R expression when parsed and should
  result a single value when evaluated.

- theta:

  Numeric vector. Parameter values when the null hypothesis is true.

- alpha:

  Numeric vector. Significance level/s.

- z:

  Logical. If `z = TRUE`, use the standard normal distribution. If
  `z = FALSE`, use the t distribution.

- df:

  Numeric. Degrees of freedom if `z = FALSE`.

## Value

Returns an object of class `deltamethod` which is a list with the
following elements:

- call:

  Function call.

- args:

  Function arguments.

- coef:

  Estimates.

- vcov:

  Sampling variance-covariance matrix.

- jacobian:

  Jacobian matrix.

- fun:

  Function used ("DeltaGeneric").

## See also

Other Delta Method Functions:
[`Delta()`](https://github.com/jeksterslab/betaDelta/reference/Delta.md)

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
DeltaGeneric(
  object = object,
  def = def,
  alpha = 0.05
)
#> Call:
#> DeltaGeneric(object = object, def = def, alpha = 0.05)
#>              est     se       z      p    2.5%   97.5%
#> exp(wt)   5.0853 7.5805  0.6708 0.5023 -9.7723 19.9429
#> exp(disp) 0.9662 0.0148 65.0838 0.0000  0.9371  0.9952
```
