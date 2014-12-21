New_data_cleaning
=================

For submission of data cleaning project

1. The code file is named run_analysis.R
2. It is loaded to the workspace
3. run_analysis() function is invoked without any parameters
4. The clean data file in the form of "clean_data.csv" file is found at a hard coded location

# In the function run_analysis, the following steps were done:

1. Import activity list and feature list first. This was done from hardcoded location.
   
  
2. Import the training data
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset/train")
  subject_train <- read.table("subject_train.txt")
  X_train <- read.table("X_train.txt")
  y_train <- read.table("y_train.txt")

3. Same was done for test data
  
4. Create activity column and associate the labels with the activity ids
  
5. Change the column names

6.Store the features in a vector
  
7. Change the column names in the dataset to meaningful feature names
    
8. Append 'subject' column
  
  
9. Append 'activity' column
 
  # I imported the Signal data but failed to understand it's use in the project scope
  # Never used these tables


10. Merge training and test data.


11. Process to identify only those columns with mean and std in their names

12. Subset only on the above selected columns + subject + activity
13. Use data.table package
library(data.table)

14. coerce data frame

15.  Another tidy data set with mean and standard deviation for all columns for subject and activity
DT_wide <-setnames(DT[, sapply(.SD, function(x) list(mean=mean(x), sd=sd(x))), by=list(activity,subject)],c( sapply(names(DT)[-1], paste0, c(".men", ".SD"))))

# Here I calculated the standard deviation even though it was not asked.
16. Export the dataframe as a .txt file
write.table(DT_wide, "C:/mahesh/clean_data.txt", sep="|")
  
