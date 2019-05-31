# Workbook 8: Independent Exploration of Final Project Data

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
d2 = data.table::fread("data/student-por.csv", header = TRUE)
d3 = merge(d1, d2, by = c("school", "sex", "age", "address", "famsize", "Pstatus", 
                          "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet"))
print(nrow(d3)) # 382 students

# Grades vs. Alcohol Consumption
grades <- select(d3, G1.y, G2.y, G3.y, Dalc.y)

# Plots of Grades vs. Alcohol Consumption
grades_1 <- ggplot(d3, aes(x = Dalc.y, y = G1.y, group = Dalc.y)) +
  geom_boxplot(fill = "#FF7F50", lwd = 0.8) +
  theme(legend.position = "none") +
  scale_y_continuous(limits = c(0, 20)) +
  xlab("Daily Alcohol Consumption") +
  ylab("First Period Grades") +
  ggtitle("First Period Grades vs. Alcohol Consumption")

grades_2 <- ggplot(d3, aes(x = Dalc.y, y = G2.y, group = Dalc.y)) +
  geom_boxplot(fill = "#FF6347", lwd = 0.8) +
  theme(legend.position = "none") +
  scale_y_continuous(limits = c(0, 20)) +
  xlab("Daily Alcohol Consumption") +
  ylab("Second Period Grades") +
  ggtitle("Second Period Grades vs. Alcohol Consumption")

grades_3 <- ggplot(d3, aes(x = Dalc.y, y = G3.y, group = Dalc.y)) +
  geom_boxplot(fill = "#CD5C5C", lwd = 0.8) +
  theme(legend.position = "none") +
  scale_y_continuous(limits = c(0, 20)) +
  xlab("Daily Alcohol Consumption") +
  ylab("Final Period Grades") +
  ggtitle("Final Period Grades vs. Alcohol Consumption")

grades_all <- ggarrange(grades_1, grades_2, grades_3, ncol = 1, nrow = 3) +
  ggsave("grades.png", width = 7, height = 13)
