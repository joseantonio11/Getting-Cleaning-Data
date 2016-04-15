## Week 4 - Study - Getting and Cleaning Data - Coursera

## fixing character vectors - tolower() and toupper() 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))

## fixing character vectors - strsplit()
splitNames = strsplit(names(cameraData), "\\.")
splitNames
splitNames[[5]]
splitNames[[6]]

## Quick aside - lists
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25,  ncol = 5))
mylist
head(mylist)
mylist[1]
mylist[2]
mylist[3]
$letters
$letters
mylist$letters
mylist[1]

## fixing characeters vectors - sapply()
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

## per review data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)
reviews
solutions

## Fixing characters vectors - sub()
names(reviews)
sub("_", "", names(reviews))

## fixing characters vectors - gsub()
testName <- "this_is_a_test"
sub("_", "", testName)
testName
gsub("_", "", testName)

## finding values - grep() e grepI()
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
grep("Alameda", cameraData$intersection, value = TRUE)
length(grep("JeffStreet", cameraData$intersection))

## more useful string functions
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1,7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff         ")

## working with dates

d1=date()
d1
class(d1)

d2 <Sys.Date()
d2
class(d2)

## formatting dates
d2
format(d2,"%a %b %d")

## creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
x
z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])

## converting to Julian
weekdays(d2)
months(d2)
julian(d2)

## Lubridate
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

## dealing with times
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
?Sys.timezone

x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
x
wday(x[1])
wday(x[1],label=TRUE)
