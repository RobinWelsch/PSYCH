# PsychMetHCI - Statistical Methods in Human-Technology Interaction

This course teaches statistical methods for students and researchers in Human-Technology Interaction, including Human-Computer Interaction (HCI), Human-AI Interaction (HAI), Human Factors, Cognitive Science, and Psychology. It is suitable for Bachelor's, Master's, and PhD students. The course uses R in an interactive SWIRL framework, progressing from foundational statistics through advanced Bayesian methods.

Students interact with many packages throughout this course, with the main ones being the tidyverse (dplyr, tidyr, purrr, ggplot2), rstatix, emmeans, BayesFactor, brms, bayestestR, and see (from easystats). The course takes open data and replicates results, using examples drawn from HCI, HAI, and human factors research contexts.

The course includes a comprehensive Bayesian statistics sequence covering Bayesian A/B testing, posterior distributions, Bayesian t-tests, prior sensitivity analysis, Bayesian regression with brms, hierarchical models, link functions, cognitive modelling, prior predictive checks, ROPE and equivalence testing, crossed random effects, distributional models, missing data, Bayesian power analysis, Bayesian workflow, and a Bayesian vs frequentist capstone. Students will need a working C++ toolchain (Rtools on Windows, Xcode CLI on Mac, g++ on Linux) for the brms modules.

## Installation

This course is recommended to be run in RStudio. Please download R - https://www.r-project.org/ and RStudio - https://www.rstudio.com/ first.

This course requires the installation of the swirl package. Once RStudio has loaded, type the following into the console:

    install.packages("swirl")

You can also directly install from GitHub with the following code:

    library(swirl)
    install_course_github("RobinWelsch", "PSYCH")
    swirl()

## For Teachers

If you are a teacher or professor looking to use this course in your classroom, please follow these instructions.

1. Fork this repository by clicking the top right button that says "Fork". This will create a copy of the course under your username.

2. Make any modifications you need to the lesson content or customTests.R files in your fork.

3. Once you have completed your changes, follow the steps at http://swirlstats.com/swirlify/sharing.html to create a new .swc file (you'll need the swirlify package). Push the changes + the new .swc to your fork of this repository.

4. Have students install with `install_course_github("yourgithubname", "PSYCH")`.

### Future Plans

- Consider making the hints actually hint-y. Currently, all hints just give the answer.

- Always looking for edits and other helpful tips - both for the course itself and the Notes.R!

- Look for collaborators! Are you interested in using this in your course? Can we A/B test to see if it helps?
