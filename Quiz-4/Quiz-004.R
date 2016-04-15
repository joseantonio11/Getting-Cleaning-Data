## QUIZ 4 - Getting and Cleaning Data - Coursera

## QUESTION 1
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileURL, destfile = "./data/PUMSDataDict06.pdf")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileURL, destfile = "./data/microdata-survey-2006.csv", method = "cur")
list.files("./data")
# reading data
dados <- read.csv("./data/microdata-survey-2006.csv")
dados
varNamesSplit <- strsplit(names(dados), "wgtp")
varNamesSplit
varNamesSplit[[123]]
## "" "15"

## QUESTION 2
library(data.table)
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, destfile = "./data/FGDP.csv")
list.files("./data")
##
dadosFGDP <- data.table(read.csv("./data/FGDP.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE))
dadosFGDP
dadosFGDP <- dadosFGDP[X != ""]
dadosFGDP
dadosFGDP <- dadosFGDP[, list(X, X.1, X.3, X.4)]
dadosFGDP
setnames(dadosFGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
dadosFGDP
gdp <- as.numeric(gsub(",", "", dadosFGDP$gdp))
mean(gdp, na.rm = TRUE)
## 377652.4

#### QUESTION 3
isUnited <- grepl("^United",dadosFGDP$Long.Name)
summary(isUnited)
## grep("^United", countryNames), 3

## QUESTION 4
library(data.table)
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, destfile = "./data/FGDP.csv")
dadosFGDP <- data.table(read.csv("./data/FGDP.csv"))
dadosFGDP
dadosFGDP <- dadosFGDP[, list(X, X.1, X.3, X.4)]
setnames(dadosFGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
dadosFGDP
dadosFGDP
list.files("./data")
##
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
download.file(fileURL, destfile = "./data/FEDSTATS.csv")
dadosFEDSTAT <- data.table(read.csv("./data/FEDSTATS.csv"))
list.files("./data")
dadosFEDSTAT
## 
mergeDados <- merge(dadosFGDP, dadosFEDSTAT, all = TRUE, by = c("CountryCode"))
mergeDados
isFiscalYearEnd <- grepl("fiscal year end", tolower(mergeDados$Special.Notes))
isJune <- grepl("june", tolower(mergeDados$Special.Notes))
table(isFiscalYearEnd, isJune)
## 13

## QUESTION 5
library(quantmod)
amazon = getSymbols("AMZN", auto.assign=FALSE)
amazon
sampleTimes = index(amazon)
sampleTimes
margins <- addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
margins
## 250,47
                       
                       
                       