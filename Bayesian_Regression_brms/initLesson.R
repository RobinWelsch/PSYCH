# Bayesian Regression with brms
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(brms)

set.seed(2024)
n <- 150
age <- round(runif(n, 18, 65))
hours <- round(pmax(0.5, rnorm(n, mean = 4, sd = 2)), 1)
wellbeing <- round(pmin(100, pmax(0, 75 - 3 * hours + 0.1 * age + rnorm(n, 0, 10))), 1)

screentime <- data.frame(
  participant = 1:n,
  hours = hours,
  age = age,
  wellbeing = wellbeing
)
