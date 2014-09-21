if (!require(data.table)) {
  install.packages("dplyr")
  library(data.table)
}
  

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}


# 0. load test and training sets and the activities
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- basename(dataURL)
if(!file.exists(path)){
  download.file(dataURL, path)
}
unzip(path)


test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)

test_data_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
train_data_activity <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)

test_data_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
train_data_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")[,2]

# 1. Merges the training and the test sets to create one data set.
test_data<-cbind(test_data,test_data_activity)
test_data<-cbind(test_data,test_data_subject)
train_data<-cbind(train_data,train_data_activity)
train_data<-cbind(train_data,train_data_subject)
all_data<-rbind(test_data,train_data)

# 3. Uses descriptive activity names to name the activities in the data set.
activities_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
all_data[,ncol(all_data)-1] <- factor(all_data[,ncol(all_data)-1],levels=activities_labels$V1,labels=activities_labels$V2)


# 4. Appropriately labels the data set with descriptive variable names.
colnames(all_data)<-c(features, "activity", "subject")


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
columns <- grep("-mean\\(\\)|-std\\(\\)", colnames(all_data), value = TRUE)
tidy_data <- all_data[, c( columns, "activity", "subject")]
write.table(tidy_data,file="tidy_data.txt",sep=",",row.names = FALSE)


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data2 <- group_by(tidy_data,subject, activity) %>% 
  summarise_each(funs(mean))
write.table(tidy_data2,file="tidy_data_avg.txt",sep=",",row.names = FALSE)