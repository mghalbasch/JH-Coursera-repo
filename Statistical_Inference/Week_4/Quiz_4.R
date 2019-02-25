# Question 1 - two sided t test p-value:
baseline <- c(140,138,150,148,135)
week_2 <- c(132,135,151,146,130)
t.test(baseline,week_2, paired=TRUE)