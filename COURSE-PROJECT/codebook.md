# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

# The data source

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# The data

The dataset includes the following files:

'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Transformation details

There are 5 parts:

1 - Merges the training and the test sets to create one data set.

2 - Extracts only the measurements on the mean and standard deviation for each measurement.

3 - Uses descriptive activity names to name the activities in the data set.

4 - Appropriately labels the data set with descriptive activity names.

5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# How ```run_analysis.R``` implements the above steps:

1 - Require ```reshapre2``` and ```data.table``` librareis.

2 - Load both test and train data.

3 - Load the features and activity labels.

4 - Extract the mean and standard deviation column names and data.

5 - Process the data. There are two parts processing test and train data respectively.

6 - Merge data set.

# 


# run_analysis.R 

* downloads required data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* unzips the file if it has not been uncompressed
* creates results folder if it does not exist (all files are stored in this folder)
* loads features.txt used for columns
* loads X_train.txt, y_train.txt, subject_train.txt
* X_train contains the data using the feature data set as columns
* y_train contains the activity labels
* subject_train contains the ids
* loads and appends test dataset using X_test.txt, y_test.txt, subject_test.txt
* X_test contains the data using the feature data set as columns
* y_test contains the activity labels
* subject_test contains the ids
* appends train and test data
* rearrange the data using id
* loads activity_labels.txt
* changes the data activity row to use the activity labels
* saves the mean and std into mean_and_std.csv
* saves the tidy dataset into tidy_dataset.csv

# mean_and_std.csv

* contains 1 0300 (including header) rows and 82 columns (including enumeration column) in a default csv format

variables:
*  id	
*  activity	
*  tBodyAcc.std...X	
*  tBodyAcc.std...Y	
*  tBodyAcc.std...Z	
*  tGravityAcc.std...X	
*  tGravityAcc.std...Y	
*  tGravityAcc.std...Z	
*  tBodyAccJerk.std...X	
*  tBodyAccJerk.std...Y	
*  tBodyAccJerk.std...Z	
*  tBodyGyro.std...X	
*  tBodyGyro.std...Y	
*  tBodyGyro.std...Z	
*  tBodyGyroJerk.std...X	
*  tBodyGyroJerk.std...Y	
*  tBodyGyroJerk.std...Z	
*  tBodyAccMag.std..	
*  tGravityAccMag.std..	
*  tBodyAccJerkMag.std..	
*  tBodyGyroMag.std..	
*  tBodyGyroJerkMag.std..	
*  fBodyAcc.std...X	
*  fBodyAcc.std...Y	
*  fBodyAcc.std...Z	
*  fBodyAccJerk.std...X	
*  fBodyAccJerk.std...Y	
*  fBodyAccJerk.std...Z	
*  fBodyGyro.std...X	
*  fBodyGyro.std...Y	
*  fBodyGyro.std...Z	
*  fBodyAccMag.std..	
*  fBodyBodyAccJerkMag.std..	
*  fBodyBodyGyroMag.std..	
*  fBodyBodyGyroJerkMag.std..	
*  tBodyAcc.mean...X	
*  tBodyAcc.mean...Y	
*  tBodyAcc.mean...Z	
*  tGravityAcc.mean...X	
*  tGravityAcc.mean...Y	
*  tGravityAcc.mean...Z	
*  tBodyAccJerk.mean...X	
*  tBodyAccJerk.mean...Y	
*  tBodyAccJerk.mean...Z	
*  tBodyGyro.mean...X	
*  tBodyGyro.mean...Y	
*  tBodyGyro.mean...Z	
*  tBodyGyroJerk.mean...X	
*  tBodyGyroJerk.mean...Y	
*  tBodyGyroJerk.mean...Z	
*  tBodyAccMag.mean..	
*  tGravityAccMag.mean..	
*  tBodyAccJerkMag.mean..	
*  tBodyGyroMag.mean..	
*  tBodyGyroJerkMag.mean..	
*  fBodyAcc.mean...X	
*  fBodyAcc.mean...Y	
*  fBodyAcc.mean...Z	
*  fBodyAcc.meanFreq...X	
*  fBodyAcc.meanFreq...Y	
*  fBodyAcc.meanFreq...Z	
*  fBodyAccJerk.mean...X	
*  fBodyAccJerk.mean...Y	
*  fBodyAccJerk.mean...Z	
*  fBodyAccJerk.meanFreq...X	
*  fBodyAccJerk.meanFreq...Y	
*  fBodyAccJerk.meanFreq...Z	
*  fBodyGyro.mean...X	
*  fBodyGyro.mean...Y	
*  fBodyGyro.mean...Z	
*  fBodyGyro.meanFreq...X	
*  fBodyGyro.meanFreq...Y	
*  fBodyGyro.meanFreq...Z	
*  fBodyAccMag.mean..	
*  fBodyAccMag.meanFreq..	
*  fBodyBodyAccJerkMag.mean..	
*  fBodyBodyAccJerkMag.meanFreq..	
*  fBodyBodyGyroMag.mean..	
*  fBodyBodyGyroMag.meanFreq..	
*  fBodyBodyGyroJerkMag.mean..	
*  fBodyBodyGyroJerkMag.meanFreq..

