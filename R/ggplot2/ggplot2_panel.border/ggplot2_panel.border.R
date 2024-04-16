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
  theme(panel.border = element_rect(fill=NA,
                                    color="black", 
                                    size=2, 
                                    linetype="solid")
        )
ggsave("bold_border.png", width = 4, height = 4)
