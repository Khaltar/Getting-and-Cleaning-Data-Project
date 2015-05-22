install.packages("tidyr")
install.packages("dplyr")
library(tidyr)
library(dplyr)

#1 - Merging test and train datasets (the full merge into a full dataset will only be done later after proper labelling)
training_X = read.table("UCI HAR Dataset/train/X_train.txt")

training_Y = read.table("UCI HAR Dataset/train/y_train.txt")

subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")

test_X = read.table("UCI HAR Dataset/test/X_test.txt")

test_Y = read.table("UCI HAR Dataset/test/y_test.txt")

subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")

#using rbind function to join the train and test sets of each variable: x, y and subject into a single dataset of each

subject = rbind(subject_train, subject_test)

x_data = rbind(training_X, test_X)

y_data = rbind(training_Y, test_Y)

#2- extracting the mean and std of each measurement (x data)
#For this part, I will use the features.txt in order to know exactly what columns in the wholedata set
#correspond to the mean and std of each measurement.

features = read.table("UCI HAR Dataset/features.txt")

#using grep function to find the indices of the features that correspond to mean and std

features_indices = grep("-mean\\(\\)|-std\\(\\)", features[,2])

#subsetting those features from the x_dataset

x_data = x_data[,features_indices]

#naming those columns using names function and features names

names(x_data) = features[features_indices,2]

#3 - Naming activities with proper labels from activity_labels.txt (corresponding to y data)

activities_labels = read.table("UCI HAR Dataset/activity_labels.txt")

#using gsub function to replace all matches found with proper labels.

activities_labels[, 2] = gsub("_", "", tolower(as.character(activities_labels[, 2])))
y_data[,1] = activities_labels[y_data[,1], 2]
names(y_data) <- "Activity"

#4 - Labelling the dataset with descriptive names (only remaining data left to name appropriately is subject)
#After labelling, it is finally time to complete step 1 and merge the named x_data, y_data and subject into a single cleaned dataset

names(subject) = "subject"
cleaned_full_data = cbind(x_data, y_data, subject)

#5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Using Tidyr and Dplyr, one can do that using the group_by function
#converting cleaned_full_data to a tbl form usable by Tidyr and Dplyr

cleaned_full_data = tbl_df(cleaned_full_data)

#grouping by Activity and subject as asked
cleaned_full_data = group_by(cleaned_full_data, Activity, subject)

#computing averages for each column by grouped variable (activity and subject)
final_dataset = summarise_each(cleaned_full_data, funs(mean))

#making the file of the tidy data
write.table(final_dataset, file="tidy_data.txt", row.name=FALSE)