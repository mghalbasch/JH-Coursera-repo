# Question 1 - two sided t test p-value:
baseline <- c(140,138,150,148,135)
week_2 <- c(132,135,151,146,130)
t.test(baseline,week_2, paired=TRUE)

# Question 2 asks for the set of values where we would fail to reject the
# null hypothesis in a 2-sided t test with a 5% alpha level.

# Mean is 1100, sd is 30
conf = c(1,-1)*qt(0.975, df = 8)*30/3 + 1100
conf

# Question 4 is about the infection rate at a hospital, we want a 
# one-sided test to see if their infection rate is lower than 100
# days per infection.

days = 1787/10

# Time between counts is exponential. The standard deviation of the
# exponential is equal to the mean.
# We have 10 obs, so we divide by sqrt(10-1)=3 in our sd calculation.

sd = days/sqrt(9)

# Now we calculate the t test statistic
t = (days-100)/sd
1-pt(t, df=9)

# Question 5 returns to BMIs.
X_mean = -3
X_sd = 1.5
Y_mean = 1
Y_sd = 1.8

# Calculate the t statistic, using normality of underlying data and
# common population variance
sp = sqrt((X_sd^2 + Y_sd^2)/2)
t = (X_mean - Y_mean)/(sp * sqrt(2/9))

#Now we calculate the p value associated with this test statistic
2*pt(t, df=16)

# Q7 wants the power in a one-sided t test:
power.t.test(n=100,delta=.01,sd=.04,type="one.sample", 
             alternative="one.sided")

# Q8 wants n given power, sd, delta, 5% significance
power.t.test(delta = .01, sd=.04, power=0.9, type="one.sample",
             alternative="one.sided")

