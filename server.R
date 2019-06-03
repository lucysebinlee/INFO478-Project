# server.R

# Load Packages
library(shiny)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)
library(plotly)
library(DT)

# Process and Store Data
d1 <- data.table::fread("data/student-mat.csv", header = TRUE)
d2 <- data.table::fread("data/student-por.csv", header = TRUE)
d3 <- merge(d1, d2, by = c("school", "sex", "age", "address", "famsize", "Pstatus", 
                          "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet",
                          "famrel", "goout", "absences", "failures"))

dmat <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
dpor <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

print(nrow(d3)) # 382 students

# Define server logic required to draw a histogram
  server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
  })
  
  interactive_alc_data <- reactive({
    dmat %>%
    select_("Dalc", input$var, 'Walc') %>%
      group_by_(input$var) %>%
      summarize_all(funs(mean))
  })

  output$interactiveAlcPlot <- renderPlotly({
    plot_ly(interactive_alc_data(), x = ~get(input$var), y = ~get(input$alc), type= 'bar') %>%
      layout(xaxis = list(title = input$var), yaxis = list(title = input$alc))
  })
  
}
