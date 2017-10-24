Use the function `clean_data()` to read in the test and training data.
See `CodeBook.R` for further information.

The resulting dataframe has the following variables:
* activity Integer specifying the acticity of the test subject. Can be one of 1 to 6.
* subject Integer giving the id of the test subject
* datasource Character indicating if the data source is `test` or `train`.
* Obeservation variables e.g. `tBodyAcc-mean()-X`, `tBodyAcc-mean()-Y`, `tBodyAcc-mean()-Z`, and so on.