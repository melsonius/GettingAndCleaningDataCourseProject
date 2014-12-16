#### STEP 1 ####
# load the test set and apply labels
test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", colClasses = rep("numeric", 10), header=F)
test$activity <- readLines("UCI HAR Dataset/test/y_test.txt")
test$subject <- readLines("UCI HAR Dataset/test/subject_test.txt")

# load the training set and apply labels
train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", colClasses = rep("numeric", 10), header=F)
train$activity <- readLines("UCI HAR Dataset/train/y_train.txt")
train$subject <- readLines("UCI HAR Dataset/train/subject_train.txt")

# just mash them together, one on top of the other.  this is ok because they both have the same columns in the same order.
combined <- rbind(test, train)

#### STEP 3 ####

# assign labels to each of the 6 different activities.
combined$activity <- factor(combined$activity, labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#### STEP 4 ####

# read in the feature names, add the activity feature we added in ourselves, and apply the names to the combined data set
features <- read.table("UCI HAR Dataset/features.txt", header = F, colClasses = c("numeric", "character"))
features <- rbind(features, c(nrow(features)+1, "activity"))
features <- rbind(features, c(nrow(features)+1, "subject"))
colnames(features) <- c("number", "name")
colnames(combined) <- features$name

#### STEP 2 ####

# all of the mean and standard deviation columns have either "-mean" or "-std" in their name.
# I explicitly decided to include measurements such as the mean frequencies, but had I decided not to
#   the regular expression would instead have been: "-(mean|std)\\(\\)"
# I also include the activity and subject which are 
activityIdx <- nrow(features)
subjectIdx <- nrow(features) - 1
meanAndStdCols <- c(grep("-(mean|std)", colnames(combined)), activityIdx, subjectIdx)
meanAndStd <- combined[, meanAndStdCols]

#### STEP 5 ####

# split into a list where every subject is its own entry
bySubject <- split(meanAndStd, meanAndStd$subject)

# over the list of subjects, sapply mean, which gives us a list of the means for this subject.
# the outer sapply will mash them all together into a matrix with the measurements being 
# the rows and the subjects being the columns
tidy <- sapply(bySubject, function(x) sapply(x, mean))

# transpose the matrix so measurements are columns and subjects are rows
tidy <- t(tidy)

# remove the activity and computed subject columns, since they are all NA and uninteresting
tidy <- tidy[,-c(ncol(tidy), ncol(tidy)-1)]

# add the subject ids back as a legitimate column instead of just as the column names
tidy <- cbind("subject"=as.numeric(rownames(tidy)), tidy)

# do some cleanup: convert to a data frame, and sort the data
tidy <- as.data.frame(tidy)
tidy <- tidy[order(tidy$subject),]

# write out the final, tidy data set
write.table(tidy, file = "tidy.txt", row.names = F)
