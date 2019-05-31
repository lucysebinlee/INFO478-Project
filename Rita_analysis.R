library(dplyr)
library(plotly)
library("shiny")
library("ggplot2")
library("styler")
library("lintr")

## the background bar chart##
source("server.R")
background.data <- bind_rows(d1, d2) %>% select(address, famsize, famrel, 
                                                Medu, Fedu, Mjob, Fjob, guardian,
                                                Dalc, Walc)
background.data$alc <- (background.data$Dalc + background.data$Walc)/2
background.data <- background.data %>% select(address, famsize, famrel, 
                          Medu, Fedu, Mjob, Fjob, guardian, alc)
## address
address.data <- data.frame(background.data$address, background.data$alc) %>% 
  group_by(background.data.address) %>% summarise(alc = sum(background.data.alc))
## family size
famsize.data <- data.frame(background.data$famsize, background.data$alc) %>% 
  group_by(background.data.famsize) %>% summarise(alc = sum(background.data.alc))
##family relationship
famrel.data <- data.frame(background.data$famrel, background.data$alc) %>% 
  group_by(background.data.famrel) %>% summarise(alc = sum(background.data.alc))
##Mother's education
Medu.data <- data.frame(background.data$Medu, background.data$alc) %>% 
  group_by(background.data.Medu) %>% summarise(alc = sum(background.data.alc))
##Father"s education
Fedu.data <- data.frame(background.data$Fedu, background.data$alc) %>% 
  group_by(background.data.Fedu) %>% summarise(alc = sum(background.data.alc))
##Mother's job
Mjob.data <- data.frame(background.data$Mjob, background.data$alc) %>% 
  group_by(background.data.Mjob) %>% summarise(alc = sum(background.data.alc))
colnames(Mjob.data) <- c("Mjob", "alc")
##father's job
Fjob.data <- data.frame(background.data$Fjob, background.data$alc) %>% 
  group_by(background.data.Fjob) %>% summarise(alc = sum(background.data.alc))
colnames(Fjob.data) <- c("Fjob", "alc")
Fjob.melt <- melt(Fjob.data, variable.name = "Fjob", value.name = "alc")
##guardian
guardian.data <- data.frame(background.data$guardian, background.data$alc)%>% 
  group_by(background.data.guardian) %>% summarise(alc = sum(background.data.alc))

##parent job
Pjob <- left_join(Mjob.data, Fjob.data, by = "alc")


g <- ggplot(Fjob.data, aes(Fjob.data$Fjob, alc))
g + geom_bar(stat="identity", width = 0.5, fill="tomato2") + 
  labs(title="Bar Chart", 
       subtitle="Father's job VS Alcohol consumption" 
       ) +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))
