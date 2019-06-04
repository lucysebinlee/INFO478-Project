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
      icon = icon("address-book")
    ),
    menuItem("Brian",
      icon = icon("chart-line"),
      tabName = "Brian"
    ),
    menuItem("Alcohol Consumption",
      icon = icon("chart-line"),
      tabName = "Katie"
    ),
    menuItem("Sex and Age",
      icon = icon("venus-mars"),
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
      tabName = "Grades_alcohol_Consumption",
      h3("Grades vs. Alcohol Consumption"),
      br(),
      p("First, this tab compares the data between the rate of alcohol consumptions and grades.
        From the data represented in these charts, it can be shown that higher grades are associated 
        with lower daily alcohol consumption. For the First Period Grades vs. Alcohol Consumption, the grade 
        is the highest at 1 day and lowest at 5 days, with the grade decreasing everyday after the first. 
        This trend continues for the second-period grades and the final period grades."),
      img(src = "grades1.png", height = 400),
      br(),
      img(src = "grades2.png", height = 400),
      br(),
      img(src = "grades3.png", height = 400),
      br(), br(),
      p("Some reasons for this result is because students may be spending more time drinking than focusing on 
        their school work. Another possible reason may be that  students who spend more time drinking 
        might simply be less serious about their academic careers. However, these reasons are simply 
        suggestive and by no means are conclusive reasons for why grades are lower for those with less 
        daily alcohol consumption. One that is certain is that there is say from our charts that is 
        that there is definitely an associative relationship between grades and daily alcohol consumption. 
        In conclusion, more daily alcohol consumption for students lead to lower grades."),
      br(),
      p("In support of these claims, an article 'Is Alcohol Consumption Associated with Poor Academic 
        Achievement in University Students?' by Walid El Ansari et al., was reviewed. They assessed the
        associations between educational achievement and alcohol consumption by employing five different
        alcohol consumption measures (length of time and the amount of alcohol consumed for 
        the most recent occasion, frequency of alcohol consumption, heavy drinking, and problem drinking) and
        three educational indicators (student's importance of achieving good grades, appraisal of their academic
        performance compared to other students, and student's actual mark). As a result, they found that alcohol 
        consumption showed *negative* associations with motivation to achieve academic performance. Moreover, in
        comparison with other peers, those who drink more alcohol was negatively associated with heavy drinking."),
      br(),
      p("Thus, our findings can convey that alcohol consumption and academic performance for students are highly relevant.
        Educators should aim at prevention of alcohol abuse, while paying more attention to their alcohol policies.
        Likewise, students should aim to reduce the rate of their alcohol consumption if they are hoping to achieve
        higher academic performance for their education."),
      br(),
      p("Source: El Ansari, Walid et al. “Is alcohol consumption associated with poor academic achievement 
        in university students?.” International journal of preventive medicine vol. 4,10 (2013): 1175-88.")
    ),
      tabItem(tabName = "Katie",
            h2("How do the different variables correlate to alcohol Consumption?"),
            selectInput('alc', 'Alchohol Consumption', list('Workday Alchohol Consumption' = 'Dalc', 
                                                            'Weekend Alcohol Consumption' = 'Walc')),
            selectInput('var', 'Variable', list('Family Relationship' = 'famrel', '# of Absences' = 'absences',
                                                '# of Class Failures' = 'failures', 'Going out with Friends' = 'goout',
                                                'First Period Grades' = 'G1', 'Second Period Grades' = 'G2',
                                                'Third Period Grades' = 'G3')),

            plotlyOutput('interactiveAlcPlot')
      ),
      tabItem(tabName = "Tabitha",
             h2("How does does Gender and Age Effect Alcohol Consumption?"),
             br(),
             p('In this section, we will be evaluating how someones age changes how much alcohol they will consume
               daily. The scale that we are using is the Dalc which acounts for the Daily Alcohol Consumption throughout
               the week. A 1 would be considered very low alcohol consumption, while a 5 would indicate very high 
               alcohol consumption. We will see how these scores are effected with the variations in someones age or sex.'),
             br(),
             h3('How Age Effects the Daily Alcohol Consumption of Students'),
             br(),
             p('With this first visual, we will show the distribution of alcohol consumption for each age. Move the slider
               to be able to evaluate which age will have the highest amount of people with either low or high Daily
               Alcohol Consumption.'),
             br(),
               sliderInput("age",
                           "Pick An Age:",
                           min = 15,
                           max = 20,
                           value = 18),
              plotlyOutput('agePlot'),
             h4('Results for Age Distribution Graph'),
             br(),
             p("When checking for the different ages, we can start to see a shift in the alcohol consumption rates. When looking at
               the lowest age, we find that there are not a lot of kids drinking excessively. With each age increase, we can slowly
               start to see this begin to change. More and more students begin to fall under the 3+ categories, and there is less people
               drinking at the lowest amount. Something to keep in mind is that these data ranges have different amounts and the highest
               ages have less people responding. We believe that these ages have enough response that this trend would continue with more
               data."),
             br(),
             h3('How Sex Effects the Daily Alcohol Consumption of Students'),
             br(),
             p('Instead of age, we will now try to see if there are any fundamental differences between how woman and men consume alcohol.'),
             br(),
             radioButtons("sex",
                          "Choose by Sex:",
                          c("Female" = 'F', 'Male' = 'M')),
             plotlyOutput('newPlot'),
             br(),
             h4('Results for Sex Distrbution Graph'),
             br(),
             p('When we switch between females and males, there seems to be quite a shift between the different sexes. With males, we see a 
               higher amount of people in the 3, 4, and 5 categories, and less in the 1 and 2 than their female counterparts. This would
               support the idea that men tend to consume more than females.'),
             br(),
             h3('Average Daily Alcohol Consumption Levels'),
             br(),
             p('For this next visual, we are trying to see the average levels for each age by sex. We are also able to ignore the changes
               in sex and look at the averages for the sexes combined. Since there is not an equal amount of data for each category, this 
               will help us get a different view than the two previous distribution charts.'),
             br(),
             radioButtons("sex2",
                          "Choose by Sex:",
                          choices = c("Sexes", "All")),
             plotlyOutput('sexPlot'),
             h4('Results For the Daily Alcohol Consumption Averages'),
             br(),
             p('Something that we see with this graph is that the averages for male exceed females for every age
               except 19 years old. This would support the previous idea that men tend to drink more excessively than
               their female counterparts. When we begin to look at the averages without the different sexes, we start to
               see another trend. This one sees the drinking levels increase pretty drastically after turning 21. This
               would show that once people have more access to alcohol, they are more likely to drink more excessively.')

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
                variable of the student's home location, family size, guardian type and family relationships."),
              br(),
              plotlyOutput("pie"),
              h4("Infomation From Address"),
              tags$ul(
                tags$li("There are two types of student's home address rural and urban. 
                        From the pie chart we can tell that students who live in rural area drink a little more than 
                        those who live in urban areas."),
                tags$li("We might think that living in the urban area is more convenient and 
                        has more opportunities to attend occasions 
                        that you can drink alcohol, such as parties. But that wasn't the case. The result 
                        was greater drinking in rural areas. The reason for this may be that there are not 
                        as many recreational activities in rural areas as in cities, and alcohol is easily available"),
                tags$li("There may be more reasons for this result. In conclusion, the residence of 
                        a family has a slight influence on the amount of alcohol students drink.")
                ),
              br(),
              h4("Infomation From Family Size"),
              tags$ul(
                tags$li("For the family size type is binary whether less or equal to 3 or greater than 3. 
                        The second pie chart shows that students with more than three family members drink less than
                        those with fewer than three."),
                tags$li(" Students with larger families may have greater exposure to alcohol. For students with small 
                        families, a slightly higher alcohol intake may be due to fewer family members opposing alcohol consumption, or 
                        less strict regulation and more time with friends.")
                ),
              br(),
              plotlyOutput("bar"),
              h4("Infomation From Guardians and Family Relationship"),
              tags$ul(
                tags$li("The student's guardian types in nominaly are mother, father or other. 
                        And quality of family relationships from 1 which is very bad to 5 which means excellent.
                        From the bar chart, we can tell that students who lived with their mothers drank less  
                        than children whose fathers or others acted as guardians."),
                tags$li("We can infer from the results that it is possible that fathers or others acted as guardians
                        are more relaxed about 
                        their children's alcohol intake and mothers are more strict about drinking alcohol. 
                        For the family relationship fact, the students with a better family relationship have lower
                        alcohol consumption than students with lower quality family relationship.")
                ),
              fixedRow(
                column(
                  3,
                  radioButtons("education",
                               label = "Education Level",
                               choices = c(
                                 "Mother's education" = "Medu",
                                 "Father's education" = "Fedu"
                               )
                  )
                ),
                
                column(
                  6,
                  radioButtons("occupation",
                               label = "Jobs type",
                               choices = c(
                                 "Mother's job" = "Mjob",
                                 "Father's job" = "Fjob"
                               )
                  )
                )
              ),
              fixedRow(
                column(
                  6,
                  plotOutput("educationPlot")
                ),
                column(
                  6,
                  plotOutput("jobPlot")
                )
              ),
              h4("Infomation From Students' Parents"),
              tags$ul(
                tags$li("Under this part we have the data about the parent's education and occupation.
                        For education, the 0 is none, 1 is primary education (4th grade), 2 is 5th to 9th grade, 
                        3 is secondary education, or 4 is higher education. For occupation, there are five 
                        big catagory 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 
                        'at_home' or 'other')."),
                tags$li("Children of uneducated mothers drank the most alcohol, followed by those of mothers with primary school education.
                        The effect of fathers' education on alcohol consumption was different.
                        The children of other educated fathers drank about the same amount of alcohol, 
                        except that the children of uneducated fathers drank the least."),
                tags$li("Students whose mothers were in the medical profession drank the least, and those whose fathers were teachers drank the least. 
                        The parents of the heaviest alcohol consumption's students were both in the services sector."),
                tags$li("As can be seen from the picture, the education level of the mother has a certain influence on the amount of alcohol students drink. 
                        The effect of fathers' education may be less pronounced. The influence of parents' occupation on students' alcohol consumption is obvious, 
                        among which students whose parents are engaged in medical treatment and education drink less alcohol. And students whose parents were serving 
                        drank the most, probably because they were busier."),
                h4("Conclusion & Analyze"),
                p("According to the latest statistics from the national institute on alcohol abuse and alcoholism (NIAAA), each year. In addition, alcohol causes 97,000 sexual assaults or date rapes each year, with an estimated 696,000 assaults.According to the NIH, The continuing influence of parents 
                  is an often overlooked factor. Studies show that students often abstain from alcohol because 
                  their parents discuss alcohol use and its negative consequences for them. And in these critical early stages, there are many things parents can do to 
                  stay engaged. "),
                h4("Outside Source"),
                a("https://www.niaaa.nih.gov/publications/brochures-and-fact-sheets/time-for-parents-discuss-risks-college-drinking" )
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
