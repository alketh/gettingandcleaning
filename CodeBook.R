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
  feat <- read.csv("data/UCI HAR Dataset/features.txt", sep = " ", header = FALSE)
  feat$var <- paste0("X", 1:nrow(feat))
  feat <- feat[, 2:3]
  variables <- c("mean", "std", "mad", "max", "min", "sma", "energy", "number", "iqr", "entropy", 
                 "arCoeff", "correlation", "maxInds", "meanFreq", "skewness", "kurtosis", 
                 "bandsEnergy", "angle")
  
  # Leave function in case dimensions do not match!
  if (nrow(clean) != length(act)) stop("Measurements and activities do not match.")
  if (nrow(clean) != length(act)) stop("Measurements and subjects do not match.")
  if (ncol(clean) != nrow(feat)) stop("Not all features present in the data.")
  
  # Add new columns
  # names(clean) <- feat[, 2]
  clean$activity <- act
  clean$subject <- sub
  
  # Transform to tidy dataframe
  dt <- tidyr::gather(clean, -activity, -subject, key = "var", value = "value")
  dt <- dplyr::inner_join(dt, feat, by = "var")
  
  # Remove angle calculations
  dt <- dt[-grep("angle", dt$V2), ]
  
  # Convert V2 column to actual columns.
  dt$fourier <- ifelse(substr(dt$V2, 1, 1) == "f", T, F)
  dt$acc_type <- ifelse(grepl(pattern = "Body", dt$V2), "Body", "Gravity")
  dt$meas_type <- ifelse(grepl(pattern = "Acc", dt$V2), "Accelerometer", "Gyroscope")
  dt$jerk <- ifelse(grepl(pattern = "Jerk", dt$V2), T, F)
  
  dt$dimension <- stringr::str_extract(dt$V2, pattern = "[XYZ]")
  
  # Extract variables. This is a bit messy
  var <- stringr::str_split_fixed(dt$V2, pattern = "-", n = 2)[, 2]
  var <- stringr::str_split_fixed(var, pattern = "-", n = 2)[, 1]
  var <- stringr::str_replace_all(var, pattern = "[\\(\\)]", replacement = "")
  var <- stringr::str_replace_all(var, pattern = "[0-9]", replacement = "")
  if (any(!var %in% variables)) stop("Variable does not match.")
  dt$variable <- var
  
  # Cleanup
  out <- dplyr::select(dt, -var, -V2)
  if (grepl(pattern = "test", data)) {
    out$category <- "test"
  } else {
    out$category <- "train"
  } 
  
  return(out)
}

# Apply function
# test <- clean_data(data = "data/UCI HAR Dataset/test/X_test.txt",
#                    activity <- "data/UCI HAR Dataset/test/y_test.txt", 
#                    subject <- "data/UCI HAR Dataset/test/subject_test.txt")
# 
# train <- clean_data(data = "data/UCI HAR Dataset/train/X_train.txt",
#                    activity <- "data/UCI HAR Dataset/train/y_train.txt", 
#                    subject <- "data/UCI HAR Dataset/train/subject_train.txt")
