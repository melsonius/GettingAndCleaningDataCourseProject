## Code Book for Getting and Cleaning Data - Course Project

### Data Processing

1. The labels and subjects for both the training and test sets were merged with the measurements from their respective sets.
2. All data was merged into a single data set.
3. The activity labels were transformed into a factor with levels "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING".  These correspond directly to the label values 1 through 6 respectively.
4. Features were labeled as per their values in "UCI HAR Dataset/features.txt".
5. A regular expression is used to extract all columns that represent a mean or standard deviation measurement.
6. Finally, the data is summarized by splitting it into chunks per-subject and then performing an average over each of those chunks.  These chunks are then re-merged back into a data frame and saved to disk.

### Regarding the tiny.txt summary data set

1. All columns are numeric.
2. The data set is sorted by subject.
3. There are 30 rows corrisponding to 30 subjects.
4. There are 80 columns.  The first column is the subject for whom the row was computed from, and columns 2-80 are the averages of all measurements for the measurement specified in the column header.