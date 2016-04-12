## Question 1 Quiz 1 - Course Getting and Cleaning Data - Coursera
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileURL, destfile = "./data/PUMSDataDict06.pdf")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileURL, destfile = "./data/ss06hid.csv", method = "cur")
list.files("./data")
## how many properties are worth R$ 1.0000,00 or more
datahouse <- read.table("./data/ss06hid.csv", sep = ",", header=TRUE)
head(datahouse)
sum(!is.na(datahouse$VAL[datahouse$VAL ==24]))
53

############################################## Question 2
datahouse <- read.table("./data/ss06hid.csv", sep = ",", header=TRUE)
datahouse$FES
## one variable per column

######################## Question 3
## Question 3 Quiz 1
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
download.file(fileURL, destfile = "./data/data-govern.xlsx", method = "curl")
list.files("./data")
dateDownloaded <- date()
## reading 
library(xlsx)
rows <- 18:23
cols <- 7:15
dat <- read.xlsx("./data/data-govern.xlsx", 1, colIndex=cols, rowIndex=rows)
sum(dat$Zip*dat$Ext,na.rm = TRUE)
36534720

######################## Question 4
## Question 4 Quiz 1
library(XML)
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileURL, destfile = "./data/restaurantes.xml")
list.files("./data")
## 
doc <- xmlTreeParse("./data/restaurantes.xml",useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
names(rootNode)
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)
127 

### test de arquivos XML - file restaurants.xml n??o reconhecido como XML.
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
names(rootNode)


################# Question 5
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" 
download.file(fileURL, destfile = "./data/microdata-2006.csv", method = "cur")
list.files("./data")
file.info("./data/microdata-2006.csv")$size
## Fread()
DT <- fread("./data/microdata-2006.csv")
##### 
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2])

