# Q1 asks us to fit a model in the mtcars dataset,  with 
# mpg ~ cylinders + weight.
# We want the adjusted estimate for going from 8 cylinders to 4.
data(mtcars)
lm(mpg ~ factor(cyl) + wt, data=mtcars)
