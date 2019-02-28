# Question 1 asks to fit a logistic regression on the 'shuttle' data in
# the MASS library. We want to fit use ~ wind.
library(MASS)
data(shuttle)
fit1 <- glm(I(use == "auto") ~ factor(wind), family = binomial, data=shuttle)
1/exp(fit1$coefficients[2])

# Question 2 considers the same data, but now we want to control for wind
# strength (variable magn)
fit2 <- glm(I(use == "auto") ~ factor(wind) + factor(magn)
            , family=binomial, data=shuttle)
1/exp(fit2$coefficients[2])

# question 3 compares the auto case to 1 - auto case:
fit3 <- glm(I(use != "auto") ~ factor(wind) + factor(magn),
            family = binomial, data = shuttle)
fit2$coefficients
fit3$coefficients

# Question 4 looks at the InsectSprays data set. We want to fit a
# Poisson model to this with spray as a factor level.
data(InsectSprays)
fit4 <- glm(count ~ factor(spray), family = poisson, data = InsectSprays)
1/exp(fit4$coefficients[2])


# Question 6 considers the following data:
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

# add a knot point at 0:
knot_term = (x > 0)*x

# fit the model
fit6 <- lm(y ~ x + knot_term)
fit6$coefficients[2] + fit6$coefficients[3]
