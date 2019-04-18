## The purpose of this script is to take the corpus, break each source into
## n-grams, summarise these into a frequency table, and combine the results.
## This happens in several steps due to the size of the corpus, where each
## piece is processed individually and saved.

library(tidyverse)
library(tidytext)


# This function takes in raw corpus data (corp), breaks it into n-grams 
# and saves the result to a designated output file (out_file)
process_data <- function(corp, n, out_file){
  tibble(text = corp) %>% unnest_tokens(ngram, text, token = "ngrams",
                                        n = n, collapse = FALSE) %>%
    count(ngram, sort = TRUE) ->
    ngrams
  
  # open the output file for writing
  out <- file(out_file, open = "w")
  write.csv(ngrams, out)
  
  # Close the connection
  close(out)
  
  # Remove the ngrams for space
  remove(ngrams)
}

# Here we load in the raw corpus data
in_path = "./data/en_US/en_US"
out_path = "./data/processed/"

twitter_file <- file(paste0(in_path, ".twitter.txt"))
news_file <- file(paste0(in_path, ".news.txt"))
blogs_file <- file(paste0(in_path, ".blogs.txt"))

twitter_raw <- readLines(twitter_file)
news_raw <- readLines(news_file)
blogs_raw <- readLines(blogs_file)

# Store the files as a vector for easier coding
combined <- list(twitter_raw, news_raw, blogs_raw)

# Remove raw files for space
remove(twitter_raw)
remove(news_raw)
remove(blogs_raw)

# Close the connections
close(twitter_file)
close(news_file)
close(blogs_file)

# Garbage collect to return unused RAM
gc()

# Now we can process these documents into n-grams.
ns <- c(1, 2, 3, 4)
names(combined) <- c("twitter.csv", "news.csv", "blogs.csv")
for(n in ns){
  extension = paste0(as.character(n), "_grams")
  dir <- paste0(out_path, extension)
  
  # Check if the directory for these n-grams exists, skip if it does
  if(!dir.exists(dir)){
    dir.create(dir)
    
    # Now we loop through our files
    for(f in names(combined)){
      # We need to split up the corpus to make it easier on the RAM
      corp <- combined[[f]]
      
      # Split up the corpus to make it more manageable on the RAM
      chunks <- split(corp, sort(seq_along(corp)%%n))
      remove(corp)
      
      # Finally loop through the chunks and run our function
      for(i in 1:n){
        corp <- chunks[[i]]
        
        # Create the output filename
        out_file <- paste0(dir, "/part_", i, "_", f)
      
        # Finally process the chunk
        process_data(corp, n, out_file)
          
        # Remove the file and run garbage collector
        remove(corp)
        gc()
      }
      
      remove(chunks)
    }
  }
}

# Finally we remove the combined list
remove(combined)





