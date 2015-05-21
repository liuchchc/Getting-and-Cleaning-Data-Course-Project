# The description of the run_analysis.R
The data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The task description
1. Merges the training and the test sets to create one data set
Read the "train/X_train.txt" to trainX,"train/y_train.txt" to trainy,"train/subject_train.tx" to subject_train,
"test/X_test.txt" to testX,"test/y_test.txt" to testy,"test/subject_test.tx" to subject_test.Then use the rbind to merge the data sets,
"mergeTrainSetX" is a 10299 × 66 data frame
"mergeTrainSetY" is a 10299 × 1 data frame
"mergeTrainSetSubject" also a 10299 × 1 data frame

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Read the features.txt to features,then find the rows witch contains the mean and std,the features is a 561 × 2 data frame.After get the features
we can named the mergeTrainSetX

3. Uses descriptive activity names to name the activities in the data set
Read the activity_labels.txt to activitiesLaels,activitiesLaels contains the six lables,and then replace the mergeTrainSetY with the activitiesLaels value,

4. Appropriately labels the data set with descriptive variable names. 
Merge the subject sets mergeTrainSetSubject,activity sets mergeTrainSetY and measurements set mergeTrainSetX to clearnDat,and export clearnDat to cleanData.txt

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In order to get the average of each variable for each activity and each subject,I use two loops,the first loop deal with subjects and the inner loop
deal with activities,so the row number is subjectNumber * activeNumer,that is 180 rows.Finnaly export the result to average_cleanData.txt
