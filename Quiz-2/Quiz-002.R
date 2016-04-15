## Quiz 2 - Gettint and Cleaning Data - Coursera

## QUESTION 1
library(httr)
require(httpuv)
require(jsonlite)
oauth_endpoints("github")
myapp1 <- oauth_app("github", key = "835d9f0513d04e7c9c28", secret = "56915be68ba07bcd47f804cb5eb0b5750863df58")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp1)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"), gtoken)
stop_for_status(req)
content(req)
# 2013-11-07T13:25:07Z 


## QUESTION 2 
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "./data/community-survey.csv", method = "cur")
list.files("./data")
install.packages("sqldf")
library(sqldf)
acs <- read.csv("./data/community-survey.csv", header = TRUE, sep = ",")
query-001 <- sqldf("select pwgtp1 from acs where AGEP < 50")

query-002 <- sqldf("select pwgtp1 from acs") # 
query-003 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")
query-004 <- sqldf("select * from acs where AGEP < 50")

## QUESTION 3
sqldf("select distinct AGEP from acs")
length(unique(acs$AGEP))
# 91

## QUESTION 4
purl <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(purl)
htmlCode <- readLines(con)
htmlCode
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)
## 45  31  7 25

## QUESTION 5 
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileURL, destfile = "./data/indices.for")
list.files("./data")
dados <- read.csv("./data/indices.for", header = TRUE)
head(dados)
dim(data)
df <- read.fwf("./data/indices.for", widths = c(-1,9,-5,4,4,-5,4,4,-5,4,4, -5,4,4), skip = 4)
head(df)
sum(df[, 4])
## 32426.7
