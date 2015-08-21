Code book for tidy_data.txt

Purpose and Goals

	The purpose of this exercise is to collect, work with, and clean a data set, and the goal is to prepare tidy data called tidy_data.txt that can be used for later analysis.


Raw Data
 
	This exercise leverages the Human Activity Recognition Using Smartphones Data Set available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
	
	The run_analysis.R code is to be executed from the directory where the entire "UCI HAR Dataset" downloaded from the above link resides.


Nature of Data

	The dataset includes the following files:
	=========================================

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
	======
		- Features are normalized and bounded within [-1,1].
		- Each feature vector is a row on the text file.


Data Features

	The data comprise the results of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING) of people wearing a Samsung device.


	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

	For each record it is provided:
	======================================

		- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
		- Triaxial Angular velocity from the gyroscope. 
		- A 561-feature vector with time and frequency domain variables. 
		- Its activity label. 
		- An identifier of the subject who carried out the experiment.


Step-by-Step Data Transformation Process

	- The reshape2 package is specifically required for the melt and dcast functions used down the line.  It is important to install the reshape2 package just once per session or it results in a warning.

	- Read in the activity label file, activity_labels.txt.  Create a data frame from it.  Use col.names to name the columns: activity_id and activity_name.

	- Read in the feature list file, features.txt.  Assign values in the second column to assigned_feature_names.

	- Read in the test data from the given file, X_test.txt.  Assign the feature names--columnwise--to this data.

	- Read in the training data from the given file, X_train.txt.  Assign the feature names--columnwise--to this data.

	- Read in the test subject ID data from the given file, subject_test.txt.  Specifically name the column "subject_id".

	- Read in the test subject activity ID data from the given file, y_test.txt.  Specifically name the column "activity_id".

	- Repeat the above two segments for train data.  Read in the train subject ID data from the given file, subject_train.txt.  Specifically name the column "subject_id".

	- Read in the train subject activity ID data from the given file, y_train.txt.  Specifically name the column "activity_id"

	- Through column-binding, combine the subject and activity IDs for the test data

	- Through column-binding, combine the subject and activity IDs for the train data

	- Through row-binding, merge the test and train data into a single dataframe

	- As per the project requirement, it is only essential to retain the "mean" and "std" values, so grep out column names that have "mean" in them and ignore the rest.

	- Also, grep out column names that have "std" in them and ignore the rest.

	- Find subset data with columns related to "mean" or "std" only.

	- Merge activities database with the mean_and_std database into a descriptive database.

	- Melt descriptivenames into a form suitable for easy casting.

	- Re-cast the melted data using the mean of each activity for the subjects.

	- Assemble the tidy dataset and write to a new file, tidy_data.txt.

