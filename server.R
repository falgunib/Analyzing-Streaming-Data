library(shiny)
library(doBy)
source('Collecting_Live_Tweets.R')

dat_all_name = paste0('dat_all_', format(Sys.time(), '%Y-%m-%d_%H-%M-%S'), '.RData')

shinyServer(function(input, output, session) {
  autoInvalidate = reactiveTimer(1000, session)
  get_input = reactive({
    autoInvalidate()
    get_tweets()
  })
  
  observe({
    
    dat = get_input()
    #file already created so append
    if (file.exists(file = dat_all_name)) {
      load(file = dat_all_name)
      #if so, append after the existing file
      dat_all = rbind(dat_all, dat)
    }
    else {
      #load previous dataset and append to it
      p1 <- read.csv("saveddfwithwho1.csv")
      p1 <- subset(p1,, -c(X))
      
      colnames(p1)
      dat_all = rbind(p1,dat)
      
    }
    save(dat_all, file = dat_all_name)
    #computation for statistics start
    stats <- function(x){c(length = length(x))} 
    abc = summaryBy(text~Trump, data=dat_all, FUN=stats)
    dt = paste("Donald Trump was mentioned",abc[2,2],"times")
    pqr = summaryBy(text~Hillary, data=dat_all, FUN=stats)
    hc = paste("Hillary Clinton was mentioned",pqr[2,2],"times")
    xyz = summaryBy(text~Sanders, data=dat_all, FUN=stats)
    bs = paste("Bernie Sanders was mentioned",xyz[2,2],"times")
    abc1 = summaryBy(text~Trump, data=dat, FUN=stats)
    pqr1 = summaryBy(text~Hillary, data=dat, FUN=stats)
    xyz1 = summaryBy(text~Sanders, data=dat, FUN=stats)
    
    g = sample(dat$text,1)
    h = sample(dat$text,1)
    i = sample(dat$text,1)
    j = sample(dat$text,1)
    k = sample(dat$text,1)
    lmn <- c(abc[2,2],pqr[2,2],xyz[2,2]) #weekly data
    def <- c(abc1[2,2],pqr1[2,2],xyz1[2,2]) #Daily data
   
    
    output$weeklyPlot <- renderPlot({
      barplot(lmn, main="Who is Popular This Week", ylab = "Number of Mentions in tweets", names.arg=c("Donald Trump","Hillary Clinton","Bernie Sanders"), col="blue")
 
    })
    output$dailyPlot <- renderPlot({
      barplot(def, main="Who is Trending On Twitter Right Now", ylab = "Number of Mentions in tweets", names.arg=c("Donald Trump","Hillary Clinton","Bernie Sanders"), col="red")
      
    })
    
    output$trump_text = renderUI({
      print(dt)
        HTML('<h3>', dt, '<br>')
      
    }) 
    output$hillary_text = renderUI({
      print (hc)
      HTML('<h3>', hc, '<br>')
      
    }) 
    output$sanders_text = renderUI({
      print(bs)
      HTML('<h3>', bs, '<br>')
      
    }) 
    output$text1 <- renderUI({ 
      
      HTML('<h5>', g, '<br>')
    })
    output$text2 <- renderUI({ 
      print(h)
      HTML('<h5>', h, '<br>')
    })
    output$text3 <- renderUI({ 
      print(i)
      HTML('<h5>', i, '<br>')
    })
    output$text4 <- renderUI({ 
      print(j)
      HTML('<h5>', j, '<br>')
    })
    output$text5 <- renderUI({ 
      print(k)
      HTML('<h5>', k, '<br>')
    })
  
  })
})