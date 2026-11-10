## ---- test-betaDelta-r-sq-delta
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    # effect size as a function of the covariance matrix
    es <- function(sigmacap) {
      rhocap <- stats::cov2cor(V = sigmacap)
      rhocapx <- rhocap[-1, -1, drop = FALSE]
      betastar <- drop(x = solve(a = rhocapx, b = rhocap[-1, 1]))
      rsq <- drop(x = crossprod(x = betastar, y = rhocapx %*% betastar))
      srsq <- betastar^2 / diag(x = solve(a = rhocapx))
      c(rsq, 1 - (1 - rsq) * (2000 - 1) / (2000 - 4))
    }
    n <- 2000
    x <- matrix(data = stats::rnorm(n = n * 3), ncol = 3)
    x[, 2] <- 0.5 * x[, 1] + x[, 2]
    y <- drop(
      x = x %*% c(0.4, 0.3, 0.2)
    ) + stats::rnorm(n = n) * sqrt(x = 1 + x[, 1]^2)
    colnames(x = x) <- c("x1", "x2", "x3")
    df <- data.frame(y = y, x)
    object <- stats::lm(formula = y ~ x1 + x2 + x3, data = df)

    testthat::test_that(
      desc = paste(text, "estimates"),
      code = {
        ref <- (function() {
          c(
            summary(object = object)$r.squared,
            summary(object = object)$adj.r.squared
          )
        })()
        for (type in c("mvn", "adf")) {
          testthat::expect_equal(
            object = unname(
              obj = stats::coef(
                object = RSqDelta(
                  object = BetaDelta(object = object, type = type)
                )
              )
            ),
            expected = unname(obj = ref),
            tolerance = tol
          )
        }
      }
    )

    testthat::test_that(
      desc = paste(
        text,
        "standard errors against a Monte Carlo of the same vcov"
      ),
      code = {
        k <- 4
        for (type in c("mvn", "adf")) {
          fit <- BetaDelta(object = object, type = type)
          sigmacap <- stats::cov(x = df)
          vech <- sigmacap[lower.tri(x = sigmacap, diag = TRUE)]
          draws <- matrix(
            data = stats::rnorm(n = 2e4 * length(x = vech)),
            ncol = length(x = vech)
          ) %*% chol(x = fit$gamma / n)
          draws <- sweep(x = draws, MARGIN = 2, STATS = vech, FUN = "+")
          values <- t(
            x = apply(
              X = draws,
              MARGIN = 1,
              FUN = function(v) {
                s <- matrix(data = 0, nrow = k, ncol = k)
                s[lower.tri(x = s, diag = TRUE)] <- v
                s[upper.tri(x = s)] <- t(x = s)[upper.tri(x = s)]
                es(sigmacap = s)
              }
            )
          )
          if (nrow(x = values) == 1) {
            values <- t(x = values)
          }
          out <- RSqDelta(object = fit)
          ratio <- sqrt(
            x = diag(x = stats::vcov(object = out))
          ) / apply(X = values, MARGIN = 2, FUN = stats::sd)
          testthat::expect_true(object = all(abs(x = ratio - 1) < 0.03))
        }
      }
    )

    testthat::test_that(
      desc = paste(text, "errors"),
      code = {
        testthat::expect_error(object = RSqDelta(object = object))
        testthat::expect_error(object = RSqDelta(object = list()))
        one <- BetaDelta(object = stats::lm(formula = y ~ x1, data = df))
        if (1 > 1) {
          testthat::expect_error(
            object = RSqDelta(object = one),
            regexp = "Two or more regressors"
          )
        } else {
          out <- RSqDelta(object = one)
          testthat::expect_true(
            object = all(
              is.finite(x = sqrt(x = diag(x = stats::vcov(object = out))))
            )
          )
        }
      }
    )
  },
  text = "test-betaDelta-r-sq-delta",
  tol = 1e-8
)
