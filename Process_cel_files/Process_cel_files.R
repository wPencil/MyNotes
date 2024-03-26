# 0. Packages-------------------------------------------------------------------
library(affy)
library(oligo)
library(R.utils)
library(data.table)
library(dplyr)
library(MyPackage) # My personal package


# 1. Unpack the cel file and place it in the folder "GSE56560_RAW"--------------
untar(tarfile = "GSE41804_RAW.tar", exdir = "GSE41804_RAW")

file_list <- list.files(path = "GSE41804_RAW", pattern = ".gz") # List all cel filenames

for (file in file_list){
  gunzip(paste0("GSE41804_RAW/", file), remove = TRUE)
}

# 2.1 oligo---------------------------------------------------------------------
cel_files <- list.celfiles("GSE41804_RAW", full.names=TRUE)

raw_data <- read.celfiles(cel_files)
pp_data <- rma(raw_data) # Expression Set
probe_exp <- exprs(pp_data) # expression matrix

# 3. annotate the probe---------------------------------------------------------
gpl <- fread("GPL570-55999.txt", header = T, skip = 16)

# Two columns: probe ID and Entrez ID
probe_gene <- select(gpl, "ID", "ENTREZ_GENE_ID") 

# The input format of the funcation "annotate_probe"
probe_exp <- cbind(rownames(probe_exp), probe_exp) %>% as.data.frame()

exp <- annotate_probe(exp = probe_exp, anno = probe_gene)

# Supplement: affy--------------------------------------------------------------
affy_data <- ReadAffy()

eset1 <- rma(affy_data)
eset2 <- justRMA()



