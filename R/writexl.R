library(writexl)

# 1. Export unique variable to xlsx---------------------------------------------
# test data: vari1.
vari <- data.frame(C1 = c(1, 2, 3),
                   C2 = c(4, 5, 6),
                   C3 = c(7, 8, 9),
                   row.names = c("R1", "R2", "R3"))

write_xlsx(list(sheet_name = vari), path = 'unique_vari.xlsx')

# 2. Export multiple variable to xlsx-------------------------------------------
# test data: vari1 and vari2.
vari1 <- data.frame(C1 = c(1, 2, 3),
                    C2 = c(4, 5, 6),
                    C3 = c(7, 8, 9),
                    row.names = c("R1", "R2", "R3"))
vari2 <- data.frame(C1 = c(11, 12, 13),
                    C2 = c(14, 15, 16),
                    C3 = c(17, 18, 19),
                    row.names = c("R1", "R2", "R3"))

write_xlsx(list(sheet1_name = vari1, sheet2_name = vari2), path = 'multi_vari.xlsx')

# Supplement: import xlsx-------------------------------------------------------
library(readxl)

tmp <- read_xlsx("unique_vari.xlsx")

tmp1 <- read_xlsx("multi_vari.xlsx", sheet = 1)
tmp2 <- read_xlsx("multi_vari.xlsx", sheet = 2)
