## This script is intended to take the data frames of n-grams from different
## sources and combine them into a single data frame for each n.

library(tidyverse)
library(tidytext)

# Set the values of n to consider
ns <- c(1,2,3)

path <- "./data/processed/"
for(n in ns){
  # Check that the folder for the raw n-gram files exists, skip if not
  folder <- paste0(path, as.character(n), "_grams")
  if(!dir.exists(folder)){next}
  
  # Next check if we already created the combined n-gram file
  out_path <- paste0(folder, "/", as.character(n), "_grams.csv")
  if(file.exists(out_path)){next}
  
  # Now we read in the files in the folder
  files <- list.files(folder)
  for(f in files){
    filename <- paste(folder, f, sep = "/")
    if(f == files[[1]]){
      ngrams <- read_csv(filename) %>% select(-X1)
    } else{
      extra <- read_csv(filename) %>% select(-X1)
      temp <- merge(ngrams, extra, all = TRUE, by = "ngram")
      
      # Remove the old dataframes
      remove(ngrams)
      remove(extra)
      
      # Combine the two n values and save the result
      temp$n <- rowSums(temp[,2:3], na.rm = TRUE)
      temp %>% select(ngram, n) %>% arrange(desc(n)) %>% as_tibble() ->
        ngrams
      
      # Finally remove the temp file and run the garbage collector
      remove(temp)
      gc()
    }
  }
  
  # Next we save the new n-gram dataframe to a new .csv file
  out_file <- file(out_path, open = "w")
  write.csv(ngrams, out_file)
  close(out_file)
  
  # As a last step, delete the ngram dataframe and run the garbage collector
  remove(ngrams)
  gc()
}

