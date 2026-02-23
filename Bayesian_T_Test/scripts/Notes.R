# Notes for Bayesian T-Test Module

# --- Bayesian T-Test with BayesFactor ---

library(BayesFactor)
library(see)

# ttestBF()
## The main function for running a Bayesian independent samples t-test.
## It returns a Bayes Factor (BF10) indicating how much more likely
## the data are under H1 (difference exists) vs H0 (no difference).

# Basic usage:
# ttestBF(formula = response ~ group, data = your_data)

# Example with darkmode data:
# ttestBF(formula = time ~ condition, data = darkmode)


# --- Comparing to frequentist t.test() ---

# Frequentist approach gives a p-value:
# t.test(time ~ condition, data = darkmode)

# Bayesian approach gives a Bayes Factor:
# ttestBF(formula = time ~ condition, data = darkmode)

# The key difference: p-values tell you P(data | H0),
# while Bayes Factors tell you P(data | H1) / P(data | H0).


# --- Bayes Factor Interpretation Table ---

# BF10 > 100   : Extreme evidence for H1
# BF10 > 30    : Very strong evidence for H1
# BF10 > 10    : Strong evidence for H1
# BF10 > 3     : Moderate evidence for H1
# BF10 1 to 3  : Anecdotal evidence for H1
# BF10 = 1     : No evidence either way
# BF10 1/3 to 1: Anecdotal evidence for H0
# BF10 < 1/3   : Moderate evidence for H0
# BF10 < 1/10  : Strong evidence for H0
# BF10 < 1/30  : Very strong evidence for H0
# BF10 < 1/100 : Extreme evidence for H0


# --- Extracting Posterior Samples ---

# Save the BF result first:
# bf_result <- ttestBF(formula = time ~ condition, data = darkmode)

# Sample from the posterior distribution:
# posterior_samples <- posterior(bf_result, iterations = 10000)

# Visualize posterior distributions:
# plot(posterior_samples)

# Numerical summary (means, quantiles):
# summary(posterior_samples)

# The 'delta' parameter is the standardized effect size (like Cohen's d).


# --- Prior Sensitivity (rscale) ---

# Default prior: rscale = "medium" (r = sqrt(2)/2 ~ 0.707)
# ttestBF(formula = time ~ condition, data = darkmode, rscale = "medium")

# Wider prior: rscale = "wide" (r = 1)
# ttestBF(formula = time ~ condition, data = darkmode, rscale = "wide")

# Ultra-wide prior: rscale = "ultrawide" (r = sqrt(2) ~ 1.414)
# ttestBF(formula = time ~ condition, data = darkmode, rscale = "ultrawide")

# You can also set a custom numeric value:
# ttestBF(formula = time ~ condition, data = darkmode, rscale = 0.5)

# If results are robust across different priors, your conclusions are stronger.


# --- One-Sided (Directional) Tests ---

# Use nullInterval to restrict the alternative hypothesis direction.

# Test for positive effect only (delta > 0):
# ttestBF(formula = time ~ condition, data = darkmode, nullInterval = c(0, Inf))

# Test for negative effect only (delta < 0):
# ttestBF(formula = time ~ condition, data = darkmode, nullInterval = c(-Inf, 0))


# --- Key Advantage ---

# Unlike frequentist tests, Bayes Factors can provide evidence FOR the null.
# A frequentist test can only reject or fail to reject H0.
# A Bayesian test can say "the data support H0 over H1."


# Don't delete me!
saved <- "Y"
