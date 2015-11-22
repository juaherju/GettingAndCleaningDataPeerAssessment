
run_analysis <- function () {

      #loading libraries      
      library(plyr)
      library(reshape2)
      
      
      #Reading all the data
      
      features <- read.table("./UCI HAR Dataset/features.txt")

      traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
      trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
      trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

      testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
      testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
      testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

      activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

      # 4.-Appropriately label the data set with descriptive variable names (when tables are merged, this step will be finished)
      names(traindata) <- features$V2
      names(testdata) <- features$V2
      
      #Insert new columns populated with subjects and labels
      traindata$subject <- trainsubject$V1
      testdata$subject <- testsubject$V1
      
      traindata$activity <- trainlabels$V1
      testdata$activity <- testlabels$V1
      
      
      # 1.-Merge the training and the test sets to create one data set
      mergeddata <- rbind(traindata, testdata)
      
      
      # 3.-Use descriptive activity names to name the activities in the data set
      mergeddata$activitylabels <- factor(mergeddata$activity, levels=activities$V1, labels=activities$V2)
      
      
      # 2.-Extract only the measurements on the mean and standard deviation for each measurement.
      # Extract columns with 'mean' or 'std' keep las two columns to preserve subject,activity and activity labels
      
      selectedData <- mergeddata[,c(grepl("[Mm]ean.*\\(|[Ss]td.*\\(",features$V2),TRUE,TRUE,TRUE)]
      
      
      # 3.-Use descriptive activity names to name the activities in the data set
      
      # selectedData$activity_labels <- factor(selectedData$activity, levels=activities$V1, labels=activities$V2)
      
      # 4.-Dataset on step 4 is completed also at this point
      

      #write out the 1st data set
      write.table(selectedData, "meanandstddevdata.txt")
      
      #step 5: create a second, independent tidy data set with the average of each variable for each activity and each subject
      
      
      #find index up to which to select column names 
      actv_subj_index <- min(match(c("activitylabels","subject"),names(selectedData)))-1
      
      melteddata <- melt(selectedData, id.vars=c("activitylabels","subject"),
                          measure.vars=names(selectedData)[1:actv_subj_index])
      
      tidydata <- ddply(melteddata, .(subject,activitylabels,variable), summarize, mean=mean(value))
      
      write.table(tidydata, "tidydata.txt", row.names=FALSE)      
 
      
}