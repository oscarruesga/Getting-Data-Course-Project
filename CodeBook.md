CodeBook
--------
This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

The data source
---------------

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data
--------
The dataset includes the following files:

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

The set of variables that were estimated (and kept for this assignment) from the signals are:

mean(): Mean value
std(): Standard deviation

There is included all variables obtain their resultd from mean or standard deviation funcions. The implicate variables are:
* "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z"
* "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z"
* "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z"
* "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z"
* "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z"
* "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z"
* "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z"
* "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z"
* "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z"
* "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z"
* "tBodyAccMag-mean()" 
* "tBodyAccMag-std()"
* "tGravityAccMag-mean()"
* "tGravityAccMag-std()"
* "tBodyAccJerkMag-mean()"
* "tBodyAccJerkMag-std()"
* "tBodyGyroMag-mean()"
* "tBodyGyroMag-std()"
* "tBodyGyroJerkMag-mean()"
* "tBodyGyroJerkMag-std()"
* "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z"
* "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z"
* "fBodyAccJerk-mean()-X" "fBodyAccJerk-mean()-Y" "fBodyAccJerk-mean()-Z"
* "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z"
* "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z"
* "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z"
* "fBodyAccMag-mean()"
* "fBodyAccMag-std()"
* "fBodyBodyAccJerkMag-mean()"
* "fBodyBodyAccJerkMag-std()"
* "fBodyBodyGyroMag-mean()"
* "fBodyBodyGyroMag-std()"
* "fBodyBodyGyroJerkMag-mean()"
* "fBodyBodyGyroJerkMag-std()"



Transformation details
----------------------
The transformations steps are:


###1. Load Dependencies
```R
if (!require(data.table)) {
  install.packages("dplyr")
  library(data.table)
}
  

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}
```

###2. Load test and training sets and the activities

The data set has been stored in the current directory.

```R
# store the url provided from the original location.
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- basename(dataURL) # get the base path from the file dopwnloades
if(!file.exists(path)){
  download.file(dataURL, path)
}
unzip(path) #used to extract the zip file in this directory. Create de directory UCI HAR Dataset/ directory.
```

read.table is used to load the data to R environment for the data, the activities and the subject of both test and training datasets.
```R
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
test_data_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
train_data_activity <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
test_data_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
train_data_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")[,2]
```

### 3. Merges the training and the test sets to create one data set named all_data.
```R
test_data<-cbind(test_data,test_data_activity)
test_data<-cbind(test_data,test_data_subject)
train_data<-cbind(train_data,train_data_activity)
train_data<-cbind(train_data,train_data_subject)
all_data<-rbind(test_data,train_data)
```

###4. Set descriptive activity names to name the activities in the data set.

The class labels linked with their activity names are loaded from the activity_labels.txt file. The numbers of the testData_act and trainData_act data frames are replaced by those names:

```R
activities_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
all_data[,ncol(all_data)-1] <- factor(all_data[,ncol(all_data)-1],levels=activities_labels$V1,labels=activities_labels$V2)
```

###5. Appropriately labels the data set with descriptive variable names.
Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature vector. The *activity* and *subject* columns are also named properly before merging them to the test and train dataset.
```R
colnames(all_data)<-c(features, "activity", "subject")
```

###6. Extracts in file tidy_data.txt only the measurements on the mean and standard deviation for each measurement.
```R
columns <- grep("-mean\\(\\)|-std\\(\\)", colnames(all_data), value = TRUE)
tidy_data <- all_data[, c( columns, "activity", "subject")]
write.table(tidy_data,file="tidy_data.txt",sep=",",row.names = FALSE)
```
###7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The result, a tidy data table is created with the average of each measurement per activity/subject combination. The new dataset is saved in tidy_data_avg.txt file.
```R
tidy_data2 <- group_by(tidy_data,subject, activity) %>% 
  summarise_each(funs(mean))
write.table(tidy_data2,file="tidy_data_avg.txt",sep=",",row.names = FALSE)
```
