## QUIZ 4 - Getting and Cleaning Data - Coursera

## QUESTION 1
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileURL, destfile = "./data/PUMSDataDict06.pdf")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileURL, destfile = "./data/microdata-survey-2006.csv", method = "cur")
list.files("./data")
## reading data
dados <- read.csv("./data/microdata-survey-2006.csv")
dados
agricultureLogical <- dados$ACR == 3 & dados$AGS == 6
which(agricultureLogical)[1:3]
## 125  238  262

## QUESTION 2
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" 
download.file(fileURL, destfile = "./data/jeff-leek.jpg", mode = "wb", method = "curl")
list.files("./data")
picture <- readJPEG("./data/jeff-leek.jpg", native = TRUE)
quantile(picture, probs = c(0.3, 0.8))
## -15259150 -10575416 

## QUESTION 3
library(data.table)
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, destfile = "./data/FGDP.csv")
list.files("./data")
dadosFGDP <- data.table(read.csv("./data/FGDP.csv", skip = 4, nrows = 215))
dadosFGDP
dadosFGDP <- dadosFGDP[X != ""]
dadosFGDP
dadosFGDP <- dadosFGDP[, list(X, X.1, X.3, X.4)]
dadosFGDP
setnames(dadosFGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
dadosFGDP

## dados FESTAT
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
download.file(fileURL, destfile = "./data/FEDSTATS.csv", method = "cur")
dadosFEDSTAT <- data.table(read.csv("./data/FEDSTATS.csv"))
list.files("./data")
dadosFEDSTAT
## merge
dadosMerged <- merge(dadosFGDP, dadosFEDSTAT, all=TRUE, by = c("CountryCode"))
dadosMerged
sum(!is.na(unique(dadosMerged$rankingGDP)))
## 189 
dadosMerged[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]
## St. Kitts and Nevis GDP (ranking GDP 178 e GDP 767)

## QUESTION 4
dadosMerged[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]
## 32.96667, 91.91304

## QUESTION 5
quebra <- quantile(dadosMerged$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
quebra
dadosMerged$quantileGDP <- cut(dadosMerged$rankingGDP, breaks = quebra)
dadosMerged[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]
## 5

