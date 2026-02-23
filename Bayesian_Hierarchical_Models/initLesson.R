# Bayesian Hierarchical Models
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(see)
library(brms)

set.seed(2024)
n_websites <- 10
n_per_site <- 20
n_tasks <- 5

website_intercepts <- rnorm(n_websites, mean = 0, sd = 5)
website_slopes <- rnorm(n_websites, mean = 0, sd = 1)

usability <- do.call(rbind, lapply(1:n_websites, function(w) {
  do.call(rbind, lapply(1:n_per_site, function(p) {
    pid <- (w - 1) * n_per_site + p
    data.frame(
      participant = pid,
      website = paste0("site_", LETTERS[w]),
      task_difficulty = 1:n_tasks,
      time = round(pmax(5, 30 + website_intercepts[w] + (5 + website_slopes[w]) * (1:n_tasks) + rnorm(n_tasks, 0, 4)), 1)
    )
  }))
}))
usability$website <- factor(usability$website)
