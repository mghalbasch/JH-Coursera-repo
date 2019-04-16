## This script is intended to perform an exploratory analysis of the english
## data, including tokenizing documents into word counts or counts of pairs of
## words, and some analysis/cleaning of the resulting counts.


library(tidyverse)
library(tidytext)
library(reshape2)


# Read in the data
path = "./data/en_US/en_US"
twitter_file <- file(paste(path, "twitter.txt", sep="."))
news_file <- file(paste(path, "news.txt", sep="."))
blogs_file <- file(paste(path, "blogs.txt", sep="."))

twitter_raw <- readLines(twitter_file)
news_raw <- readLines(news_file)
blogs_raw <- readLines(blogs_file)

# Close the connections
close(twitter_file)
close(news_file)
close(blogs_file)

# Break the files into smaller chunks for easier management.
manageable <- split(twitter_raw, ceiling(seq_along(twitter_raw)/100000))

# Loop through these chunks, and extract the counts of words and 2-grams
for(i in 1:length(manageable)){
  corp <- manageable[[i]]
  {tibble(text = corp) %>% mutate(document = row_number()) ->
    cleaned_corp} %>%
    unnest_tokens(word, text) %>% count(word, sort=TRUE) %>% 
    filter(n > 10) ->
    word_counts
  
  cleaned_corp %>% unnest_tokens(pair, text, 
                                 token = "ngrams", n = 2, collapse = FALSE) %>%
    count(pair, sort = TRUE) %>% filter(n > 10) -> 
    pair_counts
  
  if(i == 1){
    words <- word_counts
    pairs <- pair_counts
  }
  else{
    merge(words, word_counts, by="word", all = TRUE) %>% 
      mutate(n = n.x + n.y) %>% 
      select(word, n) %>% arrange(desc(n)) ->
      words
    merge(pairs, pair_counts, by="pair", all = TRUE) %>%
      mutate(n = n.x + n.y) %>%
      select(pair, n) %>% arrange(desc(n)) ->
      pairs
  }
  
}

# Copy to a file
out_path <- "./data/condensed"
words_out <- paste(out_path, "twitter_words.csv", sep="/")
write.csv(words, words_out)
pairs_out <- paste(out_path, "twitter_pairs.csv", sep="/")
write.csv(pairs, pairs_out)

total_words <- 30218125
