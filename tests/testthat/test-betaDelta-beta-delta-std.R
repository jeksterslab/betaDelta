## ---- test-betaDelta-beta-delta-std
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)
    set.seed(seed = 42)
    n <- 200
    x1 <- stats::rnorm(n = n)
    x2 <- stats::rbinom(n = n, size = 1, prob = 0.4)
    x3 <- stats::rnorm(n = n) + 0.5 * x1
    y <- 0.4 * x1 + 0.3 * x2 - 0.2 * x3 + stats::rnorm(n = n)
    df <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
    object <- stats::lm(formula = y ~ x1 + x2 + x3, data = df)
    b <- stats::coef(object = object)[-1]
    sds <- sapply(X = df, FUN = sd)
    testthat::test_that(
      desc = paste(text, "selective standardization"),
      code = {
        for (type in c("mvn", "adf")) {
          raw <- BetaDelta(
            object = object,
            type = type,
            std_y = FALSE,
            std_x = character(length = 0)
          )
          testthat::expect_true(
            object = all(abs(x = stats::coef(object = raw) - b) <= tol)
          )
          ystd <- BetaDelta(
            object = object,
            type = type,
            std_x = character(length = 0)
          )
          testthat::expect_true(
            object = all(
              abs(x = stats::coef(object = ystd) - b / sds["y"]) <= tol
            )
          )
          dummy <- BetaDelta(
            object = object,
            type = type,
            std_x = c("x1", "x3")
          )
          testthat::expect_true(
            object = abs(
              x = stats::coef(object = dummy)["x2"] - b["x2"] / sds["y"]
            ) <= tol
          )
          full <- BetaDelta(object = object, type = type)
          same <- BetaDelta(
            object = object,
            type = type,
            std_x = c("x1", "x2", "x3")
          )
          testthat::expect_true(
            object = all(
              abs(
                x = stats::vcov(object = full) - stats::vcov(object = same)
              ) <= tol
            )
          )
          testthat::expect_error(object = DiffBetaDelta(object = raw))
        }
      }
    )
  },
  text = "test-betaDelta-beta-delta-std",
  tol = 1e-10
)
