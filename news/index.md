# Changelog

## betaDelta 1.0.7.9000

### Major

- Added
  [`RSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/RSqDelta.md),
  [`SCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/SCorDelta.md),
  [`PCorDelta()`](https://github.com/jeksterslab/betaDelta/reference/PCorDelta.md),
  [`DeltaRSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/DeltaRSqDelta.md),
  and
  [`FSqDelta()`](https://github.com/jeksterslab/betaDelta/reference/FSqDelta.md):
  delta-method intervals for R-squared and adjusted R-squared,
  semipartial correlations, squared partial correlations, the
  improvement in R-squared, and Cohen’s f-squared (global and local),
  with normal-theory or ADF standard errors, as in betaMC and betaNB.
- The new functions and
  [`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md)
  return objects of class `esdelta` with one set of methods.
  [`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md)
  objects also keep the class `diffbetadelta`.

### Minor

- Selective standardization: the arguments `std_y` and `std_x`
  standardize only y or only the named regressors (for example, leave a
  dummy variable in its 0-1 units). The defaults give the same results
  as before.
- [`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md)
  stops when the slopes are not fully standardized.

## betaDelta 1.0.7

CRAN release: 2026-06-11

### Patch

- Minor edits to methods.

## betaDelta 1.0.6

CRAN release: 2025-10-19

### Patch

- Minor edits to methods.

## betaDelta 1.0.5

CRAN release: 2024-04-14

### Patch

- Minor documentation edits.

## betaDelta 1.0.4

CRAN release: 2023-11-03

### Patch

- Added the
  [`Delta()`](https://github.com/jeksterslab/betaDelta/reference/Delta.md)
  and
  [`DeltaGeneric()`](https://github.com/jeksterslab/betaDelta/reference/DeltaGeneric.md)
  functions.

## betaDelta 1.0.3

CRAN release: 2023-10-14

### Patch

- Minor documentation edits.

## betaDelta 1.0.2

CRAN release: 2023-07-09

### Patch

- Added degrees of freedom to the table of results.

## betaDelta 1.0.1

CRAN release: 2023-04-25

### Patch

- Added the
  [`DiffBetaDelta()`](https://github.com/jeksterslab/betaDelta/reference/DiffBetaDelta.md)
  function.

## betaDelta 1.0.0

CRAN release: 2022-12-19

### Major

- And so it begins.
