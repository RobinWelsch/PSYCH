# Bayesian Link Functions
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(see)
library(brms)

set.seed(2024)
n <- 180
condition <- factor(rep(c("gamified", "standard"), each = 90))
retained <- rbinom(n, 1, prob = ifelse(condition == "gamified", 0.78, 0.55))
daily_opens <- rpois(n, lambda = ifelse(condition == "gamified", 6, 3.5))

satisfaction <- integer(n)
for (i in 1:n) {
  if (condition[i] == "gamified") {
    satisfaction[i] <- sample(1:5, 1, prob = c(0.05, 0.10, 0.20, 0.35, 0.30))
  } else {
    satisfaction[i] <- sample(1:5, 1, prob = c(0.15, 0.25, 0.30, 0.20, 0.10))
  }
}

engagement <- data.frame(
  participant = 1:n,
  condition = condition,
  retained = retained,
  daily_opens = daily_opens,
  satisfaction = satisfaction
)
