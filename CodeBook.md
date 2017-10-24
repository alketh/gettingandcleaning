## Data Source

The data was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description

The complete data documentation can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data contains the following information

* `activity` Integer specifying the acticity of the test subject. Can be one of 1 to 6.
* `subject` Integer giving the id of the 30 test subjects
* `trans` Some of the variables were fourier transformed. This is indicated by a leading character which can be `f` to indicate a transformation or `t` if not.
* `datasource` Character indicating if the data source is `test` or `train`.
* `age` subject age with the following categories `17-24`, `25-32`, `33-40`, `41-48`, `49-56`, `57-64`
* `dimension` 3D orientation of the subject movement. Can be on of `X`, `Y` or `Z`.
* `measurement_type` data was recorded using an `Accelerometer` or `Gyroscope`.
* `acc_type` Character depiciting if the measurement is based on `Body` or `Gravity`.
* Based on the body linear acceleration and angular velocity Jerk Signals were calculated. These columns are indicated by the string `Jerk`.
* The magnitude of these movements was calculated based on the Eucledian norm. These columns are indicated by the string `Mag`.
* `variable` The following set of variables was estimated `mean`, `std`, `mad`, `max`, `min`, `sma`, `energy`, `number`, `iqr`, `entropy`, `arCoeff`, `correlation`, `maxInds`, `meanFreq`, `skewness`, `kurtosis`, `bandsEnergy` and `angle`

The variables originate as a combination of the following informations:

`trans`, `acc_type`, `measurement_type`, `Jerk` (optional), `Mag` (optional), - `variable`, - `age` (optional), - `dimension` (optional)

resulting in the following appearance:

* `tGravityAccMag-max` (`trans` `acc_type` `measurement_type` `Mag` - `variable`)
* `fBodyAcc-bandsEnergy-33,40 ()` (`trans` `acc_type` `measurement_type` - `variable` - `age`)
* `fBodyGyro-kurtosis-Y` (`trans` `acc_type` `measurement_type` - `variable` - `dimension`)

## Data preparation

The data is preprocessed using the `clean_data` function. The function documentation can be found in `CodeBook.R`.
The following steps are applied.

* Read in observational data `X_test.txt` or `X_train.txt`.
* Read in activity data `y_test.txt` or `y_train.txt.
* Read in subject data `subject_test.txt` or `subject_train.txt`.
* Read in list of features from `features.txt`.
* Remove paranthesis from feature string.
* Check dimension of the different data sources.
* Add features as column headings to the observational data.
* Add column `activity` to the observational data using the activity data.
* Add column `subject` to the observational data using the subject data.
* Add column `datasource` to indicate of the data origintaed from `test` or `train`.

The resulting dataframe has the following variables:

* activity Integer specifying the acticity of the test subject. Can be one of 1 to 6.
* subject Integer giving the id of the test subject
* datasource Character indicating if the data source is `test` or `train`.
* Obeservation variables e.g. `tBodyAcc-mean-X`, `tBodyAcc-mean-Y`, `tBodyAcc-mean-Z`, and so on.