## ---- test-betaDelta-diff-beta-delta
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    message(text)
    testthat::test_that(
      paste(text, "mvn", "multiple regression"),
      {
        testthat::skip_on_cran()
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
        mvn <- DiffBetaDelta(BetaDelta(object, type = "mvn"))
        testthat::expect_true(
          all(
            abs(
              c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - coef(mvn)
            ) <= tol
          )
        )
        testthat::expect_true(
          all(
            abs(
              coef(mvn) - mvn$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "adf", "multiple regression"),
      {
        testthat::skip_on_cran()
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
        adf <- DiffBetaDelta(BetaDelta(object, type = "adf"))
        testthat::expect_true(
          all(
            abs(
              c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - coef(adf)
            ) <= tol
          )
        )
        testthat::expect_true(
          all(
            abs(
              coef(adf) - adf$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "mvn", "simple regression"),
      {
        testthat::skip_on_cran()
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
        object <- lm(QUALITY ~ NARTIC, data = df)
        testthat::expect_error(
          DiffBetaDelta(BetaDelta(object, type = "mvn"))
        )
      }
    )
    testthat::test_that(
      paste(text, "adf", "simple regression"),
      {
        testthat::skip_on_cran()
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
        object <- lm(QUALITY ~ NARTIC, data = df)
        testthat::expect_error(
          DiffBetaDelta(BetaDelta(object, type = "adf"))
        )
      }
    )
  },
  text = "test-betaDelta-diff-beta-delta",
  tol = 0.0001
)
