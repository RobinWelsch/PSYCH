# Bayesian A/B Testing
swirl_options(swirl_logging = FALSE)
library(dplyr)

set.seed(2024)
n_per_group <- 100
design_a <- rbinom(n_per_group, 1, 0.60)
design_b <- rbinom(n_per_group, 1, 0.75)

chatbot <- data.frame(
  user_id = 1:200,
  design = rep(c("A", "B"), each = n_per_group),
  completed = c(design_a, design_b)
)
