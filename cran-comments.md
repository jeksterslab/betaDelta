## Release summary

This is a minor update (1.0.7 -> 1.1.0).

- New functions: `RSqDelta()`, `SCorDelta()`, `SCorSqDelta()`, `PCorDelta()`, `DeltaRSqDelta()`, and `FSqDelta()`.
- Selective standardization through `std_y` and `std_x`.
- `DiffBetaDelta()` stops when the slopes are not fully standardized.
- betaSandwich, betaMC, and betaNB are removed from `Suggests`.
- No function was removed or renamed.

## Test environments

- Linux (x86_64, Apptainer image), R 4.6.2: `R CMD check --as-cran`, Status: OK.
- win-builder (R-devel): TODO (the maintainer runs this before submission).
- R-hub: TODO (the maintainer runs this before submission).

## R CMD check results

0 errors | 0 warnings | 0 notes (Linux, R 4.6.2). The win-builder and R-hub results go here.

## Reverse dependencies

TODO: confirm with `tools::package_dependencies(packages = "betaDelta", reverse = TRUE)` before submission.
