library(tidyverse)

#setwd("C:/Users/Matt/Documents/datasciencecoursera/R_Programming_Week1")
data <- read.csv("hw1_data.csv")
head(data,2)
tail(data,2)
data[47,]

data %>% filter(is.na(Ozone)) %>% nrow

data %>% summarise(mean(Ozone, na.rm = TRUE))

data %>% filter(Ozone > 31 & Temp > 90) %>% 
  summarise(avg = mean(Solar.R))

data %>% filter(Month == 6) %>% 
  summarise(avg = mean(Temp))

data %>% group_by(Month) %>% 
  summarise(Max = max(Ozone, na.rm = TRUE))
