## Getting and Cleaning Data - Course Project

In order to produce tidy.txt, a single script was created, run_analysis.R.  

#### File layout

This script assumes the data is in a folder "UCI HAR Dataset" in the current working directory, with the same structure as the zip they were originally packaged in (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The required project structure is as below:

    ProjectDir/
        +-- UCI HAR Dataset/
                +-- features.txt
                +-- test/
                |       |
                |       +-- y_test.txt
                |       +-- subject_test.txt
                +-- train/
                        |
                        +-- y_train.txt
                        +-- subject_train.txt


#### Usage

After extracting the zip file, open run_analysis.R, set the current working directory to the project level and then execute the script.  See CodeBook.md for details on what run_analysis.R does.