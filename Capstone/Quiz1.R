library(tidyverse)

twitter_file <- file("./data/en_US/en_US.twitter.txt")
news_file <- file("./data/en_US/en_US.news.txt")
blogs_file <- file("./data/en_US/en_US.blogs.txt")

twitter_data <- readLines(twitter_file)
news_data <- readLines(news_file)
blogs_data <- readLines(blogs_file)

twitter_char_nums <- nchar(twitter_data)
news_char_nums <- nchar(news_data)
blogs_char_nums <- nchar(blogs_data)

twitter_love <- twitter_data[grepl("love", twitter_data)]
twitter_hate <- twitter_data[grepl("hate", twitter_data)]

Q4 <- length(twitter_love)/length(twitter_hate)

Q5 <- twitter_data[grepl("biostats", twitter_data)]

Q6 <- twitter_data[grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twitter_data)]
