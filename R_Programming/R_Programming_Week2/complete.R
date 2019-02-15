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

complete <- function(directory, id=1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the number of
  ## complete cases
  require(dplyr)
  
  air_data <- read_files(directory, id)
  air_data %>% filter(is.na(nitrate) == FALSE &
                        is.na(sulfate) == FALSE) %>%
    group_by(ID) %>% summarize(nobs = n()) %>% as.data.frame()
}