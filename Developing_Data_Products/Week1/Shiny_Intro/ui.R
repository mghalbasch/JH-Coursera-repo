#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mileage Versus Weight"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("range_slider", "My slider", 1, 4, c(1,4), step = .1),
       checkboxInput("show_fit", "Show the basic fit?", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("display"),
       plotOutput("fit", brush = "plot_brush")
    )
  )
))
