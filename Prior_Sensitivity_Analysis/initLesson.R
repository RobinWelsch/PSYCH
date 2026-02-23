# Prior Sensitivity Analysis
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(BayesFactor)

set.seed(2024)
typing <- data.frame(
  participant = 1:90,
  method = factor(rep(c("swipe", "tap"), c(45, 45))),
  wpm = round(c(rnorm(45, mean = 38, sd = 8), rnorm(45, mean = 32, sd = 7)), 1)
)
