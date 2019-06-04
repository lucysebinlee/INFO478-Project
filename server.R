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

source('tabitha_analysis.R')

print(nrow(d3)) # 382 students

# Define server logic required to draw a histogram
  server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
  })
  
  output$agePlot <- renderPlotly({
    
    new_data <- needed_data %>% filter(age == input$age) 
    
    # draw the histogram with the specified number of bins
    plot_ly(new_data, x = ~Dalc, type = 'histogram', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5))) %>%
      layout(yaxis = list(title = "Count"),
             xaxis = list(title = 'Dalc'), barmode = 'group',
             title = "Total Amount for Each Dalc Level")
    
  })
  
  output$newPlot <- renderPlotly({
    
    gender_data <- needed_data %>% filter(sex == input$sex)
    plot_ly(gender_data, x = ~Dalc, type = 'histogram', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5))) %>%
      layout(yaxis = list(title = "Count"),
             xaxis = list(title = 'Dalc'), barmode = 'group',
             title = "Total Amount for Each Dalc Level")
    
  })
  
  output$sexPlot <- renderPlotly({
    
    if (input$sex2 == "All") {
      plot_ly(total_average_dalc, x = ~age, y = ~avg_Dalc, type = 'bar',
              text = ~avg_Dalc, textposition = 'auto', 
              marker = list(color = 'rgba(219, 64, 82, 0.7)',
                            line = list(color = "orange", width = 1.5))) %>%
        layout(yaxis = list(title = "Average Dalc"),
               xaxis = list(title = 'Age'), barmode = 'group',
               title = "Average Dalc For Each Age")
      
    } else {
      plot_ly(spread_sex_walc, x = ~age, y = ~female, type = 'bar', name = 'Female',
              text = ~female, textposition = 'auto', marker = list(color = 'rgba(219, 64, 82, 0.7)',
                                                                   line = list(color = "orange", width = 1.5))) %>% 
        add_trace(y = ~male, name = 'Male', text = ~male, textposition = 'auto',
                  marker = list(color = 'rgb(158, 202, 225)', line = list(color = 'rgb(8,48,107)', width = 1.5))) %>% layout(yaxis = list(title = "Average Dalc"),
                                                                                                                             xaxis = list(title = 'Age'), barmode = 'group',
                                                                                                                             title = "Average Dalc For Each Age")
      
    } 
    
  })
  
  interactive_data <- reactive({
    dmat %>%
    select_("Dalc", input$var, 'Walc') %>%
      group_by_(input$var) %>%
      summarize_all(funs(mean))
  })
  
  output$test <- renderDataTable(interactive_data())
  
  output$interactivePlot <- renderPlotly({
    p <- ggplot(interactive_data(), aes_string(x = input$var, y = input$alc)) + 
      geom_bar(stat = 'identity')
    
    ggplotly(p)
    
  
  })
  
}
