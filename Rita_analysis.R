library("plotly")
library("shiny")
library("ggplot2")
library("styler")
library("lintr")
library(sunburstR)
library(reshape)

## the background bar chart##
# Process and Store Data

d1 <- data.table::fread("data/student-mat.csv", header = TRUE)
d2 <- data.table::fread("data/student-por.csv", header = TRUE)
d3 <- merge(d1, d2, by = c("school", "sex", "age", "address", "famsize", "Pstatus",
                           "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet",
                           "famrel", "goout", "absences", "failures"))

background.data <- bind_rows(d1, d2) %>% select(address, famsize, famrel, 
                                                Medu, Fedu, Mjob, Fjob, guardian,
                                                Dalc, Walc)
background.data$alc <- (background.data$Dalc + background.data$Walc)/2
background.data <- background.data %>% select(address, famsize, famrel, 
                                              Medu, Fedu, Mjob, Fjob, guardian, alc)

sex.guardian <- bind_rows(d1, d2) %>% select(sex, Dalc, Walc, guardian)
sex.guardian$alc <- (sex.guardian$Dalc + sex.guardian$Walc)/2
sex.guardian <- sex.guardian %>%  select(sex, alc, guardian) %>%  
  group_by(sex, guardian) %>% summarise(mean(alc)) 
colnames(sex.guardian) <- c("sex", "guardian", "alc")

sex.guardian.f <- sex.guardian %>% filter(sex == "F")
sex.guardian.m <- sex.guardian %>% filter(sex == "M")
  
## address
address.data <- data.frame(background.data$address, background.data$alc) %>% 
  group_by(background.data.address) %>% summarise(alc = mean(background.data.alc))
colnames(address.data) <- c("address", "alc")
address.data$address <- c("Rural", "Urban")


## family size
famsize.data <- data.frame(background.data$famsize, background.data$alc) %>% 
  group_by(background.data.famsize) %>% summarise(alc = mean(background.data.alc))
colnames(famsize.data) <- c("family.size", "alc")
famsize.data$family.size <- c("great_than_3", "less_then_3")



##family relationship
famrel.data <- data.frame(background.data$famrel, background.data$alc) %>% 
  group_by(background.data.famrel) %>% summarise(alc = mean(background.data.alc))
colnames(famrel.data) <- c("family.relationship", "alc")





##guardian
guardian.data <- data.frame(background.data$guardian, background.data$alc)%>% 
  group_by(background.data.guardian) %>% summarise(alc = mean(background.data.alc))
colnames(guardian.data) <- c("guardian", "alc")


# sun <- plot_ly(
#   labels = c("address", "family size", "family relationship", 
#              "Mother education", "Father Education", "Mother's job", "Father's job", "guardian"),
#   parents = c("Background Info", "Background Info", "Background Info", 
#               "Parent Info", "Parent Info", "Parent Info", "Parent Info", "Background Info"),
#   values = c(10,10,10,10,10,10,10,10),
#   type = "sunburst"
# )



#####################################part two################################


##Mother's education
Medu.data <- data.frame(background.data$Medu, background.data$alc) %>% 
  group_by(background.data.Medu) %>% summarise(alc = mean(background.data.alc))
colnames(Medu.data) <- c("Medu", "alc")
Medu.data <- melt(Medu.data, id="alc")
Medu.data$alc <- round(Medu.data$alc, digits = 4)

##Father"s education
Fedu.data <- data.frame(background.data$Fedu, background.data$alc) %>% 
  group_by(background.data.Fedu) %>% summarise(alc = mean(background.data.alc))
colnames(Fedu.data) <- c("Fedu", "alc")
Fedu.data <- melt(Fedu.data, id="alc")
Fedu.data$alc <- round(Fedu.data$alc, digits = 4)


##Mother's job
Mjob.data <- data.frame(background.data$Mjob, background.data$alc) %>% 
  group_by(background.data.Mjob) %>% summarise(alc = mean(background.data.alc))
colnames(Mjob.data) <- c("Mjob", "alc")
Mjob.data <- melt(Mjob.data, id = "alc")
Mjob.data$alc <- round(Mjob.data$alc, digits = 4)

##father's job
Fjob.data <- data.frame(background.data$Fjob, background.data$alc) %>% 
  group_by(background.data.Fjob) %>% summarise(alc = mean(background.data.alc))
colnames(Fjob.data) <- c("Fjob", "alc")
Fjob.data <- melt(Fjob.data, id = "alc")
Fjob.data$alc <- round(Fjob.data$alc, digits = 4)

## parents info
parent.edu <- bind_rows(Medu.data, Fedu.data)
parent.job <- bind_rows(Fjob.data, Mjob.data)



