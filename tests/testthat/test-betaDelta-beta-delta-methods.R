## ---- test-betaDelta-beta-delta-methods
lapply(
  X = 1,
  FUN = function(i,
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
    mvn <- BetaDelta(object, type = "mvn")
    print.betadelta(mvn)
    summary.betadelta(mvn)
    coef.betadelta(mvn)
    vcov.betadelta(mvn)
    confint.betadelta(mvn)
    adf <- BetaDelta(object, type = "adf")
    print.betadelta(adf)
    summary.betadelta(adf)
    coef.betadelta(adf)
    vcov.betadelta(adf)
    confint.betadelta(adf)
    object <- lm(QUALITY ~ NARTIC, data = df)
    mvn <- BetaDelta(object, type = "mvn")
    print.betadelta(mvn)
    summary.betadelta(mvn)
    coef.betadelta(mvn)
    vcov.betadelta(mvn)
    confint.betadelta(mvn)
    adf <- BetaDelta(object, type = "adf")
    print.betadelta(adf)
    summary.betadelta(adf)
    coef.betadelta(adf)
    vcov.betadelta(adf)
    confint.betadelta(adf)
  },
  text = "test-betaDelta-beta-delta-methods"
)
