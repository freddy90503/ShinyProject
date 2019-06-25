library(DT)
library(shiny)
library(googleVis)
library(dplyr)
library(tidytext)
library(RColorBrewer)
library(ggplot2)
library(wordcloud)
library(tm)
library(tidyverse)
library(plotly)
library(maps)
library(rbokeh)
library(widgetframe)
library(htmlwidgets)

# convert matrix to dataframe
state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
rownames(state_stat) <- NULL
# create variable with colnames as choice
choice <- colnames(state_stat)[-1]

tweets = read.csv("./Tweets.csv")

location = tweets$tweet_coord
location = location[!is.na(location)]
location = as_tibble(location)
location = select(location, location = value)
location$location = as.character(location$location)
location_2 <- location %>%
  filter(location != "[0.0, 0.0]") %>%
  count(location)
location_coords = strsplit(location_2$location, ',')

lat = NULL
long = NULL
for (i in 1:length(location_coords)) {
  lat = c(lat, substring(location_coords[[i]][1], 2)) # removes first character which is [
  long = c(long, location_coords[[i]][2]) 
}

location_2$lat <- lat
location_2$long = long
location_2$long = substr(location_2$long, 1, nchar(location_2$long)-1)

location_2$lat = as.numeric(location_2$lat)
location_2$long = as.numeric(location_2$long)
options(repr.plot.width = 10, repr.plot.height = 7)
require(maps)
world_map <- map_data("world")