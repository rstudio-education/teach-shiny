# This app has some parts commented out for various secreenshots for 
# the "hide the veggies" section of the lesson.

# Load packages -----------------------------------------------------
library(shiny)
library(tidyverse)
library(glue)

# Load data ---------------------------------------------------------
load("data/movies.Rdata")

# Load helpers ------------------------------------------------------
source("helpers.R")

# Define UI ---------------------------------------------------------
ui <- fluidPage(
  
  # App title
  titlePanel("Movie browser"),
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Subtitle
      h4("Sample"),

      # Set sample size
      numericInput(inputId = "sample_size",
                   label = "Enter a sample size between 1 and 651:",
                   min = 1, max = nrow(movies),
                   value = 30),

      # Take random sample
      actionButton(inputId = "sample_button",
                   label = "Take random sample"),

      # # Write random sample to csv
      # actionButton(inputId = "write_csv", 
      #              label = "Write CSV"),
      # 
      # # Visual separation
      # br(), hr(),
      
      # Subtitle
      h4("Plot"),
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "imdb_rating"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "critics_score"),
      
      # Select variable for color
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Title Type" = "title_type", 
                              "Genre" = "genre", 
                              "MPAA Rating" = "mpaa_rating", 
                              "Critics Rating" = "critics_rating", 
                              "Audience Rating" = "audience_rating"),
                  selected = "mpaa_rating"),
      
      # Set alpha level
      sliderInput(inputId = "alpha", 
                  label = "Alpha:", 
                  min = 0, max = 1, 
                  value = 0.5),
      
      # Visual separation
      br(), hr(),
      
      # Subtitle
      h4("Data"),
      
      # Show data table
      checkboxInput(inputId = "show_data",
                    label = "Show data table",
                    value = FALSE)
      
    ),
    
    # Output:
    mainPanel(
      
      # Show scatterplot
      plotOutput(outputId = "scatterplot"),
      br(), br(),    # a little bit of visual separation
      
      # Show data table
      DT::dataTableOutput(outputId = "moviestable")
    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {
  
  # Take a random sample
  movies_sample <- eventReactive(
    # when button is clicked
    input$sample_button, {

      # take a sample
      movies %>% sample_n(input$sample_size)

    },
    ignoreNULL = FALSE # initially perform calculation when app launches
  )
  
  # Take a random sample without reactives
  # movies_sample <- reactive({
  #  movies %>% sample_n(input$sample_size)
  #})
  
  # 
  # # Write random sample to csv
  # observeEvent(
  #   # when button is clicked
  #   input$write_csv, {
  #     
  #     # clean up text for now
  #     now <- Sys.time() %>%
  #       str_replace_all("\\:", "-") %>%
  #       str_replace(" ", "_")
  #     # create a filename with movies_sample and timestamp
  #     filename <- glue("movies_sample_{now}.csv")
  #     # write csv
  #     write_csv(movies_sample(), path = filename)
  #     
  #   }
  # )
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    # ggplot(data = movies, aes_string(x = input$x, y = input$y,
    ggplot(data = movies_sample(), aes_string(x = input$x, y = input$y,
                                              color = input$z)) +
      geom_point(size = 3, alpha = input$alpha) +
      labs(x = prettify_label(input$x),
           y = prettify_label(input$y),
           color = prettify_label(input$z)) +
      theme_bw() +
      scale_color_viridis_d()
  })
  
  # Print data table if checked
  output$moviestable <- DT::renderDataTable(
    if(input$show_data){
      # DT::datatable(data = movies_sample()[, 1:7], 
      DT::datatable(data = movies[, 1:7], 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
    }
  )
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui, server)
