## ---- test-deltaMethod-delta
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
        func <- function(x) {
          y <- exp(x = x)
          names(x = y) <- paste0("exp", "(", names(x = x), ")")
          y[-1]
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
        testthat::expect_error(
          object = Delta(
            coef = coef,
            vcov = vcov,
            func = func,
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
        func <- function(x) {
          y <- exp(x = x)
          names(x = y) <- paste0("exp", "(", names(x = x), ")")
          y[-1]
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
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
        func <- function(x) {
          y <- exp(x = x)
          names(x = y) <- paste0("exp", "(", names(x = x), ")")
          y[-1]
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
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
        func <- function(x) {
          y <- exp(x = x)
          names(x = y) <- paste0("exp", "(", names(x = x), ")")
          y[-1]
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
        print(x = out)
        summary(object = out)
        stats::coef(object = out)
        stats::vcov(object = out)
        stats::confint(object = out)
        func <- function(x) {
          y <- exp(x = x)
          names(x = y) <- paste0("exp", "(", names(x = x), ")")
          y
        }
        out <- Delta(
          coef = coef[2],
          vcov = vcov[2, 2, drop = FALSE],
          func = func,
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
  text = "test-deltaMethod-delta"
)
