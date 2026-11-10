## ---- test-betaDelta-jac-theta-star-wrt-vech-sigma
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    Value <- function(vech,
                      k) {
      sigmacap <- matrix(data = 0, nrow = k, ncol = k)
      sigmacap[lower.tri(x = sigmacap, diag = TRUE)] <- vech
      sigmacap[upper.tri(
        x = sigmacap
      )] <- t(x = sigmacap)[upper.tri(x = sigmacap)]
      sigma <- sqrt(x = diag(x = sigmacap))
      beta <- solve(a = sigmacap[-1, -1, drop = FALSE], b = sigmacap[-1, 1])
      c(beta * sigma[-1] / sigma[1], sigma)
    }
    for (p in c(1, 2, 4)) {
      testthat::test_that(
        desc = paste(text, "p =", p),
        code = {
          k <- p + 1
          a <- matrix(data = stats::rnorm(n = k * k), nrow = k)
          sigmacap <- crossprod(x = a) + diag(x = k)
          vech <- sigmacap[lower.tri(x = sigmacap, diag = TRUE)]
          sigma <- sqrt(x = diag(x = sigmacap))
          jcap <- .JacThetaStarWRTVechSigma(
            beta = solve(
              a = sigmacap[-1, -1, drop = FALSE],
              b = sigmacap[-1, 1]
            ),
            sigmay = sigma[1],
            sigmax = sigma[-1],
            invsigmacapx = solve(a = sigmacap[-1, -1, drop = FALSE]),
            p = p,
            k = k
          )
          num <- sapply(
            X = seq_along(along.with = vech),
            FUN = function(i) {
              e <- replace(x = 0 * vech, list = i, values = 1e-6)
              (Value(
                vech = vech + e,
                k = k
              ) - Value(vech = vech - e, k = k)) / 2e-6
            }
          )
          testthat::expect_true(
            object = max(abs(x = unname(obj = jcap) - num)) < tol
          )
        }
      )
    }
  },
  text = "test-betaDelta-jac-theta-star-wrt-vech-sigma",
  tol = 1e-6
)
