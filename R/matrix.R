# 1. Create a matrix------------------------------------------------------------

# elements of the matrix
cells <- c("1", "2", "3",
           "4", "5", "6",
           "7", "8", "9")

names_r <- c("R1", "R2", "R3") # row name
names_c <- c("C1", "C2", "C3") # column name

# Create a 3x3 matrix
my_matrix <- matrix(data = cells,
                    nrow = 3, ncol = 3,
                    byrow = TRUE, # matrix is filled by row.Fill by column by default (byrow=FALSE)
                    dimnames = list(names_r, names_c))

class(my_matrix)

# 2. Convert the matrix to numeric type-----------------------------------------
my_matrix <- as.numeric(my_matrix)

class(my_matrix)
