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

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate"
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors listed
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  if(pollutant != "sulfate" & pollutant != "nitrate"){return(NA)}
  
  airdata <- read_files(directory, id)
  p_vector <- airdata[[pollutant]]
  return(mean(p_vector, na.rm = TRUE))
}