library(Seurat)
library(dplyr)
library(magrittr)
library(ggplot2)

pbmc <- readRDS("pbmc.rds")

markers <- FindAllMarkers(pbmc, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
markers <- markers %>% 
  group_by(cluster) %>% 
  top_n(n = 3, wt = avg_log2FC)
markers

tiff("DotPlot.tiff", width = 10000, height = 3000, res = 400, compression = "lzw")
DotPlot(pbmc, features = markers$gene)
dev.off()


genes_list_selected <- list("Naive CD4 T" = c("PRKCQ-AS1", "LEF1", "CCR7"),
                            "Memory CD4 T" = c("S100A12", "FOLR3", "S100A8"),
                            "CD8 T" = c("GZMH", "CD8A", "GZMK"),
                            "CD14+ Mono" = c("CD40LG", "AQP3", "CD2"),
                            "FCGR3A+ Mono" = c("MS4A4A", "CKB", "CDKN1C"),
                            "B" = c("VPREB3", "LINC00926", "CD79A"),
                            "NK" = c("SH2D1B", "AKR1C3", "GZMB"),
                            "DC" = c("CLIC2", "SERPINF1", "FCER1A"),
                            "Platelet" = c("RP11-879F14.2", "CLDN5", "LY6G6F")
                           )

dat <- DotPlot(pbmc, features = rev(genes_list_selected))$data
dat[1:5, 1:5]
dat$id <- factor(dat$id, 
                 levels = c("Naive CD4 T", 
                            "Memory CD4 T", "CD8 T",
                            "CD14+ Mono", "FCGR3A+ Mono",
                            "B", "NK", "DC", "Platelet")
                 )

tiff("DotPlot_genes_selected.tiff", width = 3000, height = 4000, res = 400, compression = "lzw")
ggplot(dat, aes(x = id, y = features.plot, size = pct.exp, color = avg.exp.scaled))+
  geom_point()+
  scale_color_gradientn(colours = c("#2167ac", "#ffffff", "#b1182b"))+
  xlab("") + ylab("") +
  cowplot::theme_cowplot()+
  scale_size("Percent Expressed", range = c(0, 10))+
  scale_x_discrete(position ="top")+
  theme_bw()+
  theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())+
  theme(
    axis.text.x = element_text(face = "bold"),   
    axis.text.y = element_text(face = "bold")
  )+
  theme(axis.text.x = element_text(angle = 45, hjust = 0))
dev.off()