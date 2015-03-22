Getting-and-Cleaning-Data-Course-Project
========================================
run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Further details and the actual implementation are described in the code book.

Prerequisites and Installation Steps
========================================
1. Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Download run_analysis.R to the same directory.
3. Start up RStudio and set your working directory to where you put the files from steps 1 and 2 using setwd()
4. Use source("run_analysis.R") to tidy the data and produce the output data (tidy_data.txt)

Repo contents
========================================
1. Tidy data set (tidy_data.txt): with the cleaned up data and columns from the UCI HAR Dataset
2. R Code (run_analysis.R): performs the analysis and outputs the tidy data set file
3. Code book (CodeBook.md): describes the variables, data and work performed to clean up the data
