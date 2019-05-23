# Load Packages
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Process and Store Data
d1 = read.table("data/student-mat.csv", sep=";", header = TRUE)
d2 = read.table("data/student-por.csv", sep=";", header = TRUE)
d3 = merge(d1,d2,by=c("school", "sex", "age", "address", "famsize", "Pstatus", 
                      "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet"))
print(nrow(d3)) # 382 students

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
  })
  
})
