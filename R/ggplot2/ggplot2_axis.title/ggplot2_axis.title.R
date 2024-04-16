# 0. Load packages--------------------------------------------------------------
library(ggplot2)

# 1. Test data------------------------------------------------------------------
data <- data.frame(
  x = c(1, 2, 3, 4, 5),  
  y = c(1, 3, 5, 2, 4)
)

# 2. Default plot---------------------------------------------------------------
ggplot(data, aes(x = x, y = y)) +
  geom_point()
ggsave("default_plot.png", width = 4, height = 4)

# 3. My plot--------------------------------------------------------------------
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  theme(axis.title.x = element_text(margin = margin(t = 1, r = 0, b = 0, l = 0, unit = "cm")))+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 1, b = 0, l = 0, unit = "cm")))
ggsave("axis_distance.png", width = 4, height = 4)
