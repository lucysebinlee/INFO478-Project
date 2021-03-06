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

dmat <- read.csv('data/student-mat.csv', stringsAsFactors = FALSE)
dpor <- read.csv('data/student-por.csv', stringsAsFactors = FALSE)

ggplot(test, aes(x = famrel, y = meanDalc)) + geom_bar(stat = 'identity')

ggplot(dmat, aes(x = G1, y = Dalc, fill = age)) + geom_point()


test <- dmat %>%
  select(age, Dalc, famrel) %>%
  group_by(famrel) %>%
  summarise(meanDalc = mean(Dalc))

