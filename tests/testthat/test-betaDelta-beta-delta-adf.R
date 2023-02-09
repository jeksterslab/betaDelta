## ---- test-betaDelta-beta-delta-adf
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
    message(text)
    if (!exists("nas1982")) {
      try(
        data(
          "nas1982",
          package = "betaDelta"
        ),
        silent = TRUE
      )
    }
    df <- nas1982
    object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = df)
    out <- BetaDelta(object, type = "adf")
    testthat::test_that(
      paste(text, "coef"),
      {
        testthat::expect_true(
          all(
            abs(
              coef(out) - c(0.4951, 0.3915, 0.2632)
            ) <= tol
          )
        )
        testthat::expect_true(
          all(
            abs(
              out$est - coef(out)
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "se"),
      {
        testthat::expect_true(
          all(
            abs(
              summary(out)[, "se"] - c(0.0674, 0.0710, 0.0769)
            ) <= tol
          )
        )
        testthat::expect_true(
          all(
            abs(
              sqrt(diag(vcov(out))) - summary(out)[, "se"]
            ) <= tol
          )
        )
      }
    )
  },
  tol = 0.0001,
  text = "test-betaDelta-beta-delta-adf"
)
# This test compares the results of the package with Dudgeon (2017)
