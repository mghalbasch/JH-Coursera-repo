## This script creates a basic prediction model for the next word in a sentence
## based on the n-grams created from our corpus.

library(tidyverse)

# predict_next_word is the workhorse function here, reading in the data frames
# of n-grams and a sentence, and returning a list of words with predictions for
# the probability of each one.

predict_next_word <- function(sentence, words, pairs, triplets){
  # Modify these data frames to include the percent of instances for each n-gram
  total_words <- sum(words$n)
  total_pairs <- sum(pairs$n)
  total_triplets <- sum(triplets$n)

  words <- words %>% mutate(c = n/total_words)
  pairs <- pairs %>% mutate(c = n/total_pairs)
  triplets <- triplets %>% mutate(c = n/total_triplets)
  
  # Break the sentence into words
  tokens <- unlist(strsplit(tolower(sentence), "[^a-z]+"))
  
  # Extract the final word and final pair
  l <- length(tokens)
  last_word <- tokens[l]
  last_pair <- paste(tokens[l-1], tokens[l])
  
  # Calculate simple tri-gram model prediction
  triplets %>% filter(grepl(paste0("^", last_pair, " "), ngram))
}


# Read in the n-grams
path <- "./data/processed/"
ones <- paste0(path, "1_grams/1_grams.csv")
twos <- paste0(path, "2_grams/2_grams.csv")
threes <- paste0(path, "3_grams/3_grams_small.csv")

words <- read_csv(ones) %>% select(-X1)
pairs <- read_csv(twos) %>% select(-X1)
triplets <- read_csv(threes) %>% select(-X1)