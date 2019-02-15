library(datasets)
library(dplyr)

data(iris)

iris %>% filter(Species == "virginica") %>% 
  summarise(mean(Sepal.Length))%>% round(0)

apply(iris[,1:4], 2, mean)

data(mtcars)

sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg, mtcars$cyl, mean)

q4 <- tapply(mtcars$hp, mtcars$cyl, mean)
round(q4["8"] - q4["4"],0)

debug(ls)
