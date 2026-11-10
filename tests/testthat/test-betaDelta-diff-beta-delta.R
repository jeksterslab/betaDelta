## ---- test-betaDelta-diff-beta-delta
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "mvn", "multiple regression"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaDelta"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(
          formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
          data = df
        )
        mvn <- DiffBetaDelta(object = BetaDelta(object = object, type = "mvn"))
        testthat::expect_true(
          object = all(
            abs(
              x = c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - stats::coef(object = mvn)
            ) <= tol
          )
        )
        testthat::expect_true(
          object = all(
            abs(
              x = stats::coef(object = mvn) - mvn$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "adf", "multiple regression"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaDelta"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(
          formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
          data = df
        )
        adf <- DiffBetaDelta(object = BetaDelta(object = object, type = "adf"))
        testthat::expect_true(
          object = all(
            abs(
              x = c(
                0.4951 - 0.3915,
                0.4951 - 0.2632,
                0.3915 - 0.2632
              ) - stats::coef(object = adf)
            ) <= tol
          )
        )
        testthat::expect_true(
          object = all(
            abs(
              x = stats::coef(object = adf) - adf$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "mvn", "simple regression"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaDelta"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(formula = QUALITY ~ NARTIC, data = df)
        testthat::expect_error(
          object = DiffBetaDelta(
            object = BetaDelta(object = object, type = "mvn")
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "adf", "simple regression"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaDelta"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(formula = QUALITY ~ NARTIC, data = df)
        testthat::expect_error(
          object = DiffBetaDelta(
            object = BetaDelta(object = object, type = "adf")
          )
        )
      }
    )
  },
  text = "test-betaDelta-diff-beta-delta",
  tol = 0.0001
)
