install.packages("streamR")
install.packages("ROAuth")
library(streamR) 
library(RCurl) 
library(RJSONIO) 
library(stringr)
# PART 1: Declare Twitter API Credentials & Create Handshake
library(ROAuth)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "rLRzWovMR2lGDrw4gQywpCYi2" # From dev.twitter.com
consumerSecret <- "XEjkkB2qiOaGeKwDTFcFUaSwSk0ALTk8QNIRKGklbm1Eosk9oR" # From dev.twitter.com

my_oauth <- OAuthFactory$new(consumerKey = consumerKey, consumerSecret = consumerSecret,requestURL = requestURL, accessURL = accessURL, authURL = authURL)

my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))



7# PART 2: Save the my_oauth data to an .Rdata file
save(my_oauth, file = "my_oauth2.Rdata")
