## ---- test-betaDelta-delta-r-sq-delta
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    message(text)

    set.seed(42)

    if (!identical(Sys.getenv("NOT_CRAN"), "true") && !interactive()) {
      message("CRAN: tests skipped.")
      # nolint start
      return(invisible(NULL))
      # nolint end
    }

    # effect size as a function of the covariance matrix
    es <- function(sigmacap) {
      rhocap <- stats::cov2cor(sigmacap)
      rhocapx <- rhocap[-1, -1, drop = FALSE]
      betastar <- drop(solve(rhocapx, rhocap[-1, 1]))
      rsq <- drop(crossprod(betastar, rhocapx %*% betastar))
      srsq <- betastar^2 / diag(solve(rhocapx))
      srsq
    }
    n <- 2000
    x <- matrix(data = stats::rnorm(n * 3), ncol = 3)
    x[, 2] <- 0.5 * x[, 1] + x[, 2]
    y <- drop(x %*% c(0.4, 0.3, 0.2)) + stats::rnorm(n) * sqrt(1 + x[, 1]^2)
    colnames(x) <- c("x1", "x2", "x3")
    df <- data.frame(y = y, x)
    object <- lm(y ~ x1 + x2 + x3, data = df)

    testthat::test_that(
      paste(text, "estimates"),
      {
        testthat::skip_on_cran()
        ref <- (function() {
          r2 <- summary(object)$r.squared
          sapply(1:3, function(j) r2 - summary(stats::lm(df$y ~ as.matrix(df[paste0("x", setdiff(1:3, j))])))$r.squared)
        })()
        for (type in c("mvn", "adf")) {
          testthat::expect_equal(
            unname(coef(DeltaRSqDelta(BetaDelta(object, type = type)))),
            unname(ref),
            tolerance = tol
          )
        }
      }
    )

    testthat::test_that(
      paste(text, "standard errors against a Monte Carlo of the same vcov"),
      {
        testthat::skip_on_cran()
        k <- 4
        for (type in c("mvn", "adf")) {
          fit <- BetaDelta(object, type = type)
          sigmacap <- stats::cov(df)
          vech <- sigmacap[lower.tri(sigmacap, diag = TRUE)]
          draws <- matrix(
            data = stats::rnorm(2e4 * length(vech)),
            ncol = length(vech)
          ) %*% chol(fit$gamma / n)
          draws <- sweep(draws, 2, vech, "+")
          values <- t(
            apply(
              X = draws,
              MARGIN = 1,
              FUN = function(v) {
                s <- matrix(data = 0, nrow = k, ncol = k)
                s[lower.tri(s, diag = TRUE)] <- v
                s[upper.tri(s)] <- t(s)[upper.tri(s)]
                es(s)
              }
            )
          )
          if (nrow(values) == 1) {
            values <- t(values)
          }
          out <- DeltaRSqDelta(fit)
          ratio <- sqrt(diag(vcov(out))) / apply(values, 2, stats::sd)
          testthat::expect_true(all(abs(ratio - 1) < 0.03))
        }
      }
    )

    testthat::test_that(
      paste(text, "errors"),
      {
        testthat::skip_on_cran()
        testthat::expect_error(DeltaRSqDelta(object))
        testthat::expect_error(DeltaRSqDelta(list()))
        one <- BetaDelta(lm(y ~ x1, data = df))
        if (2 > 1) {
          testthat::expect_error(
            DeltaRSqDelta(one),
            "Two or more regressors"
          )
        } else {
          out <- DeltaRSqDelta(one)
          testthat::expect_true(all(is.finite(sqrt(diag(vcov(out))))))
        }
      }
    )
  },
  text = "test-betaDelta-delta-r-sq-delta",
  tol = 1e-8
)
