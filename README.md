# getting_and_cleaning_data

plyr package is necessary for this analysis file

First, create the files specifying the directories and separations These will be temporary files that will be transformed later on.

Once the files have been created, proceeds with step 1: in this step the r script reads the files created above using read.table on first place, and subsequently merges the data frames using rbind: x_train and x_test, y_train and y_test and subject_train and suject_test.

Step 2: opens features by read.table and specifies column classes as "character". Next, grip selects the mean and std variables as requested.

Step 3: changes the column name into "activity" in the y data.

Step 4: corrects to "subject" name and merges all the data frames of interest (x_data, y_data, subject_data) by cbind into all_data.

Setp 5: create a separate and tidy data set with the average of each variable for each activity and each subject by ddply and write.table.
