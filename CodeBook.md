CodeBook for Getting and Cleaning Data assignment
This is the CodeBook explaining the steps of the run_analysis.R

Feature Selection:
The data frame came from the transformation of the data in
the "Human Activity Recognition Using Smartphones Dataset Version 1.0". 
These signals were used to estimate variables of the feature vector for each pattern:
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ tGravityAcc-XYZ tBodyAccJerk-XYZ tBodyGyro-XYZ tBodyGyroJerk-XYZ tBodyAccMag tGravityAccMag tBodyAccJerkMag tBodyGyroMag tBodyGyroJerkMag fBodyAcc-XYZ fBodyAccJerk-XYZ fBodyGyro-XYZ fBodyAccMag fBodyAccJerkMag fBodyGyroMag fBodyGyroJerkMag

angle(): Angle between two vectors.


Feature Vector variables:
subject_id : Identifier, identifying each subject Type: Integer Values: Between 1 and 30
activity_name: Descriptive name of each subject's activity Type: Factor Values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
activity_id: Identifier, identifying the activity of each subject Type: Integer Values: 1 : 6
mean() : mean values of multiple measurements of the original variables. Type: Real number
std(): Standard deviation of multiple measurements of the original variables. Type: Real number

Prerequisites:

The package plyr need to be installed. install.packages('plyr').
The folder with data sets contained must be unzipped in the work directory.

Steps:

1) Prepare the environment: (folders, read files and save them in tables)

I create a function get_data(folders) to prepare both data sets from folders 'train' and 'test'

I use read.tables() to read files and put data in tables X(Data set), y(Data labels) 

I use read.tables() to read the file 'subject.txt': identifier of the subject who carried out the experiment and fixed the column name="subject"

I use read.csv2() to read the file 'features.txt' which List of all features.

Return the data.frame(subject = subject, y = y, X))

2)  Import into separate data frames the 'train' and 'test' data sets
    Merge both data frames using rbind()

3) I extract only the mean and standard devation for each measure. 
I use pattern matching with grep(). I truncate the resulting vector in order to ignore the angle and create a new subsetting 'DF_tmp1'


4) I calculate a function with the mean to each column. I use ddply() Split data frame 
and return results in a data frame.


5) I save the data set into the file 
write.csv()
