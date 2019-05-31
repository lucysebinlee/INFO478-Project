# ui.R

# Load Packages
library(shiny)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(dplyr)
library(plotly)
library(shinydashboard)
library(sunburstR)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      "Introduction",
      tabName = "Introduction", 
      icon = icon("dashboard")
    ),
    menuItem("Grades vs. Alcohol Consumption",
      tabName = "Grades_alcohol_Consumption",
      icon = icon("globe-asia")
    ),
    menuItem(
      "Background",
      tabName = "Rita", 
      icon = icon("dollar-sign")
    ),
    menuItem("Brian",
      icon = icon("chart-line"),
      tabName = "Brian"
    ),
    menuItem("Katie",
      icon = icon("Katie"),
      tabName = "Katie"
    ),
    menuItem("Tabitha",
      icon = icon("chart-line"),
      tabName = "Tabitha"
    ),
    menuItem("Original Codes",
      icon = icon("file-code-o"),
      href = "https://github.com/lucysebinlee/INFO478-Project"
    )
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "Introduction",
      h3("Student’s Alcohol Consumption"),
      p("By. Tabitha Anderson, Katie Clark, Lucy Lee, Brian Luu, Rita Wu"),
      br(),
      h4("Project Description"),
      br(),
      h5("Purpose"),
      p("In order to teach effectively, it is important for educators to understand the factors that influence 
        student performance. In fact, in order to learn effectively, it is also important for students to 
        understand the factors that influence their performance. Thus, this research project seeks to provide 
        that information by visualizing data from a student performance dataset. By doing so, this web application 
        will explore the effects of alcohol consumption over student’s academic performance."),
      br(),
      h5("Target Audience"),
      p("Our target audience would be secondary school students, which this project will help them understand the possible 
        effects that alcohol consumption can have on the many aspects of their lives. Moreover, another target audience 
        would be educators. This analysis could be utilized to help guide these educators on how to help their students 
        in the best way possible."),
      br(),
      h5("Dataset"),
      p("The data we will be using is “Student Alcohol Consumption,” which was collected by UCI Machine Learning from the 
        University of California, Irvine. We accessed the information on
        Kaggle (Link: https://www.kaggle.com/uciml/student-alcohol-consumption), 
        which is an educational dataset collected by a survey of students in math a
        nd portuguese language courses in a secondary school to predict students’ 
        final grade. The dataset consists of a sample of 382 students and their 
        associated attributes that characterize each student, including gender, age, 
        family size, parent’s job, school absences, and more.")
    ),
    tabItem(
      tabName = "Rita",
      h3("The background influences"),
      p("In terms of how much college students drink, we think background factors are 
          also important. In this area, we will analyze the education level of students' 
          parents, job occupation, students' family environment and growth atmosphere. 
          The data were analyzed to find out whether these background factors were related 
          to students' alcohol consumption. And try to find out what factors will influence this behavior the most."),
      br(),
      h3("The variables of background infomation"),
      p("Under this part, there are two pie charts and two bar plots which are directly show the 
          variable of the student's location, family size, guardian type and family relationships."),
      br(),
      plotlyOutput("pie"),
      h4("Infomation From Address"),
      tags$ul(
        tags$li("There are two types of student's home address rural and urban. 
                  From the pie chart we can tell that students who live in urban area drink more than twice as much as 
                  those who live in rural areas."),
        tags$li("The reason may be that living in the urban area is more convenient and 
                      has more opportunities to attend occasions 
                  that you can drink alcohol, such as parties. Secondly, students who may 
                  live in rural areas have more recreational activities than the urban areas."),
        tags$li("There may be more reasons for this result. In conclusion, the residence of 
                a family has a great influence on the amount of alcohol students drink.")
      ),
        br(),
        h4("Infomation From Family Size"),
        tags$ul(
          tags$li("For the family size type is binary whether less or equal to 3 or greater than 3. 
                 The second pie chart shows that tudents with more than three family members drank more than twice 
                  as much as those with fewer than three."),
          tags$li("The reason for this may be that more family members increase their exposure to alcohol. 
                  Because family members are older, more diverse in their habits, and even more diverse in 
                  their occupations, they indirectly increase their chances of drinking. Second, having a 
                  larger family may increase the chances of drinking. Also, with a large family, the amount 
                  of alcohol stored may be greater, and people may drink more without realizing it.")
        ),
      br(),
        plotlyOutput("bar"),
      h4("Infomation From Guardians and Family Relationship"),
      
      tags$ul(
        tags$li("The student's guardian types in nominaly are mother, father or other. 
                And quality of family relationships from 1 which is very bad to 5 which means excellent.
                From the bar chart, we can tell that students who lived with their mothers drank far more 
                than children whose fathers or others acted as guardians."),
        tags$li("We can infer from the results that it is possible that mothers are more relaxed about 
               their children's alcohol intake and fathers are more strict about drinking alcohol. 
                For the family relationship fact, the students with a better family relationship have higher
                alcohol consumption than students with lower quality family relationship.")
        ),
      
        radioButtons("education",
          label = "Parent's Education Level",
          choices = c(
            "Mother's education" = "Medu",
            "Father's education" = "Fedu"
          )
        ),

        plotOutput("educationPlot"),
        radioButtons("occupation",
          label = "Parent's Jobs type",
          choices = c(
            "Mother's job" = "Mjob",
            "Father's job" = "Fjob"
          )
        ),
        plotOutput("jobPlot")
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
