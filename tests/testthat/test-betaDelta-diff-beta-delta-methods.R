## ---- test-betaDelta-diff-beta-delta-methods
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
    mvn <- DiffBetaDelta(BetaDelta(object, type = "mvn"))
    print.diffbetadelta(mvn)
    summary.diffbetadelta(mvn)
    coef.diffbetadelta(mvn)
    vcov.diffbetadelta(mvn)
    confint.diffbetadelta(mvn)
    adf <- DiffBetaDelta(BetaDelta(object, type = "adf"))
    print.diffbetadelta(adf)
    summary.diffbetadelta(adf)
    coef.diffbetadelta(adf)
    vcov.diffbetadelta(adf)
    confint.diffbetadelta(adf)
  },
  text = "test-betaDelta-diff-beta-delta-methods"
)
