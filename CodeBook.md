Use the function `clean_data()` to read in the test and training data.
See `CodeBook.R` for further information.

The resulting dataframe has the following variables:
* activity Integer specifying the acticity of the test subject. Can be one of 1 to 6.
* subject Integer giving the id of the test subject
* value Numeric value of either acceleration or velocity (depending of the measurement type).
* fourier Logical indicating if data was fourier transformed `TRUE` or not `FALSE`.
* acc_type Character depiciting if the measurement is based on Body or Gravity.
* meas_type Character can be either `Accelerometer` or `Gyroscope`.
* jerk Logical indicating if measurement gives the jerk value `TRUE` or not `FALSE`.
* dimension Character giving the 3 dimensional orientation of the movement. Can be one of `X`, `Y` or `Z`.
* variable Character specifying the variables that were estimated. Can be one of `mean`, `std`, `mad`, `max`, `min`, `sma`, `energy`, `number`, `iqr`, `entropy`, `arCoeff`,`correlation`, `maxInds`, `meanFreq`, `skewness`, `kurtosis`, `bandsEnergy`, `angle`.
* category Character indicating if the data source is `test` or `train`.