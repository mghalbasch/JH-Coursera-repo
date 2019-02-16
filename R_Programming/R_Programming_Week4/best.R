# Create a function to return the best hospital (hospital with the lowest
# mortality rate) for the given state and outcome

# 'state' is a two-letter abbreviation of a state, e.g. "TX" or "CA"

# 'outcome' is one of "heart attack", "heart failure", and "pneumonia" 
best <- function(state, outcome){
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv",
                           colClasses = "character")
  
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
  out_hospitals[1,1]
}