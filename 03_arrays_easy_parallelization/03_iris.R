start_index <- commandArgs(trailingOnly = TRUE)

dim(iris)

if (start_index == '1') {
  print('Setosa averages:')
  apply(iris[iris$Species=='setosa',1:4], 2, mean)
}

if (start_index == '2') {
  print('Versicolor averages:')
  print(apply(iris[iris$Species=='versicolor',1:4], 2, mean))
}

if (start_index == '3') {
  print('Virginica averages:')
  print(apply(iris[iris$Species=='versicolor',1:4], 2, mean))
}
