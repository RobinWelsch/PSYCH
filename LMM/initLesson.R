library(lme4)
set.seed(2021)

PID <- factor(rep(1:30, each = 60))
stim <- factor(rep(1:60, times = 30))
modality <- factor(rep(c("Audio-only", "Audiovisual"), length.out = 1800))

u_pid_int <- rnorm(30, 0, 120)
u_stim_int <- rnorm(60, 0, 40)
u_pid_slope <- rnorm(30, 0, 60)
u_stim_slope <- rnorm(60, 0, 25)

X <- ifelse(modality == "Audiovisual", 1, 0)

RT <- 1050 +
  80 * X +
  u_pid_int[PID] +
  u_stim_int[stim] +
  u_pid_slope[PID] * X +
  u_stim_slope[stim] * X +
  rnorm(1800, 0, 180)

rt_data <- data.frame(PID, stim, modality, RT)

SNR <- factor(rep(c("easy", "hard"), length.out = nrow(rt_data)))
rt_data_int <- transform(rt_data, SNR = SNR)

linpred <- -0.2 + 0.6 * X + rnorm(nrow(rt_data), 0, 0.4)
p <- plogis(linpred)
accuracy <- rbinom(nrow(rt_data), 1, p)
acc_data <- transform(rt_data, accuracy = accuracy)