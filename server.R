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

shinyServer(function(input, output,session) {

    output$hist <- renderPlot({
        tweets %>%
            ggplot(aes(airline_sentiment))+
            geom_bar(fill = "tomato", color = "black")+
            labs(x = "Airline Sentiment", y = "Count")
    })

    output$air <- renderPlot({
        ggplot(tweets, aes(x = airline_sentiment, fill = airline_sentiment)) +
            geom_bar() +
            facet_grid(. ~ airline) +
            theme(axis.text.x = element_text(angle=65, vjust=0.6),
                  plot.margin = unit(c(3,0,3,0), "cm"))
        
    })
    output$reason <- renderPlot({
        tweets %>%
            filter(!is.na(negativereason)) %>%
            count(airline, negativereason) %>%
            ggplot(aes(negativereason, n))+
            geom_bar(stat = "identity", colour = "grey19", fill = "springgreen4")+
            facet_wrap(~airline, ncol = 3)+
            theme(axis.text.x = element_text(angle = 30, hjust = 1, size = 9))+
            labs(x = "Negative Reasons", y = "Count of Negative Reasons")
    })       
    
    output$reason <- renderPlot({
        tweets %>%
            filter(!is.na(negativereason)) %>%
            count(airline, negativereason) %>%
            ggplot(aes(negativereason, n))+
            geom_bar(stat = "identity", colour = "grey19", fill = "springgreen4")+
            facet_wrap(~airline, ncol = 3)+
            theme(axis.text.x = element_text(angle = 30, hjust = 1, size = 9))+
            labs(x = "Negative Reasons", y = "Count of Negative Reasons")
    }) 
    
    output$negative <- renderPlot({    
        tweets %>%
            filter(!is.na(negativereason)) %>%
            count(airline, negativereason) %>%
            ggplot(aes(airline, negativereason))+
            geom_tile(aes(fill = n))
    })   

    
    output$playertable <- DT::renderDataTable(DT::datatable({
        Comments
    })) 
    
    })

