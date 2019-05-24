# ui.R

# Load Packages
library(shiny)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)
library(plotly)
library("shinydashboard")


# # Define UI for application
# shinyUI(
#   navbarPage(
#     "Student Alcohol Consumption",
#     tabPanel(
#       "Overview",
#       mainPanel(
#         h3("Overview")
#       )
#     ),
#     tabPanel(
#       ,
#       mainPanel(
#         h3("Grades vs. Alcohol Consumption")
#       )
#     )
#   )
# )

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      "Introduction",
      tabName = "Introduction", icon = icon("dashboard")
    ),
    menuItem("Grades vs. Alcohol Consumption", 
             tabName = "Grades_alcohol_Consumption", 
             icon = icon("globe-asia")),
    menuItem(
      "Rita",
      tabName = "Rita", icon = icon("dollar-sign")
    ),
    menuItem("Brian",
             icon = icon("chart-line"),
             tabName = "Brian"
    ),
    menuItem("Katie",
             icon = icon("Katie"),
             tabName = "Brian"
    ),
    menuItem("Tabitha",
             icon = icon("chart-line"),
             tabName = "Tabitha"
    ),
    menuItem("Original Codes",
             icon = icon("file-code-o"),
             href = "https://github.com/lucysebinlee/INFO478-Project"
    )
  ))

  
  body <- dashboardBody(
    tabItems(
      tabItem(
        tabName = "Introduction",
        h2("Facts of Suicide"),
        p("The action of sucide typically involves strong
          emotional repercussions not
          only affecting victims themsevles but also affecting surrounding people.
          It is reported that approximately one million people die
          from suicide by
          The World Health Organisation(WHO) and it is considered as one of the three
          leading causes of death worldwide. The cause for suicide varies including
          but is not limited to age, sex, GDP and HDI etc.
          , and certain groups tend to commit suicide more frequent than others."),
        h2("Insight of suicide worldwide"),
        p(
          "In every country, the number of people who commit suicides are
          substantial. The bar graph below gives a", strong("general overivew"),
          "on the
          total number of people died from suicide from 1985 to 2016 in each
          country where the data could be collected."
        ),
        plotlyOutput("bargraph"),
        br(),
        h2("What is our purpose?"),
        p("The ultimate purpose of analyzing this dataset is to prevent
          future suicide by finding out the cause to suicide based on the
          dataset we used. Alternatively, we also provide a prediction on
          the suicide rate with respect to given conditions."),
        h2("Analysis Overview"),
        h4("Data Overview"),
        tags$ul(
          tags$li("first aspect"),
          tags$li("Second list item"),
          tags$li("Third list item")
        ),
        h3("Who Are We?"),
        p(
          "This project was made by",
          strong(class = "name", "Yinan Guo, Song Xue, Rita Wu,
                 Badmaarag Batjargal"),
          "as the final project for the course Info 201."
          ),
        tags$a(
          href = "https://www.kaggle.com/russellyates88/
          suicide-rates-overview-1985-to-2016",
          "Source of data: Click here!"
        )
        )
      )
  )
  
  ## ui code starts here
  ui <- fluidPage(
    includeCSS("custom.css"),
    dashboardPage(
      dashboardHeader(title = "Student Alcohol Consumption"),
      sidebar,
      body
    )
  )
    
    