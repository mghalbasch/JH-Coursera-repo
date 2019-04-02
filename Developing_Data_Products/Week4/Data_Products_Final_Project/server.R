#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(quantmod)
library(tidyverse)
library(reshape2)
library(ggsci)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  v <- reactiveValues(symbols = NULL, data = NULL, error = NULL)
  
  observeEvent(input$symbol_button, {
    s <- input$symbol
    df <- NULL
    try({df = getSymbols(s, auto.assign = FALSE)}, silent = TRUE)
    if(!is.null(df)){
      v$error <- NULL
      v$symbols <- append(v$symbols, s)
      df <- data.frame(df) %>% rownames_to_column("Date") %>%
        select(Date, !!s := ends_with("Close"))
      if(is.null(v$data)){
        v$data <- df
      }else{
        v$data <- merge(v$data, df, by="Date", all = TRUE)
      }
    } else{
      v$error <- "Couldn't find that Stock. Check that the symbol is correct."
    }
    updateTextInput(session, "symbol", value = "")
  })
  
  output$symbols <- renderText({paste(v$symbols, collapse = ", ")})
  output$error <- renderText({v$error})

  output$stockPlot <- renderPlot({
    if(is.null(v$data)){return()}
    year_lower <- input$years[1]
    year_higher <- input$years[2]
    v$data %>% 
      filter(Date >= year_lower & Date <= year_higher) %>%
      melt(id.vars = "Date") %>% 
      ggplot(aes(x = as.Date(Date), y = value, color = variable)) +
      geom_line() +
      xlab("Date") +
      ylab("Closing Stock Price") +
      labs(title = "Stock Prices Over Time") +
      theme_minimal() +
      scale_color_nejm() +
      theme(legend.title = element_blank())
  })
  
  observeEvent(input$reset, {
    v$symbols <- NULL
    v$data <- NULL
    v$error <- NULL
  })
})
