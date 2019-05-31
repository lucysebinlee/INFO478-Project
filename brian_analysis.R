# Read in data
data <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
data2 <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

# Libraries
library(dplyr)
library(ggplot2)
library(ggcorrplot)
library(tidyr)


d <- merge(data, data2, by = c("school", "sex", "age", "address", "famsize", "Pstatus", 
                            "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet"))
absences <- select(d, absences.x, Dalc.y)
abs_plot <- ggplot(absences, aes(x = Dalc.y, y = absences.x)) + geom_bar(stat="identity") +
  xlab("Daily Alcohol Consumption") +
  ylab("Absences") +
  ggtitle("Absences vs. Alcohol Consumption")
