## Write a function called rankall that takes two arguments: 
## an outcome name (outcome) and a hospital ranking (num).

## The function returns a 2-column data frame containing the hospital
## in each state that has the ranking specified in 'num'.

source("rankhospital.R")

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv",
                           colClasses = "character")
  
  ## Check that the outcome is valid
  if(!(outcome %in% c("heart failure","heart attack", "pneumonia"))){
    stop("invalid outcome")}
  
  state_list <- sort(unique(outcome_data$State))
  ## Return table of hospitals with given ranking in each state.
  for(state in state_list){
    hospital <- rankhospital(state, outcome, num, outcome_data)
    row <- data.frame(hospital = hospital, state = state)
    if(state == state_list[1]){
      table <- row
    } else {
      table <- rbind(table, row)
    }
  }
  table
}
