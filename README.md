Getting and Cleaning Data Course Project
----------------------------------------

The script [run_analysis.R](run_analysis.R). automatically try to download, extract and generate two tidy datasets when it's executed. The first tidy data set named tidy_data.txt containts the measurements on the mean and standard deviation for each measurement of merging the training and test data of the original data provided for the project. The second tidy data set named tidy_data_avg.txt creates an independent tidy data set with the average of each variable for each activity and each subject 

The script run_analysis.R has two library dependencies to be executed: data.table and dplyr. The script tries to load these dependencies if not exist.

A codebook is available in the repository with all the deatails of the project and is named [CodeBook.md](CodeBook.md).