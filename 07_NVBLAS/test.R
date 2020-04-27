# This is an adaptation of
# https://gist.github.com/andrie/24c9672f1ea39af89c66#file-rro-mkl-benchmark-r
# I added output to label the outcomes for easier reading


# Initialization

set.seed (1)
m <- 10000
n <-  5000
A <- matrix (runif (m*n),m,n)

# Matrix multiply
print("Matrix multiply:")
system.time (B <- crossprod(A))
print("----")
# Cholesky Factorization
print("Cholesky Factorization:")
system.time (C <- chol(B))
print("----")

# Singular Value Deomposition
m <- 10000
n <- 2000
A <- matrix (runif (m*n),m,n)
print("Singular Value Decomposition:")
system.time (S <- svd (A,nu=0,nv=0))
print("----")

# Principal Components Analysis
m <- 5000
n <- 1000
A <- matrix (runif (m*n),m,n)
print("Principal Components Analysis:")
system.time (P <- prcomp(A))
print("----")

# Linear Discriminant Analysis
library('MASS')
g <- 5
k <- round (m/2)
A <- data.frame (A, fac=sample (LETTERS[1:g],m,replace=TRUE))
train <- sample(1:m, k)
print("Linear Discriminant Analysis:")
system.time (L <- lda(fac ~., data=A, prior=rep(1,g)/g, subset=train))
print("----")
