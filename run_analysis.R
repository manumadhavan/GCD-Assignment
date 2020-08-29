features <- read.table("UCI HAR Dataset/features.txt",col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "code")
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_data <- cbind(Subject,X,Y)
tidydataset <- Merged_data %>% select(subject,code,contains("mean"),contains("std"))
tidydataset$code <- activities[tidydataset$code, 2]
names(tidydataset)[2] = "activity"
names(tidydataset) <- gsub("Acc", "Accelerometer", names(tidydataset))
names(tidydataset) <- gsub("Gyro","Gyroscope", names(tidydataset))
names(tidydataset) <- gsub("BodyBody", "Body" , names(tidydataset))
names(tidydataset) <- gsub("Mag", "Magnitude" , names(tidydataset))
names(tidydataset) <- gsub("^t", "Time" , names(tidydataset))
names(tidydataset) <- gsub("^f", "Frequency" , names(tidydataset))
names(tidydataset) <- gsub("tBody", "TimeBody" , names(tidydataset))
names(tidydataset) <- gsub("-std()", "STD" , names(tidydataset), ignore.case = TRUE)
names(tidydataset) <- gsub("-freq()", "Frequency" , names(tidydataset), ignore.case = TRUE)
names(tidydataset) <- gsub("angle", "Angle", names(tidydataset))
names(tidydataset) <- gsub("gravity", "Gravity", names(tidydataset))
EndData <- tidydataset %>% group_by(subject, activity) %>% summarise_all(list(mean))
write.table(EndData, "EndData.txt", row.name = FALSE)
str(EndData)