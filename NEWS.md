# betaDelta 1.1.0

## Major

- Added `RSqDelta()`, `SCorDelta()`, `SCorSqDelta()`, `PCorDelta()`,
  `DeltaRSqDelta()`, and `FSqDelta()`: delta-method intervals for
  R-squared and adjusted R-squared, semipartial correlations,
  squared signed-semipartial and squared partial correlations,
  the improvement in R-squared, and Cohen's f-squared (global and local),
  with normal-theory or ADF standard errors.
- The new functions and `DiffBetaDelta()` return objects of class
  `esdelta` with one set of `print()`, `summary()`, `coef()`, `vcov()`,
  and `confint()` methods.
  `DiffBetaDelta()` objects also keep the class `diffbetadelta`.
- Added a package help page and equations in the help pages of the
  effect-size functions.

## Minor

- Selective standardization: the arguments `std_y` and `std_x` standardize
  only y or only the named regressors (for example, leave a dummy
  variable in its 0-1 units). The defaults give the same results as
  before.
- `DiffBetaDelta()` stops when the slopes are not fully standardized.
- Examples and vignettes use named arguments and `pkg::fn()` calls;
  the effect-size vignette shows the `coef()`, `vcov()`, and `confint()`
  methods.
- Removed betaSandwich, betaMC, and betaNB from `Suggests`.
- The internal copies from deltaMethod 0.0.2 (one form of the delta-method
  covariance for any number of parameters), linearAlgebra 0.0.5 (a faster
  duplication matrix and its exact inverse), and processLM 0.0.11 are
  current. Results agree with 1.1.0 up to rounding.
- `DeltaRSqDelta()` and `FSqDelta()` give references, as in betaSandwich.

# betaDelta 1.0.7

## Patch

- Minor edits to methods.

# betaDelta 1.0.6

## Patch

- Minor edits to methods.

# betaDelta 1.0.5

## Patch

- Minor documentation edits.

# betaDelta 1.0.4

## Patch

- Added the `Delta()` and `DeltaGeneric()` functions.

# betaDelta 1.0.3

## Patch

- Minor documentation edits.

# betaDelta 1.0.2

## Patch

- Added degrees of freedom to the table of results.

# betaDelta 1.0.1

## Patch

- Added the `DiffBetaDelta()` function.

# betaDelta 1.0.0

## Major

- And so it begins.
