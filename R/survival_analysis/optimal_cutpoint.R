# 0. Load packages--------------------------------------------------------------
library(survival)
library(survminer)

# 1. Example data: myeloma------------------------------------------------------
View(myeloma)

# 2. Determine the optimal cutpoint of variables("DEPDC1") and categorize-------
res.cat <- surv_cutpoint(myeloma, time = "time", event = "event", variables = "DEPDC1") %>%
           surv_categorize(labels = c("Low", "High"))
res.cat$DEPDC1 <- factor(res.cat$DEPDC1, ordered = TRUE, levels = c("Low", "High"))

# 3. Fit survival curves and visualize------------------------------------------
fit <- survfit(Surv(time, event) ~ DEPDC1, data = res.cat)

png("optimal_cutpoing.png", width = 2500, height = 3000, res = 500)
ggsurvplot(fit, data = res.cat, pval = TRUE,risk.table = TRUE)
dev.off()

# Supplement: official guide---------------------------------------------------- 

# 0. Load some data
data(myeloma)
head(myeloma)

# 1. Determine the optimal cutpoint of variables
res.cut <- surv_cutpoint(myeloma, time = "time", event = "event",
                         variables = c("DEPDC1", "WHSC1", "CRIM1"))

summary(res.cut)

# 2. Plot cutpoint for DEPDC1
# palette = "npg" (nature publishing group), see ?ggpubr::ggpar
plot(res.cut, "DEPDC1", palette = "npg")

# 3. Categorize variables
res.cat <- surv_categorize(res.cut)
head(res.cat)

# 4. Fit survival curves and visualize
library("survival")
fit <- survfit(Surv(time, event) ~DEPDC1, data = res.cat)
ggsurvplot(fit, data = res.cat, risk.table = TRUE, conf.int = TRUE)