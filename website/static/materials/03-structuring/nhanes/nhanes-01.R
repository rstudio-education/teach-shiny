# Load packages -----------------------------------------------------
library(shiny)
library(tidyverse)
library(NHANES)

# Define UI ---------------------------------------------------------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions --------------
  sidebarLayout(
    
    # Inputs: Select variables to plot ------------------------------
    sidebarPanel(
      
      # Select variable for y-axis ----------------------------------
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("Age", "Poverty", "Pulse", "AlcoholYear", "BPSysAve"), 
                  selected = "BPSysAve"),
      
      # Select variable for x-axis ----------------------------------
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("Age", "Poverty", "Pulse", "AlcoholYear", "BPDiaAve"), 
                  selected = "BPDiaAve")
    ),
    
    # Output: Show scatterplot --------------------------------------
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server function required to create the scatterplot ---------
server <- function(input, output) {

  # Create scatterplot object the plotOutput function is expecting --
  output$scatterplot <- renderPlot({
    ggplot(data = NHANES, aes_string(x = input$x, y = input$y)) +
      geom_point()
  })
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)
