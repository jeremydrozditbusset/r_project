# PART 1

# READ DATA
survey <- read.csv("~/Desktop/Jérémy/Foundations of Data Science/Project 1/survey.csv")

View(survey)

# COUNT NUMBER OF PARTICIPANTS

dim(survey)

nrow(survey)

ncol(survey)

## There is 30 participants

# REVIEWING THE TYPE OF DATA FOR EACH TITLE

str(survey)

## So we read that x is integer, University is character, Position is character...

# TOP 3 UNIVERSITY

library(tidyverse)

survey %>%
  count(University) %>%
  top_n(n =3) %>%
  arrange(desc(n))

## So here we can read that the top 3 are : Delft University of Technology 9,
## Eindhoven University of Technology 7, University of Groningen 6





# PART 2

# BAR PLOT

ggplot(data=survey, mapping=aes(y=Position))+
         geom_bar()+
  labs(title="Number of survey participant by position", subtitle="Postdoc and PhD Student are the top 2")

# Same but using coord_flip

ggplot(data=survey, mapping=aes(x=Position))+
  geom_bar()+coord_flip()+
  labs(title="Number of survey participant by position", subtitle="Postdoc and PhD Student are the top 2")





# PART 3

survey$Sizes=cut(survey$Number.of.employees, breaks =c(-Inf, 20, 50, 200, Inf), label =c("Small(0 to 20)", "Medium(21 to 50)", "Large(51 to 200)","Extra Large(Over 200)"))

ggplot(data=survey, mapping=aes(x=Sizes))+
  geom_bar()+
  labs(title="Number of survey participant by size of their group", subtitle="Most commun group size among participants was Small")




# PART 4

survey2<- data.frame(    survey_id=survey$X,
                    percent_of_phd=round((survey$Number.of.PhD.students/survey$Number.of.employees)*100,1),
                    percent_of_postdocs=round((survey$Number.of.postdocs/survey$Number.of.employees)*100,1),
                    percent_of_prof=round((survey$Number.of.professors/survey$Number.of.employees)*100,1)    )


survey3<-pivot_longer(
  survey2,
  c(2,3,4),
  names_to = "Categories",
  values_to = "Percentage")


ggplot(data=survey3, mapping=aes(x=factor(survey_id), y=Percentage, fill=Categories))+
  geom_col()+coord_flip()+
  labs(x="Research group id", title="Employees role percentages for each group", subtitle="Results are actually really differents for each groups")+
  scale_x_discrete()

