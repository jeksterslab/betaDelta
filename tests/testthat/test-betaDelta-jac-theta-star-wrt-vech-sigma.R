## ---- test-betaDelta-jac-theta-star-wrt-vech-sigma
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

    Value <- function(vech,
                      k) {
      sigmacap <- matrix(data = 0, nrow = k, ncol = k)
      sigmacap[lower.tri(sigmacap, diag = TRUE)] <- vech
      sigmacap[upper.tri(sigmacap)] <- t(sigmacap)[upper.tri(sigmacap)]
      sigma <- sqrt(diag(sigmacap))
      beta <- solve(sigmacap[-1, -1, drop = FALSE], sigmacap[-1, 1])
      c(beta * sigma[-1] / sigma[1], sigma)
    }
    for (p in c(1, 2, 4)) {
      testthat::test_that(
        paste(text, "p =", p),
        {
          testthat::skip_on_cran()
          k <- p + 1
          a <- matrix(data = stats::rnorm(k * k), nrow = k)
          sigmacap <- crossprod(a) + diag(k)
          vech <- sigmacap[lower.tri(sigmacap, diag = TRUE)]
          sigma <- sqrt(diag(sigmacap))
          jcap <- .JacThetaStarWRTVechSigma(
            beta = solve(sigmacap[-1, -1, drop = FALSE], sigmacap[-1, 1]),
            sigmay = sigma[1],
            sigmax = sigma[-1],
            invsigmacapx = solve(sigmacap[-1, -1, drop = FALSE]),
            p = p,
            k = k
          )
          num <- sapply(
            X = seq_along(vech),
            FUN = function(i) {
              e <- replace(0 * vech, i, 1e-6)
              (Value(vech + e, k) - Value(vech - e, k)) / 2e-6
            }
          )
          testthat::expect_true(max(abs(unname(jcap) - num)) < tol)
        }
      )
    }
  },
  text = "test-betaDelta-jac-theta-star-wrt-vech-sigma",
  tol = 1e-6
)
