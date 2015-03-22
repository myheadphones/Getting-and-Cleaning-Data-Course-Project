Codebook for run_analysis.R
======================================

Table of contents
======================================
- RAW DATA: describes the variables and data of the original data set
- TRANSFORMATION: describes the work performed to clean up the data
- CLEANED DATA: describes the variables and data of the tidy data set

RAW DATA
======================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
--------------------------------------

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
--------------------------------------
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
--------------------------------------
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

TRANSFORMATION
======================================
1. Loaded the list of activities into R
2. Retreived and set the column names from the list of features file
3. Loaded the subjects, x and y data into R for the train data set
4. Merged the three train files into one train file
5. Remove any columns not related to standard deviation or mean for the train file and save the file
6. Loaded the subjects, x and y data into R for the test data set
7. Merged the three test files into one test file
8. Remove any columns not related to standard deviation or mean for the test file and save the file
9. Merge the train and test files
10. Clean up and standardize the column names from the combined file
11. Calculate the averages using melt and dcast
12. Save the file as tidy_data.txt

CLEANED DATA
======================================
The resulting data set contains the averages of all mean and standard deviation calculations.  It is averaged by the Subject (subject_id) and the type of activity performed (activity_name).

The following abbrebriations are used:
Acc: Acceleration
Mag: Magnitude
SD: Standard Deviation
Freq: Frequency
Ave: Average

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAcc-XYZ and TimeGyro-XYZ. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAcc-XYZ and TimeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccJerk-XYZ and TimeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FreqBodyAcc-XYZ, FreqBodyAccJerk-XYZ, FreqBodyGyro-XYZ, FreqBodyAccJerkMag, FreqBodyGyroMag, FreqBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
Note: '_XYZ' is used to denote 3-axial signals in each of the X, Y and Z directions and are represented by 3 variables, one for each of the dimensions.

- TimeBodyAcc_XYZ
- TimeGravityAcc_XYZ
- TimeBodyAccJerk_XYZ
- TimeBodyGyro_XYZ
- TimeBodyGyroJerk-XYZ
- TimeBodyAccMag
- TimeGravityAccMag
- TimeBodyAccJerkMag
- TimeBodyGyroMag
- TimeBodyGyroJerkMag
- FreqBodyAcc_XYZ
- FreqBodyAccJerk_XYZ
- FreqBodyGyro_XYZ
- FreqBodyAccMag
- FreqBodyAccJerkMag
- FreqBodyGyroMag
- FreqBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
- MeanFreq: Weighted average of the frequency components to obtain a mean frequency
- Angle: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- GravityMean
- TimeBodyAccMean
- TimeBodyAccJerkMean
- TimeBodyGyroMean
- TimeBodyGyroJerkMean

Complete list of variables:
- subject_id
- activity_name
- Ave_TimeBodyAcc_Mean_X
- Ave_TimeBodyAcc_Mean_Y
- Ave_TimeBodyAcc_Mean_Z
- Ave_TimeBodyAcc_SD_X
- Ave_TimeBodyAcc_SD_Y
- Ave_TimeBodyAcc_SD_Z
- Ave_TimeGravityAcc_Mean_X
- Ave_TimeGravityAcc_Mean_Y
- Ave_TimeGravityAcc_Mean_Z
- Ave_TimeGravityAcc_SD_X
- Ave_TimeGravityAcc_SD_Y
- Ave_TimeGravityAcc_SD_Z
- Ave_TimeBodyAccJerk_Mean_X
- Ave_TimeBodyAccJerk_Mean_Y
- Ave_TimeBodyAccJerk_Mean_Z
- Ave_TimeBodyAccJerk_SD_X
- Ave_TimeBodyAccJerk_SD_Y
- Ave_TimeBodyAccJerk_SD_Z
- Ave_TimeBodyGyro_Mean_X
- Ave_TimeBodyGyro_Mean_Y
- Ave_TimeBodyGyro_Mean_Z
- Ave_TimeBodyGyro_SD_X
- Ave_TimeBodyGyro_SD_Y
- Ave_TimeBodyGyro_SD_Z
- Ave_TimeBodyGyroJerk_Mean_X
- Ave_TimeBodyGyroJerk_Mean_Y
- Ave_TimeBodyGyroJerk_Mean_Z
- Ave_TimeBodyGyroJerk_SD_X
- Ave_TimeBodyGyroJerk_SD_Y
- Ave_TimeBodyGyroJerk_SD_Z
- Ave_TimeBodyAccMag_Mean
- Ave_TimeBodyAccMag_SD
- Ave_TimeGravityAccMag_Mean
- Ave_TimeGravityAccMag_SD
- Ave_TimeBodyAccJerkMag_Mean
- Ave_TimeBodyAccJerkMag_SD
- Ave_TimeBodyGyroMag_Mean
- Ave_TimeBodyGyroMag_SD
- Ave_TimeBodyGyroJerkMag_Mean
- Ave_TimeBodyGyroJerkMag_SD
- Ave_FreqBodyAcc_Mean_X
- Ave_FreqBodyAcc_Mean_Y
- Ave_FreqBodyAcc_Mean_Z
- Ave_FreqBodyAcc_SD_X
- Ave_FreqBodyAcc_SD_Y
- Ave_FreqBodyAcc_SD_Z
- Ave_FreqBodyAcc_MeanFreq_X
- Ave_FreqBodyAcc_MeanFreq_Y
- Ave_FreqBodyAcc_MeanFreq_Z
- Ave_FreqBodyAccJerk_Mean_X
- Ave_FreqBodyAccJerk_Mean_Y
- Ave_FreqBodyAccJerk_Mean_Z
- Ave_FreqBodyAccJerk_SD_X
- Ave_FreqBodyAccJerk_SD_Y
- Ave_FreqBodyAccJerk_SD_Z
- Ave_FreqBodyAccJerk_MeanFreq_X
- Ave_FreqBodyAccJerk_MeanFreq_Y
- Ave_FreqBodyAccJerk_MeanFreq_Z
- Ave_FreqBodyGyro_Mean_X
- Ave_FreqBodyGyro_Mean_Y
- Ave_FreqBodyGyro_Mean_Z
- Ave_FreqBodyGyro_SD_X
- Ave_FreqBodyGyro_SD_Y
- Ave_FreqBodyGyro_SD_Z
- Ave_FreqBodyGyro_MeanFreq_X
- Ave_FreqBodyGyro_MeanFreq_Y
- Ave_FreqBodyGyro_MeanFreq_Z
- Ave_FreqBodyAccMag_Mean
- Ave_FreqBodyAccMag_SD
- Ave_FreqBodyAccMag_MeanFreq
- Ave_FreqBodyBodyAccJerkMag_Mean
- Ave_FreqBodyBodyAccJerkMag_SD
- Ave_FreqBodyBodyAccJerkMag_MeanFreq
- Ave_FreqBodyBodyGyroMag_Mean
- Ave_FreqBodyBodyGyroMag_SD
- Ave_FreqBodyBodyGyroMag_MeanFreq
- Ave_FreqBodyBodyGyroJerkMag_Mean
- Ave_FreqBodyBodyGyroJerkMag_SD
- Ave_FreqBodyBodyGyroJerkMag_MeanFreq
- Ave_Angle(TimeBodyAccMean,gravity)
- Ave_Angle(TimeBodyAccJerkMean),gravityMean)
- Ave_Angle(TimeBodyGyroMean,gravityMean)
- Ave_Angle(TimeBodyGyroJerkMean,gravityMean)
- Ave_Angle(X,GravityMean)
- Ave_Angle(Y,GravityMean)
- Ave_Angle(Z,GravityMean)
