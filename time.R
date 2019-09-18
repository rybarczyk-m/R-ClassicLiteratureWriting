library(readr)

titles <- read.csv("data/titles.csv")
stats <- read.csv("data/stats.csv")

library(dplyr)

books <- full_join(titles, stats,by = "id")
  
dickens <- filter(books, str_detect(author, 'Dickens'))
dickens_stats<- dickens %>% select(id, words, sentences, to_be_verbs, contractions, pauses, cliches, similes)

library(tidyr)

published <- read.csv("data/published.csv")

time <- full_join(dickens_stats, published)

time_long <-gather(time, type, value, words:similes)
library(ggplot2)
p <- ggplot(time_long, aes(year, value, color=type))+ geom_line()

plot(p)
