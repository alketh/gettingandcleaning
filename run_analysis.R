source("CodeBook.R")

# Tasks
# 1. Merges the training and the test sets to create one data set.
test <- clean_data(data = "data/UCI HAR Dataset/test/X_test.txt",
                   activity <- "data/UCI HAR Dataset/test/y_test.txt",
                   subject <- "data/UCI HAR Dataset/test/subject_test.txt")

train <- clean_data(data = "data/UCI HAR Dataset/train/X_train.txt",
                   activity <- "data/UCI HAR Dataset/train/y_train.txt",
                   subject <- "data/UCI HAR Dataset/train/subject_train.txt")

data <- dplyr::bind_rows(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
data_sub <- dplyr::filter(data, variable %in% c("mean", "std"))

# 3. Uses descriptive activity names to name the activities in the data set
act_lab <- read.csv("data/UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)
names(act_lab) <- c("activity", "label")
act_lab$label <- tolower(act_lab$label)

data_sub <- dplyr::inner_join(data_sub, act_lab)

# 4. Appropriately labels the data set with descriptive variable names.
#    already done in clean_data

# 5. From the data set in step 4, creates a second, independent tidy 
#    data set with the average of each variable for each activity and each subject.
data_out <- dplyr::group_by(data_sub, activity, subject, label, variable)
data_out <- dplyr::summarise(data_out, mean_value = mean(value))

# NOTE: This doesn't make any sense because we average over fourier/non-fourier, 
# acceleration_type, measurement_type, dimension, and test/train