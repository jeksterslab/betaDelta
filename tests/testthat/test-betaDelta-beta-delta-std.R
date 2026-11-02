## ---- test-betaDelta-beta-delta-std
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
    set.seed(42)
    n <- 200
    x1 <- rnorm(n)
    x2 <- rbinom(n, size = 1, prob = 0.4)
    x3 <- rnorm(n) + 0.5 * x1
    y <- 0.4 * x1 + 0.3 * x2 - 0.2 * x3 + rnorm(n)
    df <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
    object <- lm(y ~ x1 + x2 + x3, data = df)
    b <- coef(object)[-1]
    sds <- sapply(df, sd)
    testthat::test_that(
      paste(text, "selective standardization"),
      {
        testthat::skip_on_cran()
        for (type in c("mvn", "adf")) {
          raw <- BetaDelta(
            object,
            type = type,
            std_y = FALSE,
            std_x = character(0)
          )
          testthat::expect_true(all(abs(coef(raw) - b) <= tol))
          ystd <- BetaDelta(object, type = type, std_x = character(0))
          testthat::expect_true(all(abs(coef(ystd) - b / sds["y"]) <= tol))
          dummy <- BetaDelta(object, type = type, std_x = c("x1", "x3"))
          testthat::expect_true(
            abs(coef(dummy)["x2"] - b["x2"] / sds["y"]) <= tol
          )
          full <- BetaDelta(object, type = type)
          same <- BetaDelta(object, type = type, std_x = c("x1", "x2", "x3"))
          testthat::expect_true(all(abs(vcov(full) - vcov(same)) <= tol))
          testthat::expect_error(DiffBetaDelta(raw))
        }
      }
    )
  },
  text = "test-betaDelta-beta-delta-std",
  tol = 1e-10
)
