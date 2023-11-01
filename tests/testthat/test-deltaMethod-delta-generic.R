## ---- test-deltaMethod-delta-generic
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
    message(text)
    object <- glm(
      formula = vs ~ wt + disp,
      family = "binomial",
      data = mtcars
    )
    coef <- coef(object)
    vcov <- vcov(object)
    est <- exp(coef)
    grad <- est
    se <- c(
      sqrt(grad[2] %*% vcov[2, 2] %*% grad[2]),
      sqrt(grad[3] %*% vcov[3, 3] %*% grad[3])
    )
    def <- list(
      "exp(wt)",
      "exp(disp)"
    )
    out <- DeltaGeneric(
      object = object,
      def = def,
      alpha = 0.05
    )
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::expect_error(
          DeltaGeneric(
            object = object,
            def = def,
            alpha = 0.05,
            z = FALSE
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "est"),
      {
        testthat::expect_true(
          all(
            abs(
              est[-1] - out$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "se"),
      {
        testthat::expect_true(
          all(
            abs(
              se - sqrt(diag(out$vcov))
            ) <= tol
          )
        )
      }
    )
    # coverage
    print(out)
    summary(out)
    coef(out)
    vcov(out)
    confint(out)
    out <- DeltaGeneric(
      object = object,
      def = list("exp(wt)"),
      alpha = 0.05,
      z = FALSE,
      df = 30
    )
    print(out)
    summary(out)
    coef(out)
    vcov(out)
    confint(out)
  },
  tol = 0.0001,
  text = "test-deltaMethod-delta-generic"
)
