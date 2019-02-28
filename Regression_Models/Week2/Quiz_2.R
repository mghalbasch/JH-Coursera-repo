# Question 1: p value for whether slope = 0 or not.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

fit <- lm(y ~ x)
summary(fit)

# Question 2: estimate the residual standard deviation.
summary(fit)

# Question 3: mtcars dataset, fit mpg ~ weight, 95% confidence interval
# for the expected mpg at average weight.
data(mtcars)
fit3 <- lm(mpg ~ wt, data=mtcars)
new_x <- data.frame(wt = mean(mtcars$wt))
predict(fit3, newdata = new_x, interval = ("confidence"))


# Question 5 wants the same regression, but to predict a 3000 lb car
newx_5 <- data.frame(wt = 3)
predict(fit3, newdata = newx_5, interval = ("prediction"))

# Question 6 is asking for the same regression but with weight as 2000
# lbs instead of 1000
fit6 <- lm(mpg ~ I(0.5*wt), data=mtcars)
summary(fit6)

# Question 9 returns to our mpg ~ weight fit, but now wants to compare
# the linear fit with intercept and slope to just an intercept:

fit9 <- lm(mpg ~ 1, data=mtcars)

# Take the residual standard error from these two fits, divide them,
# and square the result.
