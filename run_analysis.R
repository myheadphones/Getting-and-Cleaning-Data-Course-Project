##run_analysis.R

library("reshape2")
library("plyr")
## Inertial Signals/total_acc_x_*.txt, body_acc_x_*.txt, body_gyro_x_*.txt are ignored since
## the data is not used for calculating the mean and standard deviation.

# Retrieve the common list of activities and set the column names
# This will be merged into each dataset to display the activity name
# Satisfies objective #3: "Uses descriptive activity names to name the activities in the data set"
lutActivities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(lutActivities) <- c("activity_id", "activity_name")

# Retrieve the common list of features and set the column names
lutFeatures <- read.table("./UCI HAR Dataset/features.txt")
colnames(lutFeatures) <- c("feature_id", "feature_name")

# Read the train data files
subject_file <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_file <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_file <- read.table("./UCI HAR Dataset/train/Y_train.txt")

# Set the column names and merge the 3 train files
subject_file$rownum <- seq_along(subject_file[, 1])
colnames(subject_file) <- c("subject_id", "rownum")

y_file$rownum <- seq_along(y_file[, 1])
colnames(y_file) <- c("activity_id", "rownum")

colnames(x_file) <- lutFeatures[, 2]
x_file$rownum <- seq_along(x_file[, 1])

# Include only mean, std and column added (i.e. subject_id, activity_id, activity_name)
# The columns added will be used when applying the melt and dcast
# Satisfies objective #2: "Extracts only the measurements on the mean and standard deviation for each measurement"
merged_file <- join_all(list(subject_file, x_file, y_file), "rownum")
merged_file <- join_all(list(merged_file, lutActivities), "activity_id")
mean_std_features <- grepl("mean|Mean|std|_", colnames(merged_file))

# Save the final file
train_file = merged_file[, mean_std_features]

# Read the test data files
subject_file <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_file <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_file <- read.table("./UCI HAR Dataset/test/Y_test.txt")

# Set the column names and merge the 3 test files 
# (same commands as when 3 train files were merged)
subject_file$rownum <- seq_along(subject_file[, 1])
colnames(subject_file) <- c("subject_id", "rownum")

y_file$rownum <- seq_along(y_file[, 1])
colnames(y_file) <- c("activity_id", "rownum")

colnames(x_file) <- lutFeatures[, 2]
x_file$rownum <- seq_along(x_file[, 1])

# Include only mean, std and column added (i.e. subject_id, activity_id, activity_name)
# The columns added will be used when applying the melt and dcast
# Satisfies objective #2: "Extracts only the measurements on the mean and standard deviation for each measurement"
merged_file <- join_all(list(subject_file, x_file, y_file), "rownum")
merged_file <- join_all(list(merged_file, lutActivities), "activity_id")
mean_std_features <- grepl("mean|Mean|std|_", colnames(merged_file))

# Save the final file
test_file <- merged_file[, mean_std_features]

# Merge into the final file
# Satisfies objective #1: "Merges the training and the test sets to create one data set"
final_file <- rbind(train_file, test_file)

# Clean up the column names
# Satisfies object #4: "Appropriately labels the data set with descriptive variable names"
id_list <- grep("_", colnames(final_file), value = TRUE)
column_names <- colnames(final_file)
# Get rid of unnecessary characters
column_names <- gsub("\\(\\)", "", column_names)
# Use standard naming conventions
column_names <- gsub("mean", "Mean", column_names)
column_names <- gsub("std", "SD", column_names)
column_names <- gsub("-", "_", column_names)
# Remove duplication
column_names <- gsub("bodybody", "body", column_names)
# Add that it will be averages (calculated later with melt and dcast)
column_names <- gsub("^angle", "Ave_Angle", column_names)
column_names <- gsub("^fBody", "Ave_FreqBody", column_names)
column_names <- gsub("^tBody", "Ave_TimeBody", column_names)
column_names <- gsub("tBody", "TimeBody", column_names)
column_names <- gsub("^tGravity", "Ave_TimeGravity", column_names)
# Update the column names
colnames(final_file) <- column_names
var_list <- grep("Mean|SD", colnames(final_file), value = TRUE)

# Creates the averages
# Satisfies objective #5: "From the data set in step 4, creates a second, independent tidy data set 
#                          with the average of each variable for each activity and each subject."
melt_file <- melt(final_file, id=id_list, measure.vars=var_list)
dcast_file <- dcast(melt_file, subject_id + activity_name ~ variable, mean)

write.table(dcast_file, file = "./tidy_data.txt", row.names = FALSE)
