# Read in data
data <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
data2 <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

merged_data <- rbind(data, data2, by = c("school"))

# Libraries
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(tidyr)
library(plotly)
# Create Visualization
# cleaned_data <- merged_data %>% select(Dalc, Walc, health, absences, famrel, failures, age, studytime)
# corr <- round(cor(cleaned_data), 1)
# p <- ggcorrplot(corr, hc.order = TRUE, type = "lower", lab = TRUE)
# ggsave("visualizations/heatmap.jpg", p)

# Gender and Age Visualization
needed_data <- merged_data %>% select(Walc, Dalc, sex, age) 
needed_data$Walc <- as.numeric(needed_data$Walc)
needed_data$Dalc <- as.numeric(needed_data$Dalc)
needed_data$age <- as.numeric(needed_data$age)


age_data <- needed_data %>% select(Dalc,age, sex) %>% group_by(sex, age) %>% summarize(avg_Dalc = mean(Dalc, na.rm = TRUE))
age_data <- age_data %>% filter(age != 'school')

spread_sex_walc <- age_data %>% spread(key = sex, value = avg_Dalc) %>% filter(age != 22)


# Histogram of totals
new_data <- needed_data %>% filter(age == 15)
ggplot(new_data, aes(x = Dalc)) + geom_histogram(binwidth = 1, fill = "lightblue") 
plot_ly(new_data, x = ~Dalc, type = 'histogram', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5)))
# ggplot(needed_data, aes(x = age)) + geom_histogram(binwidth = 1) 
# male_totals <- needed_data %>% select(Dalc, age, sex) %>% group_by(age, sex) %>% summarize()

# Bar graph 

ggplot(spread_sex_walc, aes(x = age, y = male)) + geom_bar(stat = "identity")

# Scatter Plot
spread_sex_walc <- spread_sex_walc %>% filter(age != 21)
colnames(spread_sex_walc)[2] <- 'female'
colnames(spread_sex_walc)[3] <- 'male'

spread_age_walc <- age_data %>% spread(key = age, value = avg_Dalc)

# Practice Plot
age_data$avg_Dalc <- round(age_data$avg_Dalc, digits = 2)
plot_ly(age_data %>% filter(sex == 'F'), x = ~age, y = ~avg_Dalc, type = 'bar', text = ~avg_Dalc, textposition = 'auto', marker = list(color = 'rgba(219, 64, 82, 0.7)', line = list(color = "orange", width = 1.5)))       


# Stacked Bar Chart
spread_sex_walc$female <- round(spread_sex_walc$female, digits = 2)
spread_sex_walc$male <- round(spread_sex_walc$male, digits = 2)
plot_ly(spread_sex_walc, x = ~age, y = ~female, type = 'bar', name = 'Female') %>% 
  add_trace(y = ~male, name = 'Male') %>% layout(yaxis = list(title = "Average Dalc"), xaxis = list(title = 'Age'), barmode = 'group', title = "Average Dalc For Each Age")

total_average_dalc <- needed_data %>% select(age, Dalc) %>% group_by(age) %>% summarize(avg_Dalc = mean(Dalc))
total_average_dalc$avg_Dalc <- round(total_average_dalc$avg_Dalc, digits = 2)
