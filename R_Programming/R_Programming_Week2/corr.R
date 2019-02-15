corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all variables)
  ## required to compute the correlation between nitrate and sulfate;
  ## the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  require(dplyr)
  
  air_data <- read_files(directory)
  nobs_df <- complete(directory)
  nobs_df %>% filter(nobs > threshold) %>% select(ID) -> good_ids
  
  air_data %>% filter(ID %in% good_ids$ID) %>%
    group_by(ID) %>%
    summarise(correlations = cor(sulfate, 
                                 nitrate, use = "complete.obs")) %>%
    as.data.frame() -> cors
  return(as.numeric(cors$correlations))
}