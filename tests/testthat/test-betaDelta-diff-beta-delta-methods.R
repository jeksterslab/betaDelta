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
    mvn <- dif(BetaDelta(object, type = "mvn"))
    print.difbetadelta(mvn)
    summary.difbetadelta(mvn)
    coef.difbetadelta(mvn)
    vcov.difbetadelta(mvn)
    confint.difbetadelta(mvn)
    adf <- dif(BetaDelta(object, type = "adf"))
    print.difbetadelta(adf)
    summary.difbetadelta(adf)
    coef.difbetadelta(adf)
    vcov.difbetadelta(adf)
    confint.difbetadelta(adf)
  },
  text = "test-betaDelta-diff-beta-delta-methods"
)
