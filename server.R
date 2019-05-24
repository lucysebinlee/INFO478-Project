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
                          "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet"))
print(nrow(d3)) # 382 students

# Define server logic required to draw a histogram
  server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
  })
  
}
