## ---- test-betaDelta-r-sq-beta-delta-methods
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
    mvn <- rsq(BetaDelta(object, type = "mvn"))
    print.rsqbetadelta(mvn)
    summary.rsqbetadelta(mvn)
    coef.rsqbetadelta(mvn)
    vcov.rsqbetadelta(mvn)
    confint.rsqbetadelta(mvn)
    adf <- rsq(BetaDelta(object, type = "adf"))
    print.rsqbetadelta(adf)
    summary.rsqbetadelta(adf)
    coef.rsqbetadelta(adf)
    vcov.rsqbetadelta(adf)
    confint.rsqbetadelta(adf)
    object <- lm(QUALITY ~ NARTIC, data = df)
    mvn <- rsq(BetaDelta(object, type = "mvn"))
    print.rsqbetadelta(mvn)
    summary.rsqbetadelta(mvn)
    coef.rsqbetadelta(mvn)
    vcov.rsqbetadelta(mvn)
    confint.rsqbetadelta(mvn)
    adf <- rsq(BetaDelta(object, type = "adf"))
    print.rsqbetadelta(adf)
    summary.rsqbetadelta(adf)
    coef.rsqbetadelta(adf)
    vcov.rsqbetadelta(adf)
    confint.rsqbetadelta(adf)
  },
  text = "test-betaDelta-r-sq-beta-delta-methods"
)
