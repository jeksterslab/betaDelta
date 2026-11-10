## ---- test-betaDelta-beta-delta-methods
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "methods"),
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
        mvn <- BetaDelta(object = object, type = "mvn")
        print.betadelta(x = mvn)
        summary.betadelta(object = mvn)
        print.summary.betadelta(x = summary.betadelta(object = mvn))
        coef.betadelta(object = mvn)
        vcov.betadelta(object = mvn)
        confint.betadelta(object = mvn)
        adf <- BetaDelta(object = object, type = "adf")
        print.betadelta(x = adf)
        summary.betadelta(object = adf)
        print.summary.betadelta(x = summary.betadelta(object = adf))
        coef.betadelta(object = adf)
        vcov.betadelta(object = adf)
        confint.betadelta(object = adf)
        object <- stats::lm(formula = QUALITY ~ NARTIC, data = df)
        mvn <- BetaDelta(object = object, type = "mvn")
        print.betadelta(x = mvn)
        summary.betadelta(object = mvn)
        print.summary.betadelta(x = summary.betadelta(object = mvn))
        coef.betadelta(object = mvn)
        vcov.betadelta(object = mvn)
        confint.betadelta(object = mvn)
        adf <- BetaDelta(object = object, type = "adf")
        print.betadelta(x = adf)
        summary.betadelta(object = adf)
        print.summary.betadelta(x = summary.betadelta(object = adf))
        coef.betadelta(object = adf)
        vcov.betadelta(object = adf)
        confint.betadelta(object = adf)
        testthat::expect_true(
          object = TRUE
        )
      }
    )
  },
  text = "test-betaDelta-beta-delta-methods"
)
