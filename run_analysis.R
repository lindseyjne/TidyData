##set the directory
setwd("E:/")

##check to see if the file exists
if(!file.exists("./data")){dir.create("./data")}
URLfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URLfile, destfile="./data/Dataset.zip")

##Unzip the files
unzip(zipfile="./data/Dataset.zip",exdir="./data")

ZipFiles <- file.path("E:/data/UCI HAR Dataset")
MyFiles <- list.files(ZipFiles, recursive=TRUE)

##
##Read the subject files and X_File and Y_File
##
TestSubjectFile <-read.table(file.path(ZipFiles, "test", "subject_test.txt"), header = FALSE)
TrainSubjectFile <-read.table(file.path(ZipFiles, "train", "subject_train.txt"), header = FALSE)

TestXFile <- read.table(file.path(ZipFiles, "test", "X_test.txt"), header = FALSE)
TrainXFile <- read.table(file.path(ZipFiles, "train", "X_train.txt"), header = FALSE)

TestYFile <- read.table(file.path(ZipFiles, "test", "Y_test.txt"), header = FALSE)
TrainYFile <- read.table(file.path(ZipFiles, "train", "Y_train.txt"), header = FALSE)


##
##Merge subject, activity, and features files by rows
##
SubjectTrainTest <- rbind(TrainSubjectFile, TestSubjectFile)
XTrainTest <- rbind(TrainXFile, TestXFile)
YTrainTest <- rbind(TrainYFile, TestYFile)

##
##Name the variables
##
FeaturesTemp <- read.table(file.path(ZipFiles, "features.txt"), head = FALSE)
names(XTrainTest) <- FeaturesTemp$V2
names(SubjectTrainTest) <- c("Subject")
names(YTrainTest) <- c("Activity")

##
##Merge the columns from test and train for all data in one data set
##
CombineFiles <- cbind(SubjectTrainTest, YTrainTest)
AllData <- cbind(XTrainTest, CombineFiles)

##
##Extract measurements on the mean and standard deviation
##
MeanStd <- FeaturesTemp$V2[grep("mean\\(\\)|std\\(\\)", FeaturesTemp$V2)]

FeatureNames <- c(as.character(MeanStd), "Subject", "Activity")
AllData <- subset(AllData , select=FeatureNames)
str(AllData)

##
##Reading the data labels
##
MyLabel <- read.table(file.path(ZipFiles, "activity_labels.txt"), header = FALSE)


##
##Changing the variable from numeric to character and assigning names
##
AllData$Activity <- as.character(AllData$Activity)
AllData$Activity[AllData$Activity == '1'] <- 'WALKING'
AllData$Activity[AllData$Activity == '2'] <- 'WALKING_UPSTAIRS'
AllData$Activity[AllData$Activity == '3'] <- 'WALKING_DOWNSTAIRS'
AllData$Activity[AllData$Activity == '4'] <- 'SITTING'
AllData$Activity[AllData$Activity == '5'] <- 'STANDING'
AllData$Activity[AllData$Activity == '6'] <- 'LAYING'
str(AllData$Activity)   ##Checking the revised variable names


names(AllData) <- gsub("^t", "Time", names(AllData))
names(AllData) <- gsub("^f", "Frequency", names(AllData))
names(AllData) <- gsub("Acc", "Accelerometer", names(AllData))
names(AllData) <- gsub("Gyro", "Gyroscope", names(AllData))
names(AllData) <- gsub("Mag", "Magnitude", names(AllData))
names(AllData) <- gsub("BodyBody", "Body", names(AllData))


names(AllData)   ##Checking the revised variable names

##
##Create a tidy data set with the average of each variable for each activity
##
TidyData <-aggregate(. ~Subject + Activity, AllData, mean)
TidyData <-TidyData[order(TidyData$Subject,TidyData$Activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)
