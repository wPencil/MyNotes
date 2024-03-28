
# 0. packages-------------------------------------------------------------------
library(magrittr)
library(limma)
library(ggplot2)

# 1. Constructing the test dataset, and set the columns and row names-----------
set.seed(123)
expr <- matrix(abs(rnorm(20000)), nrow = 20000, ncol = 10,
               dimnames = list(paste("Gene", 1:20000, sep = ""), # row names
                               paste("Sample", 1:10, sep = ""))  # column names
               ) %>% as.data.frame()

# 2. 
label <- c(rep("Control",5), rep("Case",5))

group <- factor(label, levels = c("Control", "Case")) 
head(group)

design <- model.matrix(~group, data = expr)
colnames(design) <- levels(group)
rownames(design) <- colnames(expr)
head(design)

contrast.matrix<-makeContrasts("Case-Control",levels = design)
contrast.matrix

expr_voom <- voom(expr, design, plot = TRUE)

fit <- lmFit(expr_voom, design)
fit <- contrasts.fit(fit, contrast.matrix)
fit <- eBayes(fit) 

output = topTable(fit, coef=1, n=Inf) 

# ------------------------------------------------------------------------------
df <- data.frame(row.names = rownames(output),
                 logFC = output$logFC, # logFC
                 FDR = output$adj.P.Val) # FDR
# Grouping tags
df$Significant <- ifelse(df$logFC >= 1 & df$FDR < 0.05, "Up", 
                         ifelse(df$logFC <= (-1) & df$FDR < 0.05, "Down", "No"))

ggplot(df,aes(x = logFC, y = -log10(FDR)))+
  geom_point(aes(color = Significant))+
  scale_color_manual(values = c("blue","grey","red"))+
  labs(, x = "Log2(Fold Change)",y = "-log10(FDR)")+ 
  theme(plot.title = element_text(hjust = 0.5))+  
  geom_hline(yintercept = -log10(0.05), linetype = 2)+
  geom_vline(xintercept = c(-1,1), linetype = 2)+
  theme_classic()
