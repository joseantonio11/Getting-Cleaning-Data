## Week 3 - Study - Getting and Cleaning Data - Coursera

## Subsetting - quick review
set.seed(13435)
x <- data.frame("var1" = sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA
x
x[,1]
x[,"var1"]
x[1:2,"var2"]

## logicals ands and ors
x[(x$var1 <=3 & x$var3 > 11),]
x[(x$var1 <= 3 | x$var > 15),]

## dealing with missing values 
x[which(x$var2 > 8),]
x

## sorting
sort(x$var1)
sort(x$var1, decreasing = TRUE)
sort(x$var2, na.last = TRUE)

## ordering
x[order(x$var1),]
x[order(x$var1, x$var3),]

## ordering with plyr
library(plyr)
arrange(x,var1)
arrange(x, desc(var1))

## adding rows and columns
x$var4 <- rnorm(5)
x
y <- cbind(x, rnorm(5))
y

## summarizing data
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
list.files("./data")
restData <- read.csv("./data/restaurants.csv")
head(restData)

## look at a bit of the data
head(restData,n=3)
tail(restData,n=3)

## make summary
summary(restData)

## Mpre in depth information
str(restData)

## quantiles of quantitative variables
quantile(restData$councilDistrict,na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))

## make table
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict,restData$zipCode)

## checking for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

## row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

## values with specif characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]

## Cross tabs
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

## Flat Tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data=warpbreaks)
xt
ftable(xt)

## size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")

## Creating new variables
sl <-seq(1,10,by=2); sl
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); x
seq(along = x)

## subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

## creating binary variables
restData$zipWrong <- ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode <0)

## creating categorical variables
restData$ZipGroups <- cut(restData$zipCode,breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$ZipGroups, restData$zipCode)

## easier cutting
library(Hmisc)
restData$ZipGroups = cut2(restData$zipCode, g=4)
table(restData$ZipGroups)

## creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
## levels of factor variables
yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesno
yesnofac = factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)

## cutting produces factor variables
library(Hmisc)
restData$ZipGroups = cut2(restData$zipCode, g=4)
table(restData$ZipGroups)

## using the mutate function
library(Hmisc)
library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

## reshasping data
library(reshape2)
head(mtcars)

## melting data frames
mtcars$carname <- rownames(mtcars)
mtcars$carname
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n=3)
tail(carMelt, n=3)

## casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

## averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

## another way - split
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount = lapply(spIns, sum)
sprCount
unlist(sprCount)
sapply(spIns, sum)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

## creaging a newe variable
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)

## dataframes
library(dplyr)
chicago <- readRDS("chicago.rds")
chicago
dim(chicago)

## verbs atribuidos a dplyr para gerenciar data frames
## select, filter, arrange, rename, mutate, summarise 

## SELECT
head(select(chicago, 1:5))
names(chicago)[1:3]
head(select(chicago, city:dptp))

head(select(chicago, -(city:dptp)))
## equivalent base R 
i <- match("city", names(chicago))
j <- match("dpt", names(chicago))
head(chicago[, -(i:j)])

## filter
chic.f <- filter(chicago, pm25tmean2 > 30)
chic.f
head(select(chic.f, 1:3, pm25tmean2), 10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
chic.f
head(select(chic.f, 1:3, pm25tmean2, tmpd), 10)

## arrange
chigago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

## arranging colums in descending order
chicago <- arrange(chicago, desc(date))
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

## renamng a variable in a data frame R
head(chicago[, 1:5],3)

head(chicago[, 1:5], 3)
chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[, 1:5], 3)

## mutate
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))


## group_by - generating summary statistics by stratum
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd>80), labels(c("cold", "hot"))))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2team2))

summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

## merging data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

## merging data - merge()
names(reviews)
names(solutions)
mergedData = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergedData)

## default - merge all common column names
intersect(names(solutions), names(reviews))
mergeData2 = merge(reviews, solutions, all=TRUE)
head(mergeData2)

## using join in the plyr package
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df1
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df2
arrange(join(df1,df2),id)

## if you have multiple data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df1
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df2
df3 = data.frame(id=sample(1:10),z=rnorm(10))
df3
dfList = list(df1,df2,df3)
join_all(dfList)


















