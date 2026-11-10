## ---- test-deltaMethod-delta-generic
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "error"),
      code = {
        object <- stats::glm(
          formula = vs ~ wt + disp,
          family = "binomial",
          data = mtcars
        )
        coef <- stats::coef(object = object)
        vcov <- stats::vcov(object = object)
        est <- exp(x = coef)
        grad <- est
        se <- c(
          sqrt(x = grad[2] %*% vcov[2, 2] %*% grad[2]),
          sqrt(x = grad[3] %*% vcov[3, 3] %*% grad[3])
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
        testthat::expect_error(
          object = DeltaGeneric(
            object = object,
            def = def,
            alpha = 0.05,
            z = FALSE
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "est"),
      code = {
        object <- stats::glm(
          formula = vs ~ wt + disp,
          family = "binomial",
          data = mtcars
        )
        coef <- stats::coef(object = object)
        vcov <- stats::vcov(object = object)
        est <- exp(x = coef)
        grad <- est
        se <- c(
          sqrt(x = grad[2] %*% vcov[2, 2] %*% grad[2]),
          sqrt(x = grad[3] %*% vcov[3, 3] %*% grad[3])
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
        testthat::expect_true(
          object = all(
            abs(
              x = est[-1] - out$est
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "se"),
      code = {
        object <- stats::glm(
          formula = vs ~ wt + disp,
          family = "binomial",
          data = mtcars
        )
        coef <- stats::coef(object = object)
        vcov <- stats::vcov(object = object)
        est <- exp(x = coef)
        grad <- est
        se <- c(
          sqrt(x = grad[2] %*% vcov[2, 2] %*% grad[2]),
          sqrt(x = grad[3] %*% vcov[3, 3] %*% grad[3])
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
        testthat::expect_true(
          object = all(
            abs(
              x = se - sqrt(x = diag(x = out$vcov))
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "coverage"),
      code = {
        object <- stats::glm(
          formula = vs ~ wt + disp,
          family = "binomial",
          data = mtcars
        )
        coef <- stats::coef(object = object)
        vcov <- stats::vcov(object = object)
        est <- exp(x = coef)
        grad <- est
        se <- c(
          sqrt(x = grad[2] %*% vcov[2, 2] %*% grad[2]),
          sqrt(x = grad[3] %*% vcov[3, 3] %*% grad[3])
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
        print(x = out)
        summary(object = out)
        stats::coef(object = out)
        stats::vcov(object = out)
        stats::confint(object = out)
        out <- DeltaGeneric(
          object = object,
          def = list("exp(wt)"),
          alpha = 0.05,
          z = FALSE,
          df = 30
        )
        print(x = out)
        summary(object = out)
        stats::coef(object = out)
        stats::vcov(object = out)
        stats::confint(object = out)
        testthat::expect_true(
          object = TRUE
        )
      }
    )
  },
  tol = 0.0001,
  text = "test-deltaMethod-delta-generic"
)
