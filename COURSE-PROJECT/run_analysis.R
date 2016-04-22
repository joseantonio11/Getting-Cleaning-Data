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

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
alldata1 <- alldata1[, indices]
names(alldata1) <- features[indices, 2]; names(alldata1) <- gsub("\\(|\\)", "", names(alldata1))
names(alldata1) <- tolower(names(alldata1))

## 3 - Uses descriptive activity names to name the activities in the data set.
nomesativos <- read.table("UCI HAR Dataset/activity_labels.txt")
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
uniqueSubjects = unique(alldata2)[,1]
numSubjects = length(unique(alldata2)[,1])
numActivities = length(nomesativos[,1])
numCols = dim(dadoslimpos)[2]
result = dadoslimpos[1:(numSubjects*numActivities), ]
row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = nomesativos[a, 2]
    tmp <- dadoslimpos[dadoslimpos$subject==s & dadoslimpos$activity==nomesativos[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "./results/dadosmedios.txt")
dadosmedios <- read.table("./results/dadosmedios.txt", sep = "")
write.csv(dadosmedios, "./results/dadosmedios.csv")









