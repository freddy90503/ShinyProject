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
