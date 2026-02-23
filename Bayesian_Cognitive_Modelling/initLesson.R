# Bayesian Cognitive Modelling
swirl_options(swirl_logging = FALSE)
library(dplyr)
library(ggplot2)
library(see)
library(brms)

# Fitts' Law dataset
set.seed(2024)
n_participants <- 30
widths <- c(10, 20, 40, 80)
distances <- c(100, 200, 400)
conditions <- expand.grid(W = widths, D = distances)
conditions$ID <- log2(2 * conditions$D / conditions$W)
n_reps <- 10

fitts_list <- list()
for (p in 1:n_participants) {
  a_p <- rnorm(1, mean = 200, sd = 30)
  b_p <- rnorm(1, mean = 150, sd = 20)
  for (i in 1:nrow(conditions)) {
    mt <- pmax(100, a_p + b_p * conditions$ID[i] + rnorm(n_reps, 0, 40))
    fitts_list[[length(fitts_list) + 1]] <- data.frame(
      participant = factor(p),
      W = conditions$W[i],
      D = conditions$D[i],
      ID = round(conditions$ID[i], 2),
      movement_time = round(mt, 1)
    )
  }
}
fitts <- do.call(rbind, fitts_list)

# DDM dataset
set.seed(2025)
n_ddm <- 40
ddm_list <- list()
for (p in 1:n_ddm) {
  drift_word <- rnorm(1, 2.0, 0.3)
  drift_nonword <- rnorm(1, 1.5, 0.3)
  boundary <- rnorm(1, 1.5, 0.2)
  ndt <- rnorm(1, 0.3, 0.05)

  for (stim in c("word", "nonword")) {
    n_trials <- 50
    drift <- if (stim == "word") drift_word else drift_nonword
    for (t in 1:n_trials) {
      rt_raw <- ndt + rgamma(1, shape = (boundary / abs(drift))^2, rate = boundary / drift^2)
      rt <- round(pmax(0.2, pmin(3.0, rt_raw)), 3)
      acc <- rbinom(1, 1, prob = 1 / (1 + exp(-boundary * drift)))
      ddm_list[[length(ddm_list) + 1]] <- data.frame(
        participant = factor(p),
        stimulus_type = stim,
        rt = rt,
        response = acc
      )
    }
  }
}
ddm_data <- do.call(rbind, ddm_list)
ddm_data$stimulus_type <- factor(ddm_data$stimulus_type)
