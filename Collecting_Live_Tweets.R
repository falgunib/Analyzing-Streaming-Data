library(streamR)
library(ggplot2)
library(grid)
library(ROAuth)
library(dplyr)

load('~/my_oauth2.Rdata')
get_tweets = function() {
  tweets <- filterStream(file.name = "", track = c("Trump", "Hillary Clinton", "Obama","Elections","Bernie Sanders"), language = "en",timeout = 20, tweets = 150, oauth = my_oauth) # Use my_oauth file as the OAuth credentials

  
  if (length(tweets) >= 1) {
    #p1.df <- twListToDF(tweets)
    d <- parseTweets(tweets)
    p1 <- subset(d,, c(text))
  
    p1$Trump = 0
    p1$Hillary = 0
    p1$Sanders = 0
    for(i in 1: length(tweets)) {
      rr = toString(p1[i,]$text)
      rr
      if (grepl("Bernie",rr)) p1[i,]$Sanders = 1
      if (grepl("Sanders",rr)) p1[i,]$Sanders = 1
      if(grepl("Donald",rr)) p1[i,]$Trump = 1
      if(grepl("Trump",rr)) p1[i,]$Trump = 1
      if (grepl("Hillary",rr)) p1[i,]$Hillary = 1
      if (grepl("Clinton",rr)) p1[i,]$Hillary = 1
      
    }
    
    return(p1) 
  }
  else {
    
    return("No tweets found")
  }
}