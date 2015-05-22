# Getting and Cleaning Data Codebook

As requested, this codebook will describe the variables and the steps taken to treat and clean this data.

#Variables

training_X: variable with all the values in the X_train.txt file (7352*561)

training_Y: variable with all the values in the y_train.txt file (7532*1)

test_X: variable with all the values in the X_test.txt file (2947*561)

test_Y: variable with all the values in the y_test.txt file (2947*1)

subject_train: variable with all the values in the subject_train.txt file (7352*1)

subject_test: variable with all the values in the subject_test.txt file (2947*1)

subject: result of rbinding both subject_train and subject_test (10299 * 1)

x_data: result of rbinding both test_X and training_X (10299 * 66)

y_data: result of rbinding both test_Y and training_Y (10299 * 1)

features: A 561-feature vector with time and frequency domain variables

features_indices: The indices of the features that correspond to mean and std (1:66 vector)

activities_labels: The labels of the activities done (6 * 2)

cleaned_full_data: The full data that results from cbinding the treated and named x_data, y_data and subject (10299 * 68)

final_dataset: Corresponds to the fully treated and cleaned data with the averages for each column grouped by subject and activity after the use of the summarise_each function (180 * 68)


#Steps

1- The script will install and load into the library the packages Tidyr and Dplyr

2- The training_X, training_Y, test_X, test_Y, subject_train and subject_test variables will be created by reading all the .txt files in both the test and train folders using the command read.table with the different files' filepath.

3- Using the rbind function, each training and test set for each variable will be joined together to create the 3 datasets: x_data, y_data and subject, each one having both test and train data.

4- The features vector containing the time and frequency domains will be read using the read.table command and using regular expressions, the indices corresponding to the mean and standard deviation features will be found and stored in the features_indices vector

5- Those indices will then be used to subset the corresponding x_data indices to create a new x_data variable with only the mean and the std columns.

6- With the use of the names command and the features variable, the naming of those columns is done.

7- The file with the activity labels is read with the read.table command creating the variable activities_labels

8- Using regular expressions once again (the gsub command), all matches found for the y_data in the activities_labels is properly named.

9- The subjects data is named using the names command

10- Using the command cbind, the treated and named x_data, y_data and subject are bound together to create the cleaned_full_data variable

11- The cleaned_full_data variable is converted to a tbl form usable by Tidyr and Dplyr using the tbl_df command

12- The resulting data is grouped by Activity and subject using the group_by() command with the proper arguments.

13- Using the summarise_each command with the proper arguments, the final_dataset containing the averages for each column grouped by Activity and subject is created.

14- Using the write.table command, the final_dataset is written as the file tidy_data.txt containing what was asked from this project.

All copyrights to José Pereira, 2015




