# Read in data
data <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
data2 <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

# Libraries
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(tidyr)

# Create Visualization
cleaned_data <- data2 %>% select(Dalc, Walc, health, absences, famrel, failures, age, studytime)
corr <- round(cor(cleaned_data), 1)
ggcorrplot(corr, hc.order = TRUE, type = "lower", lab = TRUE)

# Gender Visualization
sex_data <- data2 %>% select(Walc, Dalc, sex)
female_data <- sex_data %>% filter(sex == 'F')
male_data <- sex_data %>% filter(sex == 'M')
sex_data_spread <- spread(sex_data, key = sex, value = Walc)

