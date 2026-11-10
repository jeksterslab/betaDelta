## ---- test-betaDelta-es-delta-methods
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(
        text,
        "methods for every function and covariance estimator"
      ),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaDelta"
            ),
            silent = TRUE
          )
        }
        object <- stats::lm(
          formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
          data = nas1982
        )
        fits <- list(
          BetaDelta(object = object, type = "mvn"),
          BetaDelta(object = object, type = "adf")
        )
        funs <- list(
          RSqDelta = RSqDelta,
          SCorDelta = SCorDelta,
          PCorDelta = PCorDelta,
          DeltaRSqDelta = DeltaRSqDelta,
          FSqDelta = FSqDelta,
          DiffBetaDelta = DiffBetaDelta
        )
        for (fit in fits) {
          for (fun in names(x = funs)) {
            out <- funs[[fun]](fit, alpha = c(0.05, 0.01))
            testthat::expect_s3_class(object = out, class = "esdelta")
            testthat::expect_identical(object = out$fun, expected = fun)
            testthat::expect_output(
              object = print(x = out),
              regexp = "standard errors"
            )
            testthat::expect_output(
              object = print(x = out, alpha = 0.10, digits = 2)
            )
            sum_out <- summary(object = out)
            testthat::expect_s3_class(
              object = sum_out,
              class = "summary.esdelta"
            )
            testthat::expect_output(
              object = print(x = sum_out),
              regexp = toupper(x = fit$args$type)
            )
            testthat::expect_equal(
              object = sum_out[, "est"],
              expected = stats::coef(object = out)
            )
            testthat::expect_equal(
              object = unname(obj = sum_out[, "se"]),
              expected = unname(
                obj = sqrt(x = diag(x = stats::vcov(object = out)))
              )
            )
            testthat::expect_identical(
              object = colnames(x = summary(object = out)),
              expected = c(
                "est",
                "se",
                "z",
                "p",
                "0.5%",
                "2.5%",
                "97.5%",
                "99.5%"
              )
            )
            ci <- stats::confint(object = out)
            testthat::expect_identical(
              object = colnames(x = ci),
              expected = c("2.5 %", "97.5 %")
            )
            testthat::expect_identical(
              object = rownames(x = ci),
              expected = names(x = stats::coef(object = out))
            )
            testthat::expect_true(
              object = all(ci[, 1] < stats::coef(object = out))
            )
            testthat::expect_true(
              object = all(ci[, 2] > stats::coef(object = out))
            )
            testthat::expect_equal(
              object = as.vector(
                x = stats::confint(object = out, parm = 1, level = 0.90)
              ),
              expected = as.vector(
                x = stats::coef(
                  object = out
                )[1] + stats::qnorm(p = c(0.05, 0.95)) *
                  sqrt(x = diag(x = stats::vcov(object = out)))[1]
              )
            )
            testthat::expect_error(
              object = summary(object = out, alpha = 1.5)
            )
          }
        }
        testthat::expect_s3_class(
          object = DiffBetaDelta(object = fits[[1]]),
          class = "diffbetadelta"
        )
      }
    )
  },
  text = "test-betaDelta-es-delta-methods"
)
