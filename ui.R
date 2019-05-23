# ui.R

# Load Packages
library(shiny)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)
library(plotly)
library(DT)

# Define UI for application
shinyUI(
  navbarPage(
    "Student Alcohol Consumption",
    tabPanel(
      "Overview",
      mainPanel(
        h3("Overview")
      )
    ),
    tabPanel(
      "Grades vs. Alcohol Consumption",
      mainPanel(
        h3("Grades vs. Alcohol Consumption")
      )
    )
  )
)