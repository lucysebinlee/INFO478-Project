# INFO 478: Lucy Lee, Rita Wu, Brian Luu, Tabitha Anderson, Katie Clark
# server.R

# Load Packages
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Load Data
d1 = read.table("data/student-mat.csv", sep=";", header = TRUE)
d2 = read.table("data/student-por.csv", sep=";", header = TRUE)
d3 = merge(d1,d2,by=c("school", "sex", "age", "address", "famsize", "Pstatus", 
                      "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet"))
print(nrow(d3)) # 382 students