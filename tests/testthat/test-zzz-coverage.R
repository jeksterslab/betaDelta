## ---- test-zzz-coverage
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "coverage"),
      code = {
        out <- betaDelta:::.DiagofVech(
          x = 0,
          k = 1,
          loc = TRUE
        )
        testthat::test_that(
          desc = paste(text, "one"),
          code = {
            testthat::expect_equal(
              object = out,
              expected = 1
            )
          }
        )
        out <- betaDelta:::.DiagofVech(
          x = rep(x = 0, times = 3),
          k = 2,
          loc = TRUE
        )
        testthat::test_that(
          desc = paste(text, "one, three"),
          code = {
            testthat::expect_equal(
              object = out,
              expected = c(1, 3)
            )
          }
        )
        object <- stats::glm(
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
        testthat::expect_true(
          object = TRUE
        )
      }
    )
  },
  text = "test-zzz-coverage"
)
