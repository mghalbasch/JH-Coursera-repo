# Q1 asks us to fit a model in the mtcars dataset,  with 
# mpg ~ cylinders + weight.
# We want the adjusted estimate for going from 8 cylinders to 4.
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, data=mtcars)
fit$coefficients

# Q2 wants us to compare this model to a model without the weight included
# as a confounding variable:
fit2 <- lm(mpg ~ factor(cyl), data=mtcars)
fit2$coefficients

# Q3 has us compare the first model to one with an interaction term 
# between weight and cylinders.
fit3 <- lm(mpg ~ factor(cyl) + wt + wt*factor(cyl), data=mtcars)

# Now we have to see if this model is predictive relative to our first
# model: in other words, we want to see if this interaction term is
# necessary. We can do this with anova.
anova(fit)
anova(fit3)


# Q5 considers the following dataset:
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# We want the hat diagonal for the most influential data point.
fit5 <- lm(y ~ x)
hatvalues(fit5)

# Q6 considers the same dataset, but we want the slope dfbeta for the
# point with the highest hat value.
dfbetas(fit5)
