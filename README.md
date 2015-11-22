# GettingAndCleaningDataPeerAssessment
Repository created for the peer assessment exercise on Getting and Cleaning Data Course

## <u>Steps to perform the process</u>
To repeat the work done in this project:

* 1. Download source data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* 2. Unzip to your working directory (where run_analysis.R file is located)
* 3. Execute the script run_analysis.R from that directory.

## <u>Steps Performed</u>
The steps followed by the script involve: 

* 1. Load all data files (features, labels, subjects, train data and test data)
* 2. Generate descriptive labels for every column
* 3. Insert subject and activity columns on the datasets
* 4. Merge train and test datasets
* 5. Get selected fields (mean and std measurements)
* 5. Save merged dataset on a txt file ("meanandstddevdata.txt")
* 6. Create the final data structure with the average of each variable for each activity and each subject
* 7. Save to a txt file ("tidydata.txt")

