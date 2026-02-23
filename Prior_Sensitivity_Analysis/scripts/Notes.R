# Notes for Prior Sensitivity Analysis Module

# ===== WHAT IS PRIOR SENSITIVITY ANALYSIS? =====
# In Bayesian analysis, we choose a prior distribution.
# Prior sensitivity analysis asks: does our conclusion change
# if we choose a different prior?
# If the answer is "no," our results are robust.

# ===== THE DATASET =====
# 90 participants compared swipe-typing vs tap-typing on smartphones.
# DV: words per minute (WPM).
# Swipe: mean ~ 38 WPM, SD ~ 8
# Tap:   mean ~ 32 WPM, SD ~ 7

library(dplyr)
library(BayesFactor)
library(see)

# Explore the data:
typing |> head()
typing |> group_by(method) |> summarise(M = mean(wpm), SD = sd(wpm))

# ===== BAYESIAN T-TEST WITH DIFFERENT PRIORS =====
# The BayesFactor package uses a Cauchy prior on effect size (delta).
# The "rscale" parameter controls the width of this prior:
#   medium    = sqrt(2)/2 ~ 0.707
#   wide      = 1
#   ultrawide = sqrt(2)   ~ 1.414

bf_medium    <- ttestBF(formula = wpm ~ method, data = typing, rscale = "medium")
bf_wide      <- ttestBF(formula = wpm ~ method, data = typing, rscale = "wide")
bf_ultrawide <- ttestBF(formula = wpm ~ method, data = typing, rscale = "ultrawide")

# Compare the three:
bf_medium
bf_wide
bf_ultrawide

# If all three tell the same qualitative story, the conclusion is robust.

# ===== SENSITIVITY PLOT =====
# Systematically vary the prior scale and plot BF as a function of it.

scales <- seq(0.1, 2.0, by = 0.1)
bf_values <- sapply(scales, function(r) {
  extractBF(ttestBF(formula = wpm ~ method, data = typing, rscale = r))$bf
})

# extractBF() extracts the numeric Bayes Factor from a BFBayesFactor object.

plot(scales, bf_values, type = "b",
     xlab = "Prior Scale (r)", ylab = "Bayes Factor",
     main = "Sensitivity Analysis", pch = 19)
abline(h = 3, lty = 2, col = "red")    # BF = 3: moderate evidence for H1
abline(h = 1/3, lty = 2, col = "blue") # BF = 1/3: moderate evidence for H0

# The Bayes factor robustness region is the range of prior scales
# over which the qualitative conclusion remains the same.

# ===== INFORMATIVE VS NON-INFORMATIVE PRIORS =====
# Non-informative (default) priors express minimal prior knowledge.
# Informative priors incorporate domain knowledge from prior research.
#
# Example: comparing Beta priors of varying strength
# Beta(1, 1)   = uniform / no prior knowledge
# Beta(10, 10) = moderate prior centred at 0.5
# Beta(50, 50) = strong prior centred at 0.5

prior_weak     <- dbeta(seq(0, 1, 0.01), 1, 1)
prior_moderate <- dbeta(seq(0, 1, 0.01), 10, 10)
prior_strong   <- dbeta(seq(0, 1, 0.01), 50, 50)

plot(seq(0, 1, 0.01), prior_strong, type = "l", col = "red",
     ylab = "Density", xlab = "Probability", main = "Comparing Priors")
lines(seq(0, 1, 0.01), prior_moderate, col = "blue")
lines(seq(0, 1, 0.01), prior_weak, col = "green")

# ===== REPORTING SENSITIVITY ANALYSES =====
# Always include a sensitivity analysis in your Bayesian write-ups:
# 1. Run the analysis with at least 3 different prior settings.
# 2. Create a sensitivity plot (BF vs prior scale).
# 3. Report the robustness region.
# 4. If using informative priors, also report results under default priors.
# This transparency strengthens the credibility of your findings.

# Don't delete me!
saved <- "Y"
