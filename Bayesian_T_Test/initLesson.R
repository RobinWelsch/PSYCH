# Bayesian T-Test
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(see)
library(BayesFactor)

set.seed(2024)
darkmode <- data.frame(
  participant = 1:120,
  condition = factor(rep(c("dark", "light"), each = 60)),
  time = round(c(rnorm(60, mean = 3.6, sd = 1.0), rnorm(60, mean = 4.2, sd = 1.1)), 2)
)
