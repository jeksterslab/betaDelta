## ---- test-betaDelta-diff-beta-delta
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
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
    mvn <- dif(BetaDelta(object, type = "mvn"))
    adf <- dif(BetaDelta(object, type = "adf"))
    testthat::test_that(
      paste(text, "mvn", "multiple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - mvn$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "adf", "multiple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - adf$est
            ) <= tol
          )
        )
      }
    )
    object <- lm(QUALITY ~ NARTIC, data = df)
    testthat::test_that(
      paste(text, "mvn", "simple regression"),
      {
        testthat::expect_error(
          dif(BetaDelta(object, type = "mvn"))
        )
      }
    )
    testthat::test_that(
      paste(text, "adf", "simple regression"),
      {
        testthat::expect_error(
          dif(BetaDelta(object, type = "adf"))
        )
      }
    )
  },
  text = "test-betaDelta-diff-beta-delta",
  tol = 0.0001
)
