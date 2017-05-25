## Load dplyr
library(dplyr)

## Set working directory to test files
setwd("/Users/edmundcartmell/desktop/neddocs/R/UCI Har Dataset/test")

## Read in test files
subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

## Set working directory to train files
setwd("../train")

## Read in train files
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

## Step 1 - Merge files 
X_test[,"y"] <- y_test
X_test[,"subject"] <- subject_test
X_train[,"y"] <- y_train
X_train[,"subject"] <- subject_train
tot_data <- rbind(X_test, X_train)

## Step 2 - Extract only the measurements on the mean and standard deviation for each measurement.
spec_data <- select(tot_data,V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, 
      V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, 
      V516:V517, V529:V530, V542:V543, y, subject)

## Step 3 - Applying descriptive activity names to name the activities in the data set
spec_data[which(spec_data[,67]==1, arr.ind = TRUE),67] <- "WALKING"
spec_data[which(spec_data[,67]==2, arr.ind = TRUE),67] <- "WALKING_UPSTAIRS"
spec_data[which(spec_data[,67]==3, arr.ind = TRUE),67] <- "WALKING_DOWNSTAIRS"
spec_data[which(spec_data[,67]==4, arr.ind = TRUE),67] <- "SITTING"
spec_data[which(spec_data[,67]==5, arr.ind = TRUE),67] <- "STANDING"
spec_data[which(spec_data[,67]==6, arr.ind = TRUE),67] <- "LAYING"

## Step 4 - Appropriately labels the data set with descriptive variable names.
colnames(spec_data)[1:68] <- c('tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y', 'tBodyAcc-mean()-Z', 'tBodyAcc-std()-X', 'tBodyAcc-std()-Y', 
  'tBodyAcc-std()-Z', 'tGravityAcc-mean()-X', 'tGravityAcc-mean()-Y', 'tGravityAcc-mean()-Z', 
  'tGravityAcc-std()-X', 'tGravityAcc-std()-Y', 'tGravityAcc-std()-Z', 'tBodyAccJerk-mean()-X', 
  'tBodyAccJerk-mean()-Y', 'tBodyAccJerk-mean()-Z', 'tBodyAccJerk-std()-X', 'tBodyAccJerk-std()-Y', 
  'tBodyAccJerk-std()-Z', 'tBodyGyro-mean()-X', 'tBodyGyro-mean()-Y', 'tBodyGyro-mean()-Z', 
  'tBodyGyro-std()-X', 'tBodyGyro-std()-Y', 'tBodyGyro-std()-Z', 'tBodyGyroJerk-mean()-X', 
  'tBodyGyroJerk-mean()-Y', 'tBodyGyroJerk-mean()-Z', 'tBodyGyroJerk-std()-X', 'tBodyGyroJerk-std()-Y', 
  'tBodyGyroJerk-std()-Z', 'tBodyAccMag-mean()', 'tBodyAccMag-std()', 'tGravityAccMag-mean()', 
  'tGravityAccMag-std()', 'tBodyAccJerkMag-mean()', 'tBodyAccJerkMag-std()', 'tBodyGyroMag-mean()', 
  'tBodyGyroMag-std()', 'tBodyGyroJerkMag-mean()', 'tBodyGyroJerkMag-std()', 'fBodyAcc-mean()-X', 
  'fBodyAcc-mean()-Y', 'fBodyAcc-mean()-Z', 'fBodyAcc-std()-X', 'fBodyAcc-std()-Y', 'fBodyAcc-std()-Z', 
  'fBodyAccJerk-mean()-X', 'fBodyAccJerk-mean()-Y', 'fBodyAccJerk-mean()-Z', 'fBodyAccJerk-std()-X', 
  'fBodyAccJerk-std()-Y', 'fBodyAccJerk-std()-Z', 'fBodyGyro-mean()-X', 'fBodyGyro-mean()-Y', 
  'fBodyGyro-mean()-Z', 'fBodyGyro-std()-X', 'fBodyGyro-std()-Y', 'fBodyGyro-std()-Z', 'fBodyAccMag-mean()', 
  'fBodyAccMag-std()', 'fBodyBodyAccJerkMag-mean()', 'fBodyBodyAccJerkMag-std()', 'fBodyBodyGyroMag-mean()', 
  'fBodyBodyGyroMag-std()', 'fBodyBodyGyroJerkMag-mean()', 'fBodyBodyGyroJerkMag-std()', 'Activity', 'Subject')

## Step 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject.
spec_data <- group_by(spec_data, Activity, Subject)
tidy_data <- summarize_each(spec_data, funs(mean))

write.table(tidy_data,"/Users/edmundcartmell/desktop/neddocs/r/gcd_final/tidy_data.txt")
