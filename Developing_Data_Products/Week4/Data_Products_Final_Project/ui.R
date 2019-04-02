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
  titlePanel("Stock Prices"),
  
  # Sidebar: asks the user for which stocks to track, and the years to view 
  sidebarLayout(
    sidebarPanel(
       sliderInput("years",
                   "What range of years do you want to view?",
                   min = 2007,
                   max = 2019,
                   value = c(2014, 2019)),
       textInput("symbol",
                 "What stock symbols do you want to track? (e.g. GOOGL, AAPL,
                 AMZN)"),
       actionButton("symbol_button",
                    "Submit"),
        h2("Stocks we are tracking:"),
        textOutput("symbols")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      h3(textOutput("error")),
      plotOutput("stockPlot"),
      h3("Reset the Page?"),
      actionButton("reset", "Reset")
    )
  )
))
