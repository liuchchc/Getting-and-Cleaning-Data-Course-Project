#1. Merges the training and the test sets to create one data set.
trainX <- read.table("data/UCI HAR Dataset/train/X_train.txt")
trainy <- read.table("data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

testX <- read.table("data/UCI HAR Dataset/test/X_test.txt")
testy <- read.table("data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

mergeTrainSetX <- rbind(trainX, testX)
mergeTrainSetY <- rbind(trainy, testy)
mergeTrainSetSubject <- rbind(subject_train, subject_test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("data/UCI HAR Dataset/features.txt")
meanStdIndex <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
mergeTrainSetX <- mergeTrainSetX[, meanStdIndex]
names(mergeTrainSetX) <- features[meanStdIndex, 2]
names(mergeTrainSetX) <- gsub("\\(|\\)", "", names(mergeTrainSetX))
names(mergeTrainSetX) <- tolower(names(mergeTrainSetX))

#3. Uses descriptive activity names to name the activities in the data set
activitiesLaels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
activitiesLaels[,2] <- gsub("_", "", tolower(as.character(activitiesLaels[,2])))
mergeTrainSetY[, 1] <- activitiesLaels[mergeTrainSetY[, 1], 2]
names(mergeTrainSetY) <- "activity"
names(mergeTrainSetSubject) <- "subject"

#4. Appropriately labels the data set with descriptive variable names. 
cleanData <- cbind(mergeTrainSetSubject, mergeTrainSetY, mergeTrainSetX)
write.table(cleanData, "cleanData.txt")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubject <- unique(mergeTrainSetSubject)[,1]
subjectNumber <- length(uniqueSubject)
activeNumber <- length(activitiesLaels[,1])
dataColumn <- dim(cleanData)[2]
result <- matrix(NA, nrow = subjectNumber * activeNumber, ncol = dataColumn)
index = 1
for(i in 1 : subjectNumber) {
    for(j in 1 : activeNumber) {
        result[index, 1] <- uniqueSubject[i]
        result[index, 2] <- activitiesLaels[j, 2]
        result[index, 3 : dataColumn] <- colMeans(cleanData[cleanData$subject == i & cleanData$activity == activitiesLaels[j,2],3 : dataColumn])
        index <- index + 1
    }
}

write.table(result, "average_cleanData.txt")














