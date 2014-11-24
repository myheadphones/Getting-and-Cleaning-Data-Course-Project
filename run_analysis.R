##run_analysis.R

library("reshape2")
library("plyr")
## Inertial Signals/total_acc_x_*.txt, body_acc_x_*.txt, body_gyro_x_*.txt are ignored since
## the data is not used for calculating the mean and standard deviation.

# Retrieve the common list of activities and set the column names
# this will be merged into each dataset to display the activity name
lutActivities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(lutActivities) <- c("activity_id","activity_name")

# Retrieve the common list of features and set the column names
lutFeatures <- read.table("./UCI HAR Dataset/features.txt")
colnames(lutFeatures) <- c("feature_id","feature_name")

#read the train data files
subject_file <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_file <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_file <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#set the column names and merge the 3 train files
subject_file$rownum <- seq_along(subject_file[,1])
colnames(subject_file) <- c("subject_id","rownum")

y_file$rownum <- seq_along(y_file[,1])
colnames(y_file) <- c("activity_id","rownum")

colnames(x_file) <- lutFeatures[,2]
x_file$rownum <- seq_along(x_file[,1])

merged_file <- join_all(list(subject_file,x_file,y_file),"rownum")
merged_file <- join_all(list(merged_file,lutActivities),"activity_id")
mean_std_features <- grepl("mean|std|_", colnames(merged_file))

#save the final file
train_file = merged_file[,mean_std_features]

#read the test data files
subject_file <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_file <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_file <- read.table("./UCI HAR Dataset/test/Y_test.txt")

#set the column names and merge the 3 test files 
#(same commands as when 3 train files were merged)
subject_file$rownum <- seq_along(subject_file[,1])
colnames(subject_file) <- c("subject_id","rownum")

y_file$rownum <- seq_along(y_file[,1])
colnames(y_file) <- c("activity_id","rownum")

colnames(x_file) <- lutFeatures[,2]
x_file$rownum <- seq_along(x_file[,1])

merged_file <- join_all(list(subject_file,x_file,y_file),"rownum")
merged_file <- join_all(list(merged_file,lutActivities),"activity_id")
mean_std_features <- grepl("mean|std|_", colnames(merged_file))

#save the final file
test_file <- merged_file[,mean_std_features]

#merge into the final file
final_file <- rbind(train_file,test_file)
id_list <- grep("_", colnames(final_file),value=TRUE)
var_list <- grep("mean|std", colnames(final_file),value=TRUE)

melt_file <- melt(final_file,id=id_list,measure.vars=var_list)
dcast_file <- dcast(melt_file, subject_id + activity_name ~ variable, mean)

write.table(dcast_file, file = "./tidy_data.txt")
