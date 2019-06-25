library(DT)
library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(skin = ("yellow"),
                      dashboardHeader(title = strong("US Airlines Review from Twitter"), titleWidth = 500),
                      dashboardSidebar(
                          
                          sidebarUserPanel("Fred Zeng",
                                           image = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTynYoNJQfHvOFZ_nxA2YAAuXN1WA4SgUIo7rQlVTUPTDqP7YDX"),
                          sidebarMenu(
                              menuItem("Introduction", tabName = "Introduction", icon = icon("database")),
                              menuItem("Overall", tabName = "Overall", icon = icon("map")),
                              menuItem("Airlines", tabName = "Airlines", icon = icon("map")),
                              menuItem("Words", tabName = "Words", icon = icon("database")),
                              menuItem("Map", tabName = "Map", icon = icon("database")),
                              menuItem("Data", tabName = "Data", icon = icon("database"))
                              
                          )
                      ),
                      dashboardBody(
                          tags$head(
                              tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                          ),
                          tabItems(
                              tabItem(tabName = "Introduction",
                                      fluidRow(
                                          box(tags$h4('Kaggle'), height = 100),
                                          box(tags$h4('February 2015'), height = 100),
                                          box(tags$h4('14,640 rows'), height = 100),
                                          box(tags$h4('15 columns'), height = 100),
                                          box(tags$h4('6 Airlines'), height = 100),
                                          box(tags$h4('Reviews on Twitter'), height = 100),
                                          box(tags$h4('With comments'), height = 100),
                                          box(tags$h4('3 Levels Rating'), height = 100)
                                          
                                      )),
                              tabItem(tabName = "Overall",
                                      fluidRow(
                                          box(width = 12, plotOutput("hist"),height = 420, background = "black"),
                                          box(width = 12, plotOutput("over"),height = 420, background = "black"),
                                          box(width = 12, plotOutput("yuan"),height = 420, background = "black")
                                      )),
                              tabItem(tabName = "Airlines",
                                      fluidRow(
                                          box(width = 12, plotOutput("air"),height = 420, background = "black"),
                                          box(width = 12, plotOutput("one"),height = 420, background = "black"),
                                          box(width = 12, plotOutput("six"),height = 420, background = "black")
                              )),
                              tabItem(tabName = "Words",
                                      fluidRow(
                                          box(width = 12, plotOutput("reason"), height = 420, background = "black"),
                                          box(width = 12, plotOutput("negative"), height = 420, background = "black"),
                                          box(plotOutput("AA"), height = 420, background = "black"),
                                          box(plotOutput("SW"), height = 420, background = "black"),
                                          box(plotOutput("UA"), height = 420, background = "black"),
                                          box(plotOutput("US"), height = 420, background = "black"),
                                          box(plotOutput("VA"), height = 420, background = "black"),
                                          box(plotOutput("Delta"), height = 420, background = "black")
                                          
                                      )),
                              tabItem(tabName = "Map",
                                      fluidRow(
                                        box(width = 12, plotOutput("MAPS"),height = 420, background = "black")
                                      )),
                              tabItem(tabName = "Data",
                                      fluidRow(DT::dataTableOutput("playertable")))
                              
                          ))
                      
)
)