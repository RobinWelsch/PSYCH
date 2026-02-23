# Notes for Bayesian Link Functions Module

# ===== LINK FUNCTIONS: WHY DO WE NEED THEM? =====
# A link function transforms the expected value of the outcome so that
# a linear model can be applied on the transformed scale.
# - Normal outcomes: identity link (no transformation needed)
# - Binary outcomes: logit link (log-odds)
# - Count outcomes: log link
# - Ordinal outcomes: cumulative logit link

# ===== PART 1: LOGISTIC REGRESSION (BINARY OUTCOMES) =====
# When the outcome is binary (0/1), we use logistic regression.
# The logit link transforms probability to log-odds:
#   logit(p) = log(p / (1 - p))
#
# In brms, use family = bernoulli():

library(brms)
library(dplyr)

# Fit a Bayesian logistic regression:
# fit_logistic <- brm(retained ~ condition, data = engagement,
#                     family = bernoulli(), seed = 42,
#                     silent = 2, refresh = 0)

# View the summary (coefficients on log-odds scale):
# summary(fit_logistic)

# Exponentiate to get odds ratios:
# fixef(fit_logistic) |> exp()
#
# Interpretation: an odds ratio of 2.5 means the odds of retention
# in the gamified group are 2.5 times the odds in the standard group.


# ===== PART 2: POISSON REGRESSION (COUNT OUTCOMES) =====
# When the outcome is a count (non-negative integers), we use Poisson regression.
# The log link ensures the predicted count is always positive:
#   log(mu) = b0 + b1*x
#   mu = exp(b0 + b1*x)
#
# In brms, use family = poisson():

# Fit a Bayesian Poisson regression:
# fit_poisson <- brm(daily_opens ~ condition, data = engagement,
#                    family = poisson(), seed = 42,
#                    silent = 2, refresh = 0)

# View the summary (coefficients on log scale):
# summary(fit_poisson)

# Exponentiate to get rate ratios:
# fixef(fit_poisson) |> exp()
#
# Interpretation: a rate ratio of 1.7 means the gamified group is
# expected to have 1.7 times as many daily opens as the standard group.


# ===== OVERDISPERSION AND NEGATIVE BINOMIAL =====
# Poisson assumes mean = variance (equidispersion).
# If variance >> mean, use negative binomial instead.
# The negative binomial adds a dispersion parameter (shape).
#
# In brms, use family = negbinomial():

# fit_negbin <- brm(daily_opens ~ condition, data = engagement,
#                   family = negbinomial(), seed = 42,
#                   silent = 2, refresh = 0)

# Compare Poisson vs negative binomial using LOO:
# fit_poisson <- add_criterion(fit_poisson, "loo")
# fit_negbin <- add_criterion(fit_negbin, "loo")
# loo_compare(fit_poisson, fit_negbin)
#
# The model with the higher ELPD (closer to 0) fits better.
# If elpd_diff is large relative to se_diff, the difference is meaningful.


# ===== PART 3: ORDINAL REGRESSION (ORDERED CATEGORIES) =====
# Likert scales (e.g., 1-5, 1-7) are ordered but not equally spaced.
# Ordinal regression uses the cumulative logit link.
# It models P(Y <= k) for each category k using threshold parameters.
#
# In brms, use family = cumulative("logit"):

# First, convert outcome to ordered factor:
# engagement$satisfaction <- factor(engagement$satisfaction, ordered = TRUE)

# Fit a Bayesian ordinal regression:
# fit_ordinal <- brm(satisfaction ~ condition, data = engagement,
#                    family = cumulative("logit"), seed = 42,
#                    silent = 2, refresh = 0)

# View the summary:
# summary(fit_ordinal)
#
# The Intercept parameters are threshold (cutpoint) parameters.
# They represent the log-odds of being at or below each category
# on the latent scale. The condition coefficient represents the
# shift on the latent scale between groups.


# ===== QUICK REFERENCE: CHOOSING THE RIGHT FAMILY =====
#
# Outcome Type       | brms Family         | Link Function    | Exponentiated Coeff
# -------------------|---------------------|------------------|--------------------
# Binary (0/1)       | bernoulli()         | logit            | Odds ratio
# Count (0,1,2,...)  | poisson()           | log              | Rate ratio
# Count (overdispersed)| negbinomial()     | log              | Rate ratio
# Ordinal (1-5, 1-7) | cumulative("logit")| cumulative logit | Odds ratio (cumulative)
# Continuous (normal) | gaussian()         | identity         | Raw coefficient
#
# Remember: always check whether the family assumptions fit your data.
# For counts, check for overdispersion. For ordinal, ensure ordered factor.

# Don't delete me!
saved <- "Y"
