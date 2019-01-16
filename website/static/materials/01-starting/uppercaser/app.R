# Load packages -----------------------------------------------------
library(shiny)

# Define UI ---------------------------------------------------------
ui <- fluidPage(
  
  # App title
  titlePanel("Uppercaser"),
  
  textInput(inputId = "entered_text", 
            label = "Enter text to be converted to uppercase in the box below", 
            placeholder = "Enter text here"),
  
  textOutput(outputId = "uppercase_text")
  
)

# Define server function --------------------------------------------
server <- function(input, output) {
  
  # Create text object the textOutput function is expecting
  output$uppercase_text <- renderText({
    toupper(input$entered_text)
  })
  
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui, server)
