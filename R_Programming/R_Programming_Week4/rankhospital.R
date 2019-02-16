library(tidyverse)

## Write a function called 'rankhospital' that takes three arguments:
## the 2-character abbreviated name of a
## state (state), an outcome (outcome), and the ranking of 
## a hospital in that state for that outcome (num).

## The 'num' argument can take values "best", "worst", or an
## integer indicating the ranking (smaller numbers are better).

## If the given num is larger than the number of hospitals
## in that state, then the funciton should return NA.


rankhospital <- function(state, outcome, num = "best", outcome_data = NULL){
  ## Read outcome data if necessary
  if(is.null(outcome_data)){
    outcome_data <- read.csv("outcome-of-care-measures.csv",
                           colClasses = "character")
  }
  
  ## Check that the state and outcome are valid
  if(!(state %in% outcome_data$State)) stop("invalid state")
  if(!(outcome %in% c("heart failure","heart attack", "pneumonia"))){
    stop("invalid outcome")}
  
  ## Return hospital name in that state with lowest 30-day death rate
  
  outcome_data %>% filter(State == state) -> state_outcome_data
  if(outcome == "heart attack"){
    state_outcome_data %>% 
      rename(Mort = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) %>%
      select(c(2, 11)) %>% 
      filter(Mort != "Not Available") %>%
      arrange(as.numeric(Mort), Hospital.Name) ->
      out_hospitals
  } else if(outcome == "heart failure"){
    state_outcome_data %>% 
      rename(Mort = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>%
      select(c(2, 17)) %>% 
      filter(Mort != "Not Available") %>%
      arrange(as.numeric(Mort), Hospital.Name) ->
      out_hospitals
  } else if(outcome == "pneumonia"){
    state_outcome_data %>% 
      rename(Mort = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
      select(c(2, 23)) %>%
      filter(Mort != "Not Available") %>%
      arrange(as.numeric(Mort), Hospital.Name) ->
      out_hospitals
  }
  
  if(num == "best"){out_hospitals[1,1]}
  else if(num == "worst"){out_hospitals[length(out_hospitals[,1]),1]}
  else{out_hospitals[num,1]}
  
}