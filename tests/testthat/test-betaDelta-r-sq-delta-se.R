## ---- test-betaDelta-r-sq-delta-se
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    message(text)
    if (!identical(Sys.getenv("NOT_CRAN"), "true") && !interactive()) {
      message("CRAN: tests skipped.")
      # nolint start
      return(invisible(NULL))
      # nolint end
    }
    testthat::test_that(
      paste(text, "normal-theory standard error of R-squared"),
      {
        testthat::skip_on_cran()
        set.seed(42)
        n <- 5000
        x <- matrix(stats::rnorm(n * 2), ncol = 2)
        y <- drop(x %*% c(0.4, 0.3)) + stats::rnorm(n)
        object <- lm(y ~ x)
        rsq <- summary(object)$r.squared
        se <- sqrt(4 * rsq * (1 - rsq)^2 / n)
        out <- RSqDelta(BetaDelta(object, type = "mvn"))
        testthat::expect_true(
          abs(sqrt(diag(vcov(out)))[1] / se - 1) <= tol
        )
      }
    )
  },
  text = "test-betaDelta-r-sq-delta-se",
  tol = 0.1
)
