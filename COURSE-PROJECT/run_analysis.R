## Project - Getting and Cleanind Data - Coursera

setwd("/Users/JoseAntonio/Desktop/COURSERA")
library(httr)
library(plyr)
## downlad and unzip database
nomearquivo <- "dataset.zip"
if (!file.exists(nomearquivo)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, nomearquivo, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { 
  unzip(nomearquivo) 
}
pathIn <- file.path("./", "UCI HAR Dataset")
list.files(pathIn, recursive = TRUE)

## 1 - Merges the training and the test sets to create one data set.
train1 <- read.table("UCI HAR Dataset/train/X_train.txt")
test1 <- read.table("UCI HAR Dataset/test/X_test.txt")
alldata1 <- rbind(train1, test1)
# subject txt
train2 <- read.table("UCI HAR Dataset/train/subject_train.txt")
test2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
alldata2 <- rbind(train2,test2)
# y train and y test
train3 <- read.table("UCI HAR Dataset/train/y_train.txt")
test3 <- read.table("UCI HAR Dataset/test/y_test.txt")
alldata3 <- rbind(train3, test3)
## reading data features and activity labels
features <- read.table("UCI HAR Dataset/features.txt") # 2 measruments
nomesativos <- read.table("UCI HAR Dataset/activity_labels.txt") # 3 activity names

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
alldata1 <- alldata1[, indices]
names(alldata1) <- features[indices, 2]; names(alldata1) <- gsub("\\(|\\)", "", names(alldata1))
names(alldata1) <- tolower(names(alldata1))

## 3 - Uses descriptive activity names to name the activities in the data set.
nomesativos[, 2] = gsub("_", "", tolower(as.character(nomesativos[, 2])))
alldata3[,1] = nomesativos[alldata3[,1], 2]
names(alldata3) <- "activity"

## 4 - Appropriately labels the data set with descriptive variable names.
names(alldata2) <- "subject"
dadoslimpos <- cbind(alldata2, alldata3, alldata1)
write.table(dadoslimpos, "./results/dadoslimpos.txt")
write.csv(dadoslimpos, "./results/dadoslimpos.csv")

## 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
library(reshape2)
alldata <- melt(dadoslimpos, id = c("subject", "activity"))
dadosmedios <- dcast(alldata, subject + activity ~ variable, mean)
write.table(dadosmedios, "./results/dadosmedios.txt", row.name=FALSE)
write.csv(dadosmedios, "./results/dadosmedios1.csv")











