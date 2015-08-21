#The purpose of this program is to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
#This program leverages the Human Activity Recognition Using Smartphones Data Set available at: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#This code expects the "UCI HAR Dataset" to reside in the same directory as this program

#The reshape2 package is specifically required for the melt and dcast functions used down the line
#It is important to install the reshape2 package just once per session or it results in a warning
if (!("reshape2" %in% rownames(installed.packages())) ) {
  print("Installing rshape2")
  install.packages("reshape2")
} else {
library(reshape2)

#Read in the activity label file, activity_labels.txt
#Create a data frame from it
#Use col.names to name the columns: activity_id and activity_name
read_activity_labels <- read.table("./activity_labels.txt", col.names = c("activity_id", "activity_name"))

#Read in the feature list file, features.txt
#Assign values in the second column to assigned_feature_names
read_features <- read.table("features.txt")
assigned_feature_names <- read_features[, 2]

#Read in the test data from the given file, X_test.txt
#Assign the feature names--columnwise--to this data
X_test_data <- read.table("./test/X_test.txt")
colnames(X_test_data) <- assigned_feature_names

#Read in the training data from the given file, X_train.txt
#Assign the feature names--columnwise--to this data
X_train_data <- read.table("./train/X_train.txt")
colnames(X_train_data) <- assigned_feature_names

#Read in the test subject ID data from the given file, subject_test.txt
#Specifically name the column "subject_id"
test_subject_id <- read.table("./test/subject_test.txt")
colnames(test_subject_id) <- "subject_id"

#Read in the test subject activity ID data from the given file, y_test.txt
#Specifically name the column "activity_id"
test_activity_id <- read.table("./test/y_test.txt")
colnames(test_activity_id) <- "activity_id"

#Repeat the above two segments for train data

#Read in the train subject ID data from the given file, subject_train.txt
#Specifically name the column "subject_id"
train_subject_id <- read.table("./train/subject_train.txt")
colnames(train_subject_id) <- "subject_id"

#Read in the train subject activity ID data from the given file, y_train.txt
#Specifically name the column "activity_id"
train_activity_id <- read.table("./train/y_train.txt")
colnames(train_activity_id) <- "activity_id"

#Through column-binding, combine the subject and activity IDs for the test data
bound_test_data <- cbind(test_subject_id, test_activity_id, X_test_data)

#Through column-binding, combine the subject and activity IDs for the train data
bound_train_data <- cbind(train_subject_id, train_activity_id, X_train_data)

#Through row-binding, merge the test and train data into a single dataframe
combined_data <- rbind(bound_test_data, bound_train_data)

#As per the project requirement, it is only essential to retain the "mean" and "std" values
#grep out column names that have "mean" in them and ignore the rest
mean_index <- grep("mean", names(combined_data), ignore.case=TRUE)
mean_col_names <- names(combined_data)[mean_index]

#grep out column names that have "std" in them and ignore the rest
std_index <- grep("std", names(combined_data), ignore.case=TRUE)
std_col_names <- names(combined_data)[std_index]

#Find subset data with columns related to "mean" or "std" only
mean_and_std_data <- combined_data[, c("subject_id", "activity_id", mean_col_names, std_col_names)]

#Merge activities database with the mean_and_std database into a descriptive database
descriptivenames <- merge(read_activity_labels, mean_and_std_data, by.x = "activity_id", by.y = "activity_id", all=TRUE)

#Melt descriptivenames into a form suitable for easy casting
descriptive_datamelt <- melt(descriptivenames, id = c("activity_id", "activity_name", "subject_id"))

#Re-cast the melted data using the mean of each activity for the subjects
recast_data <- dcast(descriptive_datamelt, activity_id + activity_name + subject_id ~ variable, mean)

#Assemble the tidy dataset and write to a new file, tidy_data.txt
write.table(recast_data, "./tidy_data.txt", row.name = FALSE)

}
