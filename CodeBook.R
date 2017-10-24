# Some tests prior to the function
# test <- readr::read_fwf("data/UCI HAR Dataset/test/X_test.txt", col_positions = readr::fwf_empty("data/UCI HAR Dataset/test/X_test.txt"))
# features <- readLines("data/UCI HAR Dataset/features.txt")
# 
# # Test if features match with #columns in test data
# length(features) == ncol(test)
# 
# # Test if activities match with activity labels
# act_lab <- read.csv("data/UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)
# names(act_lab) <- c("activity", "label")
# 
# act <- as.integer(readLines("data/UCI HAR Dataset/test/y_test.txt"))
# all(unique(act) %in% act_lab$activity)
# 
# # Test if dimension of activities fits with test data
# length(act) == nrow(test)
# 
# # Test if dimension of test subjects fits with test data
# test_subject <- as.integer(readLines("data/UCI HAR Dataset/test/subject_test.txt"))
# length(test_subject) == nrow(test)
# 
# # Apply the same tests to the train dataset
# train <- readr::read_fwf("data/UCI HAR Dataset/train/X_train.txt", col_positions = readr::fwf_empty("data/UCI HAR Dataset/train/X_train.txt"))
# train_subject <- as.integer(readLines("data/UCI HAR Dataset/train/subject_train.txt"))
# length(train_subject) == nrow(train)
# ncol(train) == ncol(test)

# Bsed on the out commented tests let's conclude the following:
# 1. Each column in "X_test.txt" and "x_train.txt" represents one feature from "features.txt"
# 2. The acitivity integers from "y_test.txt" and "y_train.txt" match the activity labels in "activity_labels.txt"
# 3. The activity from "y_test.txt"        can be added as column to "X_test.txt"
# 4. The activity from "y_train.txt"       can be added as column to "X_train.txt"
# 5. The subject from "subject_test.txt"   can be added as column to "X_test.txt"
# 6. The activity from "subject_train.txt" can be added as column to "X_train.txt"

# Informtion from "features_info.txt"
# 1. measurement_type: accelerometer and gyroscope - tAcc-XYZ and tGyro-XYZ
# 2. fourier:          time and fourier domain - indicated by prefixes "t" and "f"
# 3. acc_type:         Acceleration singnals were seperated into body and gravity acceleration signals - tBodyAcc-XYZ tGravityAcc-XYZ
# 4. jerk:             Jerk Signals obtained from linear acceleration and velocity
# 5. magnitude:        Magnitue of Jerk singnals - "Mag"
# 6. dimension:        3 dimensional orentation - XYZ
# 7. variable:         mean, std, mad, max, min, sma, energy, number, iqr, entropy, arCoef, correlation, maxInds, meanFreq, skewness, Kurtosis, bandsEnergy, angle

# Add in function debugging.
data <- "data/UCI HAR Dataset/test/X_test.txt"
activity <- "data/UCI HAR Dataset/test/y_test.txt"
subject <- "data/UCI HAR Dataset/test/subject_test.txt"

clean_data <- function(data, activity, subject, features = "data/UCI HAR Dataset/features.txt") {
  clean <- readr::read_fwf(data, col_positions = readr::fwf_empty(data))
  act <- as.integer(readLines(activity))
  sub <- as.integer(readLines(subject))
  feat <- read.csv("data/UCI HAR Dataset/features.txt", sep = " ", header = FALSE, stringsAsFactors = FALSE)[, 2]
  
  # Cleanup String a bit
  feat <- stringr::str_replace_all(feat, pattern = "[\\(\\)]", replacement = "")
  
  variables <- c("mean", "std", "mad", "max", "min", "sma", "energy", "number", "iqr", "entropy", 
                 "arCoeff", "correlation", "maxInds", "meanFreq", "skewness", "kurtosis", 
                 "bandsEnergy", "angle")
  
  # Leave function in case dimensions do not match!
  if (nrow(clean) != length(act)) stop("Measurements and activities do not match.")
  if (nrow(clean) != length(act)) stop("Measurements and subjects do not match.")
  if (ncol(clean) != length(feat)) stop("Not all features present in the data.")
  
  # Add headings
  names(clean) <- feat
  
  # Add new columns
  clean$activity <- act
  clean$subject <- sub
  
  # Add data source column
  if (grepl(pattern = "test", data)) {
    clean$datasource <- "test"
  } else {
    clean$datasource <- "train"
  } 
  
  return(clean)
}

# Apply function
# test <- clean_data(data = "data/UCI HAR Dataset/test/X_test.txt",
#                    activity <- "data/UCI HAR Dataset/test/y_test.txt", 
#                    subject <- "data/UCI HAR Dataset/test/subject_test.txt")
# 
# train <- clean_data(data = "data/UCI HAR Dataset/train/X_train.txt",
#                    activity <- "data/UCI HAR Dataset/train/y_train.txt", 
#                    subject <- "data/UCI HAR Dataset/train/subject_train.txt")
