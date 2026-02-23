# Notes for Understanding the Posterior Module

# Normal-Normal Conjugate Model
# When we have continuous data with a normal likelihood and a normal prior
# on the mean, the posterior is also normal. This is called conjugacy.

# The posterior combines the prior and the data through precision-weighting.
# Precision = 1 / variance. Higher precision = more certainty = more weight.

# Posterior variance (inverse of total precision):
# post_var = 1 / (1/prior_var + n/data_var)

# Posterior mean (precision-weighted average):
# post_mean = post_var * (prior_mean/prior_var + n*sample_mean/data_var)

# --- Computing the posterior for a mean ---

# Step 1: Summarize the data
sample_mean <- mean(presence$rating)
sample_var <- var(presence$rating)
n <- nrow(presence)

# Step 2: Define the prior
# A weakly informative prior centered at the midpoint of the scale
prior_mean <- 50
prior_var <- 400   # SD = 20

# Step 3: Compute the posterior
post_var <- 1 / (1/prior_var + n/sample_var)
post_mean <- post_var * (prior_mean/prior_var + n*sample_mean/sample_var)

# --- Plotting prior, likelihood, and posterior ---
curve(dnorm(x, prior_mean, sqrt(prior_var)),
      from = 30, to = 90, col = "red",
      ylab = "Density", xlab = "Mean Presence Rating",
      main = "Prior, Likelihood, and Posterior")
curve(dnorm(x, sample_mean, sqrt(sample_var/n)),
      add = TRUE, col = "green")
curve(dnorm(x, post_mean, sqrt(post_var)),
      add = TRUE, col = "blue", lwd = 2)
legend("topright", legend = c("Prior", "Likelihood", "Posterior"),
       col = c("red", "green", "blue"), lty = 1, lwd = c(1, 1, 2))

# --- Credible Intervals ---
# A 95% credible interval: there is a 95% probability the parameter
# lies within this interval, given the data and prior.
ci_95 <- qnorm(c(0.025, 0.975), mean = post_mean, sd = sqrt(post_var))
ci_95

# This is NOT the same as a frequentist confidence interval!
# - Credible interval: direct probability statement about the parameter.
# - Confidence interval: long-run frequency property about the procedure.

# --- Posterior Predictive Distribution ---
# Accounts for two sources of uncertainty:
# 1. Parameter uncertainty (from the posterior)
# 2. Sampling variability (from the likelihood)
set.seed(42)
pred_mu <- rnorm(10000, post_mean, sqrt(post_var))
pred_data <- rnorm(10000, pred_mu, sqrt(sample_var))
hist(pred_data, breaks = 30,
     main = "Posterior Predictive Distribution",
     xlab = "Predicted Rating")

# The posterior predictive distribution is wider than the posterior
# because it includes both parameter uncertainty AND data variability.

# Don't delete me!
saved <- "Y"