# tidy_dataset.csv.csv
contains 181 rows (including header) and 82 columns (including enumeration column) in a default csv format

variables:
*  id	
*  activity	
*  tBodyAcc.std...X_mean	
*  tBodyAcc.std...Y_mean	
*  tBodyAcc.std...Z_mean	
*  tGravityAcc.std...X_mean	
*  tGravityAcc.std...Y_mean	
*  tGravityAcc.std...Z_mean	
*  tBodyAccJerk.std...X_mean	
*  tBodyAccJerk.std...Y_mean	
*  tBodyAccJerk.std...Z_mean	
*  tBodyGyro.std...X_mean	
*  tBodyGyro.std...Y_mean	
*  tBodyGyro.std...Z_mean	
*  tBodyGyroJerk.std...X_mean	
*  tBodyGyroJerk.std...Y_mean	
*  tBodyGyroJerk.std...Z_mean	
*  tBodyAccMag.std.._mean	
*  tGravityAccMag.std.._mean	
*  tBodyAccJerkMag.std.._mean	
*  tBodyGyroMag.std.._mean	
*  tBodyGyroJerkMag.std.._mean	
*  fBodyAcc.std...X_mean	
*  fBodyAcc.std...Y_mean	
*  fBodyAcc.std...Z_mean	
*  fBodyAccJerk.std...X_mean	
*  fBodyAccJerk.std...Y_mean	
*  fBodyAccJerk.std...Z_mean	
*  fBodyGyro.std...X_mean	
*  fBodyGyro.std...Y_mean	
*  fBodyGyro.std...Z_mean	
*  fBodyAccMag.std.._mean	
*  fBodyBodyAccJerkMag.std.._mean	
*  fBodyBodyGyroMag.std.._mean	
*  fBodyBodyGyroJerkMag.std.._mean	
*  tBodyAcc.mean...X_mean	
*  tBodyAcc.mean...Y_mean	
*  tBodyAcc.mean...Z_mean	
*  tGravityAcc.mean...X_mean	
*  tGravityAcc.mean...Y_mean	
*  tGravityAcc.mean...Z_mean	
*  tBodyAccJerk.mean...X_mean	
*  tBodyAccJerk.mean...Y_mean	
*  tBodyAccJerk.mean...Z_mean	
*  tBodyGyro.mean...X_mean	
*  tBodyGyro.mean...Y_mean	
*  tBodyGyro.mean...Z_mean	
*  tBodyGyroJerk.mean...X_mean	
*  tBodyGyroJerk.mean...Y_mean	
*  tBodyGyroJerk.mean...Z_mean	
*  tBodyAccMag.mean.._mean	
*  tGravityAccMag.mean.._mean	
*  tBodyAccJerkMag.mean.._mean	
*  tBodyGyroMag.mean.._mean	
*  tBodyGyroJerkMag.mean.._mean	
*  fBodyAcc.mean...X_mean	
*  fBodyAcc.mean...Y_mean	
*  fBodyAcc.mean...Z_mean	
*  fBodyAcc.meanFreq...X_mean	
*  fBodyAcc.meanFreq...Y_mean	
*  fBodyAcc.meanFreq...Z_mean	
*  fBodyAccJerk.mean...X_mean	
*  fBodyAccJerk.mean...Y_mean	
*  fBodyAccJerk.mean...Z_mean	
*  fBodyAccJerk.meanFreq...X_mean	
*  fBodyAccJerk.meanFreq...Y_mean	
*  fBodyAccJerk.meanFreq...Z_mean	
*  fBodyGyro.mean...X_mean	
*  fBodyGyro.mean...Y_mean	
*  fBodyGyro.mean...Z_mean	
*  fBodyGyro.meanFreq...X_mean	
*  fBodyGyro.meanFreq...Y_mean	
*  fBodyGyro.meanFreq...Z_mean	
*  fBodyAccMag.mean.._mean	
*  fBodyAccMag.meanFreq.._mean	
*  fBodyBodyAccJerkMag.mean.._mean	
*  fBodyBodyAccJerkMag.meanFreq.._mean	
*  fBodyBodyGyroMag.mean.._mean	
*  fBodyBodyGyroMag.meanFreq.._mean	
*  fBodyBodyGyroJerkMag.mean.._mean	
*  fBodyBodyGyroJerkMag.meanFreq.._mean



