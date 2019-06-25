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
library(leaflet)

shinyServer(function(input, output,session) {

    output$hist <- renderPlot({
        tweets %>%
            ggplot(aes(airline_sentiment))+
            geom_bar(fill = "tomato", color = "black")+
            labs(x = "Airline Sentiment", y = "Count")
    })
    output$over <- renderPlot({
    ggplot(tweets, aes(x = airline, fill = airline_sentiment)) +
        geom_bar() +
        scale_fill_discrete(name = 'Sentiment') +
        ggtitle("Sentiment vs Airline")
    })   
    output$yuan <- renderPlot({
    ggplot(tweets, aes(x = airline, fill = airline_sentiment)) +
        geom_bar(position = 'fill') +
        scale_fill_discrete(name = 'Sentiment') +
        coord_polar(theta = "y") +
        ggtitle("Pie chart: Sentiment vs Airline (persentage)")
        
    })
    output$air <- renderPlot({
        ggplot(tweets, aes(x = airline_sentiment, fill = airline_sentiment)) +
            geom_bar() +
            facet_grid(. ~ airline) +
            theme(axis.text.x = element_text(angle=65, vjust=0.6),
                  plot.margin = unit(c(3,0,3,0), "cm"))
    })
    output$one <- renderPlot({    
        ggplot(tweets, aes(x = airline, fill = airline_sentiment)) +
            geom_bar(position = 'fill') +
            scale_fill_discrete(name = 'Sentiment') +
            ggtitle("Sentiment vs Airline (persentage)")
    })
    output$six <- renderPlot({  
        ggplot(tweets, aes(x = '', fill = airline_sentiment)) +
            geom_bar(position = 'fill') +
            facet_wrap(~airline, nrow = 2) +
            scale_fill_discrete(name = 'Sentiment') +
            coord_polar(theta = "y") +
            labs(x = '', y = '') +
            ggtitle("Pie chart: Sentiment vs Airline (persentage)")
        
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

    
    output$AA <- renderPlot({    
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
        
        ##American wordcloud
        grouped_text %>% filter(airline == 'American')%>%
            anti_join(stop_words) %>%
            count(word) %>%
            with(wordcloud(word, n, max.words = 50))
        
    })   
    output$Delta <- renderPlot({ 
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
    grouped_text %>% filter(airline == 'Delta')%>%
        anti_join(stop_words) %>%
        count(word) %>%
        with(wordcloud(word, n, max.words = 50))
    }) 
    
    output$SW <- renderPlot({ 
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
        ##Southwest WordCloud
        grouped_text %>% filter(airline == 'Southwest')%>%
            anti_join(stop_words) %>%
            count(word) %>%
            with(wordcloud(word, n, max.words = 50))
    }) 
    
    output$UA <- renderPlot({ 
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
        ##United WordCloud
        grouped_text %>% filter(airline == 'United')%>%
            anti_join(stop_words) %>%
            count(word) %>%
            with(wordcloud(word, n, max.words = 50))
    }) 
    
    output$US <- renderPlot({ 
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
    grouped_text %>% filter(airline == 'US Airways')%>%
        anti_join(stop_words) %>%
        count(word) %>%
        with(wordcloud(word, n, max.words = 50))
    })
    
    output$VA <- renderPlot({ 
        sum(is.na(tweets$negativereason_confidence))
        mean(tweets$negativereason_confidence, na.rm=TRUE)
        
        by_negativereason_airline <- group_by(tweets,airline)
        categorized_negativereason_airline <- summarize (by_negativereason_airline,n=n(),
                                                         mn=mean(negativereason_confidence,na.rm = TRUE))
        categorized_negativereason_airline
        
        text_df <- data_frame(line = 1:nrow(tweets), airline=tweets$airline, text = tweets$text )
        
        text_df$text <- as.character(text_df$text)
        grouped_text <- unnest_tokens(text_df,word, text)
    ##Virgin America Word Cloud
    grouped_text %>% filter(airline == 'Virgin America')%>%
        anti_join(stop_words) %>%
        count(word) %>%
        with(wordcloud(word, n, max.words = 20))
    })
    
    output$MAPS <- renderPlot({ 
    ggplot()+
        geom_polygon(data = world_map, aes(x = long, y = lat, group = group), colour="black", fill = 'lightblue')+ 
        ggtitle("Location of tweets across the World")+
        geom_point(data = location_2, aes(x = long, y = lat, size = n), color="coral1") + scale_size(name="Total Tweets")
    })
    
    
    
    output$playertable <- DT::renderDataTable(DT::datatable({
        Comments
    })) 
    
    })

