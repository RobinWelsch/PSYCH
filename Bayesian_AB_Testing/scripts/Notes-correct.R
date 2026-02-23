# Notes for Bayesian A/B Testing Module

# ===== BAYESIAN STATISTICS: CORE IDEA =====
# Frequentist: P(data | H0) -- "How likely is this data if the null is true?"
# Bayesian:    P(H | data)  -- "How likely is my hypothesis given the data?"
#
# Bayes' Theorem:
#   P(theta | data) is proportional to P(data | theta) * P(theta)
#   Posterior = Likelihood * Prior

# ===== THE BETA DISTRIBUTION =====
# The Beta distribution is defined on [0, 1], perfect for modelling probabilities.
# Beta(alpha, beta):
#   - Mean = alpha / (alpha + beta)
#   - Can be interpreted as (alpha - 1) prior successes and (beta - 1) prior failures.

# Visualizing different Beta distributions:
# Uniform (no prior knowledge):
curve(dbeta(x, 1, 1), from = 0, to = 1,
      ylab = "Density", xlab = "Probability",
      main = "Beta(1,1) -- Uniform Prior")

# Weakly informative prior (centered around 0.5):
curve(dbeta(x, 5, 5), from = 0, to = 1,
      ylab = "Density", xlab = "Probability",
      main = "Beta(5,5) -- Weak Prior")

# Strong prior (centered around 0.7):
curve(dbeta(x, 14, 6), from = 0, to = 1,
      ylab = "Density", xlab = "Probability",
      main = "Beta(14,6) -- Strong Prior at 0.7")

# ===== CONJUGATE UPDATING =====
# The Beta distribution is the "conjugate prior" for binomial data.
# This means the posterior is also a Beta distribution:
#
#   Prior:     Beta(alpha, beta)
#   Data:      s successes, f failures
#   Posterior: Beta(alpha + s, beta + f)
#
# Example: Prior Beta(1,1), observe 7 successes and 3 failures:
#   Posterior = Beta(1+7, 1+3) = Beta(8, 4)

# Visualizing the update:
curve(dbeta(x, 1, 1), from = 0, to = 1,
      ylab = "Density", xlab = "Probability",
      main = "Prior to Posterior Update", lty = 2)
curve(dbeta(x, 8, 4), from = 0, to = 1, add = TRUE, col = "blue", lwd = 2)
legend("topleft", legend = c("Prior: Beta(1,1)", "Posterior: Beta(8,4)"),
       col = c("black", "blue"), lty = c(2, 1), lwd = c(1, 2))

# ===== BAYESIAN A/B TESTING =====
# To compare two groups (A and B), we:
# 1. Set a prior for each group's success probability.
# 2. Update each prior with the observed data.
# 3. Simulate from both posteriors.
# 4. Compute P(B > A) = proportion of simulations where B's draw > A's draw.

library(dplyr)

# Example using the chatbot data:
# Suppose Design A: 60 successes out of 100
# Suppose Design B: 75 successes out of 100

# Posterior for A: Beta(1 + 60, 1 + 40) = Beta(61, 41)
# Posterior for B: Beta(1 + 75, 1 + 25) = Beta(76, 26)

# Simulation approach:
set.seed(42)
samples_a <- rbeta(10000, 61, 41)
samples_b <- rbeta(10000, 76, 26)

# P(B > A):
mean(samples_b > samples_a)

# Visualize the difference:
diff_samples <- samples_b - samples_a
hist(diff_samples, breaks = 50, col = "lightblue",
     main = "Posterior Distribution of Difference (B - A)",
     xlab = "Difference in Success Probability")
abline(v = 0, col = "red", lwd = 2)

# 95% Credible Interval for the difference:
quantile(diff_samples, c(0.025, 0.975))

# ===== COMPARISON TO FREQUENTIST APPROACH =====
# The frequentist equivalent would be a two-sample proportion test:
# prop.test(x = c(60, 75), n = c(100, 100))
#
# Key differences:
# - Frequentist p-value: P(data this extreme | H0 is true)
#   NOT the probability that H0 is true.
# - Bayesian P(B > A): Direct probability that B is better than A.
#   This is often what researchers actually want to know.
# - No arbitrary alpha threshold in Bayesian analysis.
# - Bayesian analysis provides a full posterior distribution,
#   not just a point estimate and CI.

# Don't delete me!
saved <- "Y"
