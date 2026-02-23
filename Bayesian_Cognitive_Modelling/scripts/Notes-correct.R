# Notes for Bayesian Cognitive Modelling Module

# ===== PART 1: FITTS' LAW =====
# Fitts' law is one of the most robust models in HCI.
# It predicts movement time as a linear function of Index of Difficulty:
#
#   MT = a + b * ID
#
# where:
#   ID = log2(2D / W)     -- Index of Difficulty (in bits)
#   D  = distance to target
#   W  = width of target
#   a  = base movement time (intercept, in ms)
#   b  = information processing rate (slope, in ms/bit)

# Visualize the data:
library(dplyr)
library(ggplot2)
library(see)
library(brms)

fitts |> ggplot(aes(x = ID, y = movement_time)) +
  geom_point(alpha = 0.1) +
  geom_smooth(method = "lm") +
  xlab("Index of Difficulty (bits)") +
  ylab("Movement Time (ms)") +
  theme_modern()

# ===== HIERARCHICAL FITTS' LAW MODEL WITH brms =====
# We fit a hierarchical (mixed-effects) model:
#   movement_time ~ ID + (1 + ID | participant)
#
# This estimates:
#   - Population-level intercept (a) and slope (b)
#   - Per-participant deviations from the population parameters
#   - Correlation between random intercepts and slopes
#
# Why hierarchical?
#   - Partial pooling: borrows strength across participants
#   - Better estimates for participants with few trials
#   - Estimates both population-level and individual-level Fitts' law parameters

fit_fitts <- brm(movement_time ~ ID + (1 + ID | participant),
                 data = fitts, seed = 42, silent = 2, refresh = 0)
summary(fit_fitts)

# View participant-level deviations:
ranef(fit_fitts)

# ===== INTERPRETING FITTS' LAW PARAMETERS =====
# Population-level Intercept: the estimated base movement time 'a'
# Population-level ID slope: the estimated information processing rate 'b'
#   - A typical 'b' value around 100-200 ms/bit is common for pointing tasks
# Group-level SD for Intercept: how much participants vary in base MT
# Group-level SD for ID: how much participants vary in processing rate


# ===== PART 2: DRIFT DIFFUSION MODEL (DDM) =====
# The DDM is a cognitive model of speeded two-choice decisions.
# It models both RT and accuracy as arising from a single process:
#   - Evidence accumulates noisily over time
#   - A decision is made when evidence reaches one of two boundaries
#
# Key parameters:
#   v   (drift rate)        -- rate of evidence accumulation
#                              higher = faster, more accurate decisions
#   a   (boundary separation) -- response caution
#                              higher = slower but more accurate (speed-accuracy trade-off)
#   ndt (non-decision time)  -- time for sensory encoding + motor execution
#   beta (bias)              -- starting point bias toward one boundary

# Visualize DDM data:
ddm_data |> group_by(stimulus_type) |>
  summarise(mean_rt = mean(rt), accuracy = mean(response))

# ===== FITTING A DDM WITH brms =====
# brms can fit DDMs using family = wiener()
# The Wiener distribution is the first-passage time distribution
# for a diffusion process hitting a boundary.
#
# Formula structure:
#   rt | dec(response) ~ stimulus_type   -- drift rate varies by condition
#   bs ~ 1                               -- boundary separation (intercept only)
#   ndt ~ 1                              -- non-decision time (intercept only)
#   bias ~ 1                             -- starting point bias (intercept only)
#
# dec(response) tells brms which boundary was hit (correct vs error)

fit_ddm <- brm(
  bf(rt | dec(response) ~ stimulus_type,
     bs ~ 1,
     ndt ~ 1,
     bias ~ 1),
  data = ddm_data,
  family = wiener(),
  seed = 42,
  init = 0.5,
  silent = 2,
  refresh = 0
)
summary(fit_ddm)

# ===== INTERPRETING DDM PARAMETERS =====
# Drift rate (v):
#   - Intercept: drift rate for the reference stimulus type
#   - stimulus_type coefficient: difference in drift rate between conditions
#   - Higher drift = faster evidence accumulation = faster + more accurate
#
# Boundary separation (bs, on log scale):
#   - Reflects response caution
#   - Higher = more cautious (slower but more accurate)
#
# Non-decision time (ndt, on log scale):
#   - Time spent on non-decision processes (encoding, motor response)
#   - Typically 200-400 ms
#
# Bias (on logit scale):
#   - 0.5 = no bias (equal preference for both responses)
#   - > 0.5 = bias toward upper boundary
#   - < 0.5 = bias toward lower boundary

# ===== WHY USE THE DDM? =====
# Unlike standard RT regression, the DDM:
#   1. Jointly models RT and accuracy from a single process
#   2. Separates cognitive components (drift, caution, encoding)
#   3. Explains the speed-accuracy trade-off mechanistically
#   4. Provides process-level interpretation of experimental effects
#
# In HCI, this lets us ask:
#   - Does an interface change improve processing (drift rate)?
#   - Does it change response caution (boundary separation)?
#   - Does it affect motor execution time (non-decision time)?

# Don't delete me!
saved <- "Y"
