## ---- test-betaDelta-r-sq-beta-delta
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
    r_sq <- summary(object)$r.squared
    adj <- summary(object)$adj.r.squared
    mvn <- rsq(BetaDelta(object, type = "mvn"))
    adf <- rsq(BetaDelta(object, type = "adf"))
    testthat::test_that(
      paste(text, "mvn", "multiple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                r_sq,
                adj
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
                r_sq,
                adj
              ) - adf$est
            ) <= tol
          )
        )
      }
    )
    object <- lm(QUALITY ~ NARTIC, data = df)
    r_sq <- summary(object)$r.squared
    adj <- summary(object)$adj.r.squared
    mvn <- rsq(BetaDelta(object, type = "mvn"))
    adf <- rsq(BetaDelta(object, type = "adf"))
    testthat::test_that(
      paste(text, "mvn", "simple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                r_sq,
                adj
              ) - mvn$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "adf", "simple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                r_sq,
                adj
              ) - adf$est
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-betaDelta-r-sq-beta-delta",
  tol = 0.0001
)
