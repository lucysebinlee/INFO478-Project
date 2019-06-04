# server.R
source("Rita_analysis.R")

# Load Packages
library(shiny)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)
library(plotly)
library(DT)

dmat <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
dpor <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

source('tabitha_analysis.R')

print(nrow(d3)) # 382 students

# Define server logic required to draw a histogram
  server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
  })
  
  output$agePlot <- renderPlotly({
    needed_data <- needed_data %>% filter(age != 22 | age != 21)
    new_data <- needed_data %>% filter(age == input$age) 
    
    # draw the histogram with the specified number of bins
    plot_ly(new_data, x = ~Dalc, type = 'histogram', hoverinfo = 'none', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5))) %>%
      layout(yaxis = list(title = "Count"),
             xaxis = list(title = 'Dalc'), barmode = 'group',
             title = "Total Amount for Each Dalc Level")
    
  })
  
  output$newPlot <- renderPlotly({
    
    gender_data <- needed_data %>% filter(sex == input$sex)
    plot_ly(gender_data, x = ~Dalc, type = 'histogram', hoverinfo = 'none', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5))) %>%
      layout(yaxis = list(title = "Count"),
             xaxis = list(title = 'Dalc'), barmode = 'group',
             title = "Total Amount for Each Dalc Level")
    
  })
  
  output$sexPlot <- renderPlotly({
    
    if (input$sex2 == "All") {
      plot_ly(total_average_dalc, x = ~age, y = ~avg_Dalc, type = 'bar', hoverinfo = 'none',
              text = ~avg_Dalc, textposition = 'auto', 
              marker = list(color = 'rgba(219, 64, 82, 0.7)',
                            line = list(color = "orange", width = 1.5))) %>%
        layout(yaxis = list(title = "Average Dalc"),
               xaxis = list(title = 'Age'), barmode = 'group',
               title = "Average Dalc For Each Age")
      
    } else {
      plot_ly(spread_sex_walc, x = ~age, y = ~female, type = 'bar', name = 'Female', hoverinfo = 'none',
              text = ~female, textposition = 'auto', marker = list(color = 'rgba(219, 64, 82, 0.7)',
                                                                   line = list(color = "orange", width = 1.5))) %>% 
        add_trace(y = ~male, name = 'Male', text = ~male, textposition = 'auto',
                  marker = list(color = 'rgb(158, 202, 225)', line = list(color = 'rgb(8,48,107)', width = 1.5))) %>% layout(yaxis = list(title = "Average Dalc"),
                                                                                                                             xaxis = list(title = 'Age'), barmode = 'group',
                                                                                                                             title = "Average Dalc For Each Age")
      
    } 
    
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
  
  output$pie <- renderPlotly({
    pie <- plot_ly() %>%
      add_pie(data = address.data, labels = ~address, values = ~alc,
              name = "address", domain = list(x = c(0, 0.4), y = c(0.4, 1))) %>%
      add_pie(data = famsize.data, labels = ~family.size, values = ~alc,
              name = "family.size", domain = list(x = c(0.6, 1), y = c(0.4, 1))) %>%
      layout(title = "Address & Family Size", showlegend = F,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  
  output$bar <- renderPlotly({
    guardian.bar <- plot_ly(guardian.data, x = ~guardian, y = ~alc, type = 'bar', 
                            
                            marker = list(color = 'rgb(158,202,225)',
                                          line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
      layout(title = "Guardian",
             xaxis = list(title = "guardian type"),
             yaxis = list(title = "alcohol consumption"))
    
    relation.bar <- plot_ly(famrel.data, x = ~family.relationship, y = ~alc, type = 'bar', 
                            
                            marker = list(color = 'rgba(219, 64, 82, 0.7)',
                                          line = list(color = 'orange', width = 1.5))) %>%
      layout(title = " Guardian & Family Relationship",
             xaxis = list(title = "relationship level"),
             yaxis = list(title = "alcohol consumption"))
    
    bar <- subplot(guardian.bar, relation.bar)
    

  })
  
  output$educationPlot <- renderPlot({
    education.data <- parent.edu %>% filter(variable == input$education)
    
    ggplot(education.data, aes(value, alc, label = alc)) +
      geom_segment(aes(x=value, xend=value, y=0, yend=alc)) +
      geom_point(size = 11, color = "orange" ) +
      geom_text(color = "white", size = 3) + 
      labs(title="Parent's Education Vs Student's Alcohol Consumption", x= "Education Level") 
    
  })
  
  output$jobPlot <- renderPlot({
    
    job.data <- parent.job %>% filter(variable == input$occupation)
    
    ggplot(job.data, aes(value, alc, label = alc)) +
      geom_segment(aes(x= value, xend = value, y=0, yend = alc)) +
      geom_point(size = 11, color = "springgreen3" ) +
      geom_text(color = "white", size = 3) + 
      labs(title="Parent's Occupation Vs Student's Alcohol Consumption")
    
  })
  
  
}
