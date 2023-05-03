.BetaDelta <- function(lm_process,
                       type) {
  gamma <- .Gamma(
    object = lm_process,
    type = type
  )
  acov <- .ACovDelta(
    jcap = .JacobianBetaStarWRTVechSigma(
      beta = lm_process$beta,
      sigmay = sqrt(lm_process$sigmacap[1, 1]),
      sigmax = sqrt(diag(lm_process$sigmacap)[-1]),
      invsigmacapx = chol2inv(
        chol(
          lm_process$sigmacap[
            2:lm_process$k,
            2:lm_process$k,
            drop = FALSE
          ]
        )
      ),
      p = lm_process$p,
      k = lm_process$k
    ),
    acov = gamma
  )
  colnames(acov) <- rownames(acov) <- lm_process$xnames
  vcov <- (1 / lm_process$n) * acov
  return(
    list(
      gamma = gamma,
      acov = acov,
      vcov = vcov,
      est = lm_process$betastar
    )
  )
}
