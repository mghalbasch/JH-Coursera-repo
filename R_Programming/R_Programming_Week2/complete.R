read_files <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## This function reads in the data corresponding to the monitor
  ## ID numbers provided from csv files in 'directory'.
  ## It returns a large dataframe that includes all the data for
  ## these ID numbers, on all dates.
  
  for(i in id){
    number <- str_pad(i, width = 3, pad = "0")
    filename <- paste(directory,
                      "\\",
                      number, ".csv", collapse="", sep="")
    id_data <- read.csv(filename)
    if(i==id[1]){
      data = id_data
    }else{
      data <- rbind(data, id_data)
    }
  }
  return(data)
}

complete <- function(directory, id=1:332, monitor_data = NULL) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## 'monitor_data' is an optional argument proivding data if
  ## we have it, so we don't have to read it in twice.
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the number of
  ## complete cases
  require(dplyr)
  
  # First we read the data if we were not provided with it
  if(is.null(monitor_data)){monitor_data <- read_files(directory, id)}
  
  # Next we check for complete cases (where both nitrate and sulfate
  # are provided) and count the number of observations.
  monitor_data %>% filter(is.na(nitrate) == FALSE &
                        is.na(sulfate) == FALSE) %>%
    group_by(ID) %>% summarize(nobs = n()) %>% as.data.frame()
}