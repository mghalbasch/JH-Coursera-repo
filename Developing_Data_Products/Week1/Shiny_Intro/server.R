library(shiny)

# Define server logic required to produce plot
shinyServer(function(input, output) {
   
  output$display <- renderText({
    if(is.null(input$plot_brush)){
      lower <- 1
      upper <- 4
    } else{
      lower <- round(input$plot_brush$xmin, 2)
      upper <- round(input$plot_brush$xmax, 2)
    }
    paste("The weights considered range from", lower, "to", upper, sep=" ")
  })
  
  output$fit <- renderPlot({
    library(ggplot2)
    if(is.null(input$plot_brush)){
      lower <- 1
      upper <- 4
    } else{
      lower <- input$plot_brush$xmin
      upper <- input$plot_brush$xmax
    }
    
    mtcars %>% filter(wt >= lower & wt <= upper) %>%
      ggplot(aes(x = wt, y = mpg)) +
      geom_point() -> g
    
    if(input$show_fit){g <- g + geom_smooth(method = "lm", se = FALSE)}
    g
  })
})
