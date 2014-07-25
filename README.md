############################
## README.txt
## Author : John Ossenfort
## Date   : 2014-07-25
############################

Here are the steps I took to create the dataset attached for the class 'Getting and Cleaning Data'.
As per the class instructions, the goal of this script is to perform the following steps:

//begin paste
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
//end paste


Date downloaded : Fri Jul 25 09:49:16 2014
Data URL        : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Metadata info   : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

1. Unzip the data in a new directory, creating the folder "UCI HAR Dataset"

2. Open the following files using "read.table". If this case, the Inertial data was not used but it does
exist in the zipfile downloaded for reference.

File list used for this activity. See the metadata info link above for more info on these files: 
  subject_train.txt, X_train.txt, y_train.txt,
  subject_test.txt, X_test, y_test.txt,
  activity_labels.txt, features.txt

3. Read the 'features.txt' file into each of the tables as column headers

4. I then filtered the data for mean and standard deviation by grepping the header rows. 
I made some assumptions here about what "mean" was - in this case only those features using
the "mean()" function were included (excluding function names like 'meanFreq()'). Standard
Deviation was assumed to end in 'std()', following the data description in the file 
'features_info.txt' (included in the zipfile)

5. The header names were cleaned up to be slightly more readable, removing special characters
and converting to camelcase

6. Then I merged the subject ID and activity columns from files 'subject_train.txt, subject_test.txt' and
'y_train.txt, y_test.txt' respectively, to the front of each dataset in order to lookup by those keys.

7. Next I merged the 'test' and 'train' datasets together, resulting in a much larger dataset of 10299 observations.

8. Merge the activity names from the file 'activity_labels' into the dataset, matched by activity ID
(from the file 'activity_labels.txt')

9. Finally I produced a tidy dataset summarizing the average of each variable by activity first and subject second. 
I did this using the 'melt' and 'dcast' functions from the "reshape2" package. 

############################

Loading the data set:
This output was generated in RStudio on Windows 7 with 'write.table' and 'row_names=FALSE'.
This output data can be loaded with read.table("output.txt")

