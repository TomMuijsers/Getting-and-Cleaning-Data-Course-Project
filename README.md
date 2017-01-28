# Getting and Cleaning Data Course Project
A project on ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), on which an analyis script is run with a tidy data set as output.

## Tidy data set
The ['run_analysis']() R script to create a tidy data set from the ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Read the [Code Book]() for more information.

## To run the analysis follow these steps
1. Download the zipped data set from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Unzip the data set. The result should be a folder with the name `UCI HAR Dataset`.
3. Put the [`run_analysis`]() R script in the same folder as the `UCI HAR Dataset` folder (not IN the `UCI HAR Dataset` folder).
4. Run the [`run_analysis.R`]() R script, which will generate a new file `tidy_data.txt`.
&nbsp;
    The tidy data set can be read into R with `read.table(file = ".\tidy_data.txt", header = TRUE)`

## Required packages
The ['run_analysis']() R script requires the package [`dplyr`](https://cran.r-project.org/web/packages/dplyr/index.html)
