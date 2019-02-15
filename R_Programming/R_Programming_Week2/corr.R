corr <- function(directory, threshold = 0, monitor_data = NULL) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all variables)
  ## required to compute the correlation between nitrate and sulfate;
  ## the default is 0
  
  ## 'monitor_data' is an optional argument that provides data, so that
  ## we don't have to read the data in twice
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  require(dplyr)
  
  # First get the data if we weren't provided with it
  if(is.null(monitor_data)){monitor_data <- read_files(directory)}
  nobs_df <- complete(monitor_data = monitor_data)
  nobs_df %>% filter(nobs > threshold) %>% select(ID) -> good_ids
  
  monitor_data %>% filter(ID %in% good_ids$ID) %>%
    group_by(ID) %>%
    summarise(correlations = cor(sulfate, 
                                 nitrate, use = "complete.obs")) %>%
    as.data.frame() -> cors
  return(as.numeric(cors$correlations))
}