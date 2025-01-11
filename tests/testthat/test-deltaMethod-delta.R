## ---- test-deltaMethod-delta
lapply(
  X = 1,
  FUN = function(i,
                 tol,
                 text) {
    message(text)
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::skip_on_cran()
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
        func <- function(x) {
          y <- exp(x)
          names(y) <- paste0("exp", "(", names(x), ")")
          return(y[-1])
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
        testthat::expect_error(
          Delta(
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
      paste(text, "est"),
      {
        testthat::skip_on_cran()
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
        func <- function(x) {
          y <- exp(x)
          names(y) <- paste0("exp", "(", names(x), ")")
          return(y[-1])
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
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
        testthat::skip_on_cran()
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
        func <- function(x) {
          y <- exp(x)
          names(y) <- paste0("exp", "(", names(x), ")")
          return(y[-1])
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
        testthat::expect_true(
          all(
            abs(
              se - sqrt(diag(out$vcov))
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "coverage"),
      {
        testthat::skip_on_cran()
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
        func <- function(x) {
          y <- exp(x)
          names(y) <- paste0("exp", "(", names(x), ")")
          return(y[-1])
        }
        out <- Delta(
          coef = coef,
          vcov = vcov,
          func = func,
          alpha = 0.05
        )
        print(out)
        summary(out)
        coef(out)
        vcov(out)
        confint(out)
        func <- function(x) {
          y <- exp(x)
          names(y) <- paste0("exp", "(", names(x), ")")
          return(y)
        }
        out <- Delta(
          coef = coef[2],
          vcov = vcov[2, 2, drop = FALSE],
          func = func,
          alpha = 0.05,
          z = FALSE,
          df = 30
        )
        print(out)
        summary(out)
        coef(out)
        vcov(out)
        confint(out)
        testthat::expect_true(
          TRUE
        )
      }
    )
  },
  tol = 0.0001,
  text = "test-deltaMethod-delta"
)
