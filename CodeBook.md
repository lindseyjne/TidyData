This project utilizes human activity recognition using smartphones data set, which can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
This data set was built using 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors

Description of R Code (run_analysis.R)
Merges the training and the test sets to create one data set.
  1. donwload the data
  2. unzip the data
  3. read in the test, train, and subject files
  4. merge the subject, activity, and feature files by row
  5. name the variablees
  6. merge the columns from test and train for all data into one data set
 Extracts only the measurements on the mean and standard deviation for each measurement
  1. extract man and standard deviation using grep
 Uses descriptive activity names to name the activities in the data set
  1. show the activity labels from activity_labels.txt
  2. change activty variable from numeric to character
  3. change the "numeric" names to "character" names
 Appropriately labels the data set with descriptive variable names.
  1. expend the abbreviations to full words by using gsub
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  1. create a text file with the average for each variable using write.table()
  
variables used:
TestSubjectFile used to read in the subject_test.txt file
TrainSubjectFile used to read in the subject_train.txt file
TestXFile used to read in the X_test.txt file
TrainXFile used to read in the X_train.txt file
TestYFile used to read in the Y_test.txt file
TrainYFile used to read in the Y_train.txt file
SubjectTrainTest used to merge rows the datafiles
CombineFiles used to merge columns of the data files
AllData used to merge all data together
MeanStd used to extract the mean and standard deviation
TidyData used to create the clean data output TidyData.txt
