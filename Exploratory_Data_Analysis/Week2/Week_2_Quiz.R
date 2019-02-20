library(nlme)
library(lattice)
library(datasets)
library(ggplot2)
xyplot(weight ~ Time | Diet, BodyWeight)

data(airquality)
qplot(Wind, Ozone, data=airquality, facets = .~factor(Month))

library(ggplot2movies)

g <- ggplot(movies, aes(votes, rating))

qplot(votes, rating, data = movies) + geom_smooth()
