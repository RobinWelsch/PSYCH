# Understanding the Posterior
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(see)

set.seed(2024)
presence <- data.frame(
  participant = 1:80,
  rating = round(pmin(100, pmax(0, rnorm(80, mean = 65, sd = 15))), 1)
)
