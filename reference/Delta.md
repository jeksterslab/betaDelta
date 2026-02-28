# Delta Method

Calculates delta method sampling variance-covariance matrix for a
function of parameters using a numerical Jacobian.

## Usage

``` r
Delta(
  coef,
  vcov,
  func,
  ...,
  theta = 0,
  alpha = c(0.05, 0.01, 0.001),
  z = TRUE,
  df = NULL
)
```

## Arguments

- coef:

  Numeric vector. Vector of parameters.

- vcov:

  Numeric matrix. Matrix of sampling variance-covariance matrix of
  parameters.

- func:

  R function.

  1.  The first argument `x` is the argument `coef`.

  2.  The function algebraically manipulates `coef` to return a new
      numeric vector. It is best to have a named vector as an output.

  3.  The function can take additional named arguments passed using
      `...`.

- ...:

  Additional arguments to pass to `func`.

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

  Function used ("Delta").

## See also

Other Delta Method Functions:
[`DeltaGeneric()`](https://github.com/jeksterslab/betaDelta/reference/DeltaGeneric.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
object <- glm(
  formula = vs ~ wt + disp,
  family = "binomial",
  data = mtcars
)
func <- function(x) {
  y <- exp(x)
  names(y) <- paste0("exp", "(", names(x), ")")
  y[-1]
}
Delta(
  coef = coef(object),
  vcov = vcov(object),
  func = func,
  alpha = 0.05
)
#> Call:
#> Delta(coef = coef(object), vcov = vcov(object), func = func, 
#>     alpha = 0.05)
#>              est     se       z      p    2.5%   97.5%
#> exp(wt)   5.0853 7.5805  0.6708 0.5023 -9.7723 19.9429
#> exp(disp) 0.9662 0.0148 65.0838 0.0000  0.9371  0.9952
```
