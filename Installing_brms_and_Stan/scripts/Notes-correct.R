# Notes for Installing brms and Stan Module

# ===== WHAT IS STAN? =====
# Stan is a state-of-the-art platform for statistical modeling and
# Bayesian inference. When you call brm() in R, brms translates your
# model formula into Stan code, which is then compiled to C++ for
# fast Hamiltonian Monte Carlo (HMC) sampling.

# The toolchain has three parts:
#   1. A C++ compiler (platform-specific)
#   2. The rstan package (R interface to Stan)
#   3. The brms package (user-friendly formula syntax)

# ===== PLATFORM-SPECIFIC C++ TOOLCHAIN =====

# --- Windows ---
# Install Rtools from: https://cran.r-project.org/bin/windows/Rtools/
# Make sure the version matches your R version (e.g., Rtools44 for R 4.4.x).
# After installing, restart R.

# --- Mac ---
# Install Xcode Command Line Tools by running in Terminal:
#   xcode-select --install
# If you have an Apple Silicon Mac (M1/M2/M3), this should work out of the box.

# --- Linux ---
# Install g++ and make. On Ubuntu/Debian:
#   sudo apt-get install g++ make
# On Fedora/RHEL:
#   sudo dnf install gcc-c++ make

# ===== INSTALLING RSTAN AND BRMS =====
# Run these commands in your R console (not inside swirl):
install.packages("rstan")
install.packages("brms")

# ===== VERIFYING THE INSTALLATION =====
# Load the packages:
library(rstan)
library(brms)

# ===== TEST MODEL =====
# Run a simple regression using the built-in mtcars dataset.
# We predict miles per gallon (mpg) from car weight (wt).
# silent = 2 suppresses Stan messages; refresh = 0 hides sampling progress.
test_fit <- brm(mpg ~ wt, data = mtcars, seed = 42, silent = 2, refresh = 0)

# View the results:
summary(test_fit)

# ===== READING THE OUTPUT =====
# Population-Level Effects:
#   Intercept -- the predicted mpg when wt = 0
#   wt        -- the change in mpg for each unit increase in weight
#
# Key columns:
#   Estimate  -- posterior mean of the parameter
#   Est.Error -- posterior standard deviation
#   l-95% CI  -- lower bound of the 95% credible interval
#   u-95% CI  -- upper bound of the 95% credible interval
#   Rhat      -- convergence diagnostic (should be close to 1.00)
#   Bulk_ESS  -- effective sample size for bulk of the posterior
#   Tail_ESS  -- effective sample size for tails of the posterior

# ===== TROUBLESHOOTING =====
# If rstan fails to load:
#   - Make sure your C++ toolchain is installed correctly
#   - Try: example(stan_model, package = "rstan", run.dontrun = TRUE)
#   - See: https://mc-stan.org/rstan/
#
# If brm() gives compilation errors:
#   - Restart R and try again
#   - On Windows, make sure Rtools is on your PATH
#   - On Mac, run: xcode-select --install
#
# For more help:
#   - Stan forums: https://discourse.mc-stan.org/
#   - brms documentation: https://paul-buerkner.github.io/brms/
#   - rstan getting started: https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

# Don't delete me!
saved <- "Y"
