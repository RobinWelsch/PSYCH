# Notes for Bayesian Hierarchical Models Module

# ===== WHY HIERARCHICAL MODELS? =====
# In HCI, data is often nested: participants within studies,
# tasks within users, trials within conditions.
# Standard regression assumes independence -- violated with grouped data.
#
# Three approaches to grouped data:
#   1. Complete pooling: Ignore groups, fit one model to all data.
#   2. No pooling: Fit a separate model per group.
#   3. Partial pooling (hierarchical): Share information across groups,
#      shrinking group estimates toward the overall mean.

library(dplyr)
library(ggplot2)
library(brms)

# ===== THE DATASET =====
# 200 participants across 10 websites, each completing 5 tasks.
# DV: task completion time (seconds)
# Predictor: task_difficulty (1-5)

# Explore the data:
usability |> head()
usability |> group_by(website) |>
  summarise(M = mean(time), SD = sd(time), N = n())

# ===== COMPLETE POOLING MODEL =====
# Ignores the website grouping entirely.
# This treats all observations as independent.
fit_pooled <- brm(time ~ task_difficulty,
                  data = usability,
                  seed = 42, silent = 2, refresh = 0)
summary(fit_pooled)

# ===== VARYING INTERCEPTS MODEL =====
# (1 | website) adds a random intercept per website.
# Each website gets its own baseline time, but the effect
# of task_difficulty is assumed the same across websites.
# The syntax is identical to lme4/lmerTest.
fit_hier <- brm(time ~ task_difficulty + (1 | website),
                data = usability,
                seed = 42, silent = 2, refresh = 0)
summary(fit_hier)

# Extract the random effects (deviations from grand mean):
ranef(fit_hier)

# ===== SHRINKAGE =====
# Partial pooling shrinks group estimates toward the grand mean.
# Groups with fewer observations or more extreme values are
# shrunk more. This reduces overfitting and improves predictions.

# ===== VARYING INTERCEPTS AND SLOPES =====
# (1 + task_difficulty | website) allows both the intercept
# and the slope of task_difficulty to vary across websites.
# This means some websites may show a stronger effect of
# task difficulty on completion time than others.
fit_slopes <- brm(time ~ task_difficulty + (1 + task_difficulty | website),
                  data = usability,
                  seed = 42, silent = 2, refresh = 0)
summary(fit_slopes)

# ===== MODEL COMPARISON WITH LOO-CV =====
# Leave-One-Out Cross-Validation estimates predictive accuracy.
# ELPD = Expected Log Pointwise Predictive Density (higher is better).
# A model with a more negative ELPD difference is worse at prediction.
fit_pooled <- add_criterion(fit_pooled, "loo")
fit_hier <- add_criterion(fit_hier, "loo")
loo_compare(fit_pooled, fit_hier)

# ===== SUMMARY =====
# Hierarchical models handle grouped data via partial pooling.
# brms makes them as easy to fit as lme4 models, with full
# posterior distributions and principled model comparison (LOO-CV).
# Key syntax:
#   (1 | group)           -- varying intercepts
#   (1 + predictor | group) -- varying intercepts and slopes

# Don't delete me!
saved <- "Y"
