
library(bsvarSIGNs)
data(optimism)

burn = 1000
S    = 10000

# forecasting for a model with estimated hyper-parameters
############################################################
set.seed(123)

# specify the model
spec = specify_bsvarSIGN$new(
  optimism[,c(1,2,5)],
  p        = 4,
)

spec$prior$estimate_hyper(S + burn, burn, mu = TRUE, delta = TRUE, lambda = TRUE, psi = TRUE)
rownames(spec$prior$hyper) = c("mu", "delta", "lambda", paste0("psi", 1:3))
plot.ts(t(spec$prior$hyper), col = "#F500BD", bty ="n")

# estimate the model
post = estimate(spec, S = S)

# forecast
fore = forecast(post, 8)
plot(fore, data_in_plot = 0.5, probability = 0.68, col = "#F500BD")

# forecasting for a model with fixed hyper-parameters
############################################################
set.seed(123)

# specify the model
spec_fix = specify_bsvarSIGN$new(
  optimism[,c(1,2,5)],
  p        = 4,
)
rownames(spec_fix$prior$hyper) = c("mu", "delta", "lambda", paste0("psi", 1:3))
spec_fix$prior$hyper

# estimate the model
post_fix = estimate(spec_fix, S = S)

# forecast
fore_fix = forecast(post_fix, 8)
plot(fore_fix, data_in_plot = 0.5, probability = 0.68, col = "#F500BD")
