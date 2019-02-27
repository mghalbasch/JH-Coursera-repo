# Question 2 - fit a linear model through the origin.

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

lm(y ~ 0 + x)

# question 3- fit a linear model in cars dataset.
data(mtcars)
lm(mtcars$mpg ~ mtcars$wt)

# Question 6 has us normalize a vector
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
mu <- mean(x)
sigma2 <- var(x)
y <- (x - mu)/sqrt(sigma2)

# Question 7 is a simple linear model
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x)


# question 9 looks at this data:
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)
