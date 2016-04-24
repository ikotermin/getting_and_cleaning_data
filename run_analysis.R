library(plyr)

uci_hard_dir <- "UCI\ HAR\ Dataset"
feature_file <- paste(uci_hard_dir, "/features.txt", sep = "")
activity_labels_file <- paste(uci_hard_dir, "/activity_labels.txt", sep = "")
x_train_file <- paste(uci_hard_dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(uci_hard_dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(uci_hard_dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(uci_hard_dir, "/test/subject_test.txt", sep = "")


## Step 1
#Merges the training and the test sets to create one data set
##################################################################

x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

#Merge
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

## Step 2 
# Extracts only the measurements on the mean and standard deviation for each measurement
############################################################################################

features <- read.table(feature_file, colClasses = c("character"))
features_mean_std <-  grep("-(mean|std)\\(\\)", features[, 2])

## Subset the desired column and correct the name
x_data <- x_data[ ,features_mean_std]
names(x_data) <- features[features_mean_std, 2]

## Step 3
# Use descriptive activity names to name the activities in the data set
#################################################################################

activities <- read.table(activity_labels_file)


# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
################################################################################

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################


tidy_data_averages <- ddply(all_data, c("subject","activity"), numcolwise(mean))
write.table(tidy_data_averages, file = "tidy_data_averages.txt", row.names = FALSE)
