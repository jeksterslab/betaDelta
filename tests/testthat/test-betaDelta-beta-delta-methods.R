## ---- test-betaDelta-beta-delta-methods
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    message(text)

    set.seed(42)

    if (!identical(Sys.getenv("NOT_CRAN"), "true") && !interactive()) {
      message("CRAN: tests skipped.")
      # nolint start
      return(invisible(NULL))
      # nolint end
    }

    testthat::test_that(
      paste(text, "methods"),
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
        mvn <- BetaDelta(object, type = "mvn")
        print.betadelta(mvn)
        summary.betadelta(mvn)
        print.summary.betadelta(summary.betadelta(mvn))
        coef.betadelta(mvn)
        vcov.betadelta(mvn)
        confint.betadelta(mvn)
        adf <- BetaDelta(object, type = "adf")
        print.betadelta(adf)
        summary.betadelta(adf)
        print.summary.betadelta(summary.betadelta(adf))
        coef.betadelta(adf)
        vcov.betadelta(adf)
        confint.betadelta(adf)
        object <- lm(QUALITY ~ NARTIC, data = df)
        mvn <- BetaDelta(object, type = "mvn")
        print.betadelta(mvn)
        summary.betadelta(mvn)
        print.summary.betadelta(summary.betadelta(mvn))
        coef.betadelta(mvn)
        vcov.betadelta(mvn)
        confint.betadelta(mvn)
        adf <- BetaDelta(object, type = "adf")
        print.betadelta(adf)
        summary.betadelta(adf)
        print.summary.betadelta(summary.betadelta(adf))
        coef.betadelta(adf)
        vcov.betadelta(adf)
        confint.betadelta(adf)
        testthat::expect_true(
          TRUE
        )
      }
    )
  },
  text = "test-betaDelta-beta-delta-methods"
)
