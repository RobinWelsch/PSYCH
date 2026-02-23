# Notes for Bayesian Regression with brms Module

# ===== WHY brms? =====
# So far we used conjugate models (Beta-Binomial) and BayesFactor.
# Real research often needs more flexible models:
#   - Multiple predictors
#   - Random effects
#   - Non-normal outcomes
# brms (Bayesian Regression Models using Stan) handles all of these
# using familiar R formula syntax.

# ===== MCMC AND HMC =====
# For most regression models, there is no closed-form posterior.
# We use Markov Chain Monte Carlo (MCMC) to approximate it.
#
# Hamiltonian Monte Carlo (HMC) is the MCMC algorithm used by Stan/brms.
# Unlike basic Metropolis-Hastings (random walk proposals), HMC uses
# the gradient (slope) of the posterior to make large, efficient moves.
# Think of it as rolling a ball on the posterior surface rather than
# stumbling around randomly.
#
# Key advantage: HMC explores high-dimensional parameter spaces much
# more efficiently than random-walk methods.

# ===== THE SCREEN TIME DATASET =====
# 150 participants reported:
#   - hours: average daily smartphone screen time (hours)
#   - wellbeing: WHO-5 wellbeing score (0-100)
#   - age: participant age

library(dplyr)
library(ggplot2)
library(brms)

# Visualize the relationship:
# screentime |> ggplot(aes(x = hours, y = wellbeing)) +
#   geom_point() +
#   geom_smooth(method = "lm") +
#   xlab("Daily Screen Time (hours)") +
#   ylab("Wellbeing (WHO-5)")

# ===== FREQUENTIST vs BAYESIAN REGRESSION =====
# Frequentist:
# lm(wellbeing ~ hours, data = screentime) |> summary()

# Bayesian with brms (syntax mirrors lm() almost exactly):
# fit1 <- brm(wellbeing ~ hours, data = screentime,
#             seed = 42, silent = 2, refresh = 0)
# summary(fit1)

# ===== INTERPRETING brms OUTPUT =====
# Estimate   -- Posterior mean (similar to frequentist coefficient)
# Est.Error  -- Posterior standard deviation
# l-95% CI   -- Lower bound of 95% credible interval
# u-95% CI   -- Upper bound of 95% credible interval
#
# Unlike a frequentist confidence interval, a 95% credible interval
# means there is a 95% probability the true parameter lies in this range.
#
# Convergence diagnostics:
# Rhat       -- Should be approximately 1.00. Compares between-chain
#               and within-chain variance. Values > 1.01 suggest
#               the chains have NOT converged.
# Bulk_ESS   -- Effective sample size for the bulk of the posterior.
#               Should be > 400 for reliable estimates.
# Tail_ESS   -- Effective sample size for the tails of the posterior.
#               Should also be > 400.

# ===== TRACE PLOTS =====
# plot(fit1)
# Left panels:  Posterior density for each parameter.
# Right panels: Trace plots -- the path of each MCMC chain.
#
# Good trace plots look like "hairy caterpillars":
#   - Chains overlap and mix well
#   - No trends, drifts, or stuck regions
# Bad signs:
#   - Chains look like distinct ribbons
#   - Long-term trends or drift
#   - Chains getting stuck in one region

# ===== ADDING COVARIATES =====
# Adding predictors works just like lm():
# fit2 <- brm(wellbeing ~ hours + age, data = screentime,
#             seed = 42, silent = 2, refresh = 0)
# summary(fit2)

# ===== PRIORS IN brms =====
# brms uses default weakly informative priors.
# You can inspect them with get_prior():
# get_prior(wellbeing ~ hours + age, data = screentime)
#
# You can set custom priors with set_prior():
# my_priors <- c(
#   set_prior("normal(-3, 2)", class = "b", coef = "hours"),
#   set_prior("normal(0, 1)", class = "b", coef = "age"),
#   set_prior("normal(70, 20)", class = "Intercept"),
#   set_prior("exponential(0.1)", class = "sigma")
# )
#
# fit3 <- brm(wellbeing ~ hours + age, data = screentime,
#             prior = my_priors, seed = 42, silent = 2, refresh = 0)
#
# Choosing priors:
#   - Use domain knowledge when possible
#   - Weakly informative priors regularize and prevent extreme estimates
#   - Sensitivity analysis: check if results change with different priors

# ===== COMPARISON TO lm() =====
# brms advantages:
#   - Full posterior distribution, not just point estimates
#   - Credible intervals have direct probabilistic interpretation
#   - Can incorporate prior knowledge
#   - Naturally handles complex models (multilevel, non-normal, etc.)
#
# brms considerations:
#   - Slower (requires MCMC sampling)
#   - Requires convergence checks (Rhat, ESS, trace plots)
#   - Need to think about priors (though defaults work well)

# Don't delete me!
saved <- "Y"
