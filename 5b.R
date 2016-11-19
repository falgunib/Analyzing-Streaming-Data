library(ggplot2)
require(gdata)
library(doBy)
Sys.setlocale('LC_ALL','C') 

p <- read.csv("saveddf.csv")
p1 <- subset(p,, c(text))

colnames(p1)
p1$Trump = 0
p1$Hillary = 0
p1$Sanders = 0
for (i in 1:30500) {
  rr = toString(p1[i,]$text)
  rr
  if (grepl("Bernie",rr)) p1[i,]$Sanders = 1
  if (grepl("Sanders",rr)) p1[i,]$Sanders = 1
  if (grepl("bernie",rr)) p1[i,]$Sanders = 1
  if (grepl("sanders",rr)) p1[i,]$Sanders = 1
  if (grepl("BERNIE",rr)) p1[i,]$Sanders = 1
  if (grepl("SANDERS",rr)) p1[i,]$Sanders = 1
  if(grepl("Donald",rr)) p1[i,]$Trump = 1
  if(grepl("Trump",rr)) p1[i,]$Trump = 1
  if(grepl("donald",rr)) p1[i,]$Trump = 1
  if(grepl("trump",rr)) p1[i,]$Trump = 1
  if(grepl("DONALD",rr)) p1[i,]$Trump = 1
  if(grepl("TRUMP",rr)) p1[i,]$Trump = 1
  
  if (grepl("Hillary",rr)) p1[i,]$Hillary = 1
  if (grepl("Clinton",rr)) p1[i,]$Hillary = 1
  if (grepl("hillary",rr)) p1[i,]$Hillary = 1
  if (grepl("clinton",rr)) p1[i,]$Hillary = 1
  if (grepl("HILLARY",rr)) p1[i,]$Hillary = 1
  if (grepl("CLINTON",rr)) p1[i,]$Hillary = 1
  
}

write.csv(p1, file = "saveddfwithwho1.csv")
l = 30500
p1.trump <- p1[p1$Trump!=0,]
p1.h <- p1[p1$Hillary!=0,]
p1.s<- p1[p1$Sanders!=0,]

ggplot(p1.h, aes(x=Trump)) + geom_density()

ggplot(p1.s, aes(x=Trump)) + geom_density()
ggplot(p1.trump, aes(x=Trump)) + geom_density()

plot(p1.trump$Trump,p1.trump$retweetCount, type = "l")
lines(p1.s,p1.trump$retweetCount,col="green")
hist(p1.trump$Trump)
hist(p1$Hillary)
hist(p1$Sanders)
stats <- function(x){c(length = length(x))} 
abc = summaryBy(text~Trump, data=p1, FUN=stats)
abc
abc = summaryBy(text~Trump, data=dat_all, FUN=stats)
dt = paste("Donald Trump was mentioned",abc[2],"times")
summaryBy(text~Hillary, data=p1, FUN=stats)
summaryBy(text~Sanders, data=p1, FUN=stats)

ggplot(data=p1, aes(x=Trump, y=Hillary, fill=retweetCount)) + geom_bar(stat="identity") + theme_bw()
