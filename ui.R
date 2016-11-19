library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Analysis of Live Twitter Data on Elections"),
  sidebarLayout(position = "right",
                sidebarPanel(h4("Some of the tweets are: ", style = "color:brown"),
                             p(htmlOutput('text1')),
                             p(htmlOutput('text2')),
                             p(htmlOutput('text3')),
                             p(htmlOutput('text4')),
                             p(htmlOutput('text5'))),
    
  mainPanel(
    p(htmlOutput('trump_text')),
    p(htmlOutput('hillary_text')),
    p(htmlOutput('sanders_text')),
    plotOutput(outputId = "weeklyPlot", height = "300px"),
    plotOutput(outputId = "dailyPlot", height = "300px")
    
  )
  
)))
