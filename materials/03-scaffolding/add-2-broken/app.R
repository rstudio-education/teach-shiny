library(shiny)

# UI ---------------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Add 2"),
  sliderInput("x", "Select x", min = 1, max = 50, value = 30),
  textOutput("x_updated") 
  )

# Server -----------------------------------------------------------------------
server <- function(input, output) {
  add_2            <- function(x) { x + 2 }
  current_x        <- add_2(input$x)
  output$x_updated <- renderText({ current_x })
}

# Create Shiny app object ------------------------------------------------------
shinyApp(ui, server)
