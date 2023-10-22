## ---- test-zzz-coverage
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    message(text)
    out <- betaDelta:::.DiagofVech(
      x = 0,
      k = 1,
      loc = TRUE
    )
    testthat::test_that(
      paste(text, "one"),
      {
        testthat::expect_equal(
          out,
          1
        )
      }
    )
    out <- betaDelta:::.DiagofVech(
      x = rep(x = 0, times = 3),
      k = 2,
      loc = TRUE
    )
    testthat::test_that(
      paste(text, "one, three"),
      {
        testthat::expect_equal(
          out,
          c(1, 3)
        )
      }
    )
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
  },
  text = "test-zzz-coverage"
)
