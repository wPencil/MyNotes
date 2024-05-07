# 0. Load packages--------------------------------------------------------------
library(survival)

# 1. Import data----------------------------------------------------------------

# Creating a sample dataset
set.seed(123)
n <- 100  # sample number
data <- data.frame(
  treatment = sample(c("A", "B", "C"), n, replace = TRUE),
  gender = sample(c("Male", "Female"), n, replace = TRUE),
  success = sample(c(0, 1), n, replace = TRUE),  # 0 stand for failure, 1 stand for success
  time = runif(n, 0, 10)  # survival time
)

# 2. Preprocess data------------------------------------------------------------

# Setting Group A as the reference group
data$treatment <- factor(data$treatment, order = TRUE,
                         levels = c("B", "C", "A"))

# model.matrix(), Converting categorical variables to dummy variables
treatment_dummy <- model.matrix(~ treatment - 1, data = data)

# Combining dummy variables and other predictor variables
cox_data <- cbind(data, treatment_dummy)

# 3. Experimental analysis------------------------------------------------------
cox_model <- coxph(Surv(time, success) ~ treatment_dummy, data = cox_data)
summary(cox_model)

