# betaDelta: Example Using the Delta Function

In this example, we use the delta method to calculate the odds ratio,
the associated standard errors, and confidence intervals within a
logistic regression model.

``` r

library(betaDelta)
```

``` r

object <- glm(
  formula = vs ~ wt + disp,
  family = "binomial",
  data = mtcars
)
func <- function(x) {
  y <- exp(x)
  names(y) <- paste0("exp", "(", names(x), ")")
  return(y[-1])
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

## Methods

``` r

delta <- Delta(
  coef = coef(object),
  vcov = vcov(object),
  func = func,
  alpha = 0.05
)
```

### summary

Summary of the results of
[`Delta()`](https://github.com/jeksterslab/betaDelta/reference/Delta.md).

``` r

summary(delta)
#>              est     se       z      p    2.5%   97.5%
#> exp(wt)   5.0853 7.5805  0.6708 0.5023 -9.7723 19.9429
#> exp(disp) 0.9662 0.0148 65.0838 0.0000  0.9371  0.9952
```

### coef

Calculate the estimates.

``` r

coef(delta)
#>   exp(wt) exp(disp) 
#> 5.0852960 0.9661524
```

### vcov

Calculate the sampling covariance matrix.

``` r

vcov(delta)
#>               exp(wt)     exp(disp)
#> exp(wt)   57.46443026 -0.0977480169
#> exp(disp) -0.09774802  0.0002203662
```

### confint

Generate confidence intervals.

``` r

confint(delta, level = 0.95)
#>                2.5 %     97.5 %
#> exp(wt)   -9.7722691 19.9428612
#> exp(disp)  0.9370572  0.9952475
```

## References

Pesigan, I. J. A., Sun, R. W., & Cheung, S. F. (2023). betaDelta and
betaSandwich: Confidence intervals for standardized regression
coefficients in R. *Multivariate Behavioral Research*, *58*(6),
1183–1186. <https://doi.org/10.1080/00273171.2023.2201277>
