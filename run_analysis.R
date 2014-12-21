run_analysis <- function(){
    
  # The function does not take any paths----hence had to hardcode my data
  # location. No time to modyfy now! Maybe I will refine it later.
  
  # Import activity list and feature list first
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset")
  features <- read.table("features.txt")
  activity_labels <- read.table("activity_labels.txt")
  
  # Import the training data
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset/train")
  subject_train <- read.table("subject_train.txt")
  X_train <- read.table("X_train.txt")
  y_train <- read.table("y_train.txt")
  
  # Create activity column and associate the labels with the activity ids
  y_train <- merge(y_train,activity_labels)
  
  # Change the column names
  names( y_train)<-sprintf(c("activity_id","activity"))
  
  # Store the features in a vector
  name_vect <- as.character(features[,2])
   
  # Change the coulnm names in the dataset to meaningful feature names
  names(X_train) <- sprintf(name_vect)
  
  # Append subject column
  X_train$subject <- subject_train[,1]
  
  # Append activity column
  X_train$activity <- y_train[,"activity"]
  
  # I imported the Signal data but failed to understand it's use in the project scope
  # Never used these tables
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset/train/Inertial Signals")
  body_acc_x_train <- read.table("body_acc_x_train.txt")
  names(body_acc_x_train)<-sprintf("Time_window%d",1:128)
  
  body_acc_y_train <- read.table("body_acc_y_train.txt")
  names(body_acc_y_train)<-sprintf("Time_window%d",1:128)
  
  body_acc_z_train <- read.table("body_acc_z_train.txt")
  names(body_acc_z_train)<-sprintf("Time_window%d",1:128)
  
  body_gyro_x_train <- read.table("body_gyro_x_train.txt")
  names(body_gyro_x_train)<-sprintf("Time_window%d",1:128)
  body_gyro_y_train <- read.table("body_gyro_y_train.txt")
  names(body_gyro_y_train)<-sprintf("Time_window%d",1:128)
  body_gyro_z_train <- read.table("body_gyro_z_train.txt")
  names(body_gyro_z_train)<-sprintf("Time_window%d",1:128)
  
  total_acc_x_train <- read.table("total_acc_x_train.txt")
  names(total_acc_x_train)<-sprintf("Time_window%d",1:128)
  total_acc_y_train <- read.table("total_acc_y_train.txt")
  names(total_acc_y_train)<-sprintf("Time_window%d",1:128)
  total_acc_z_train <- read.table("total_acc_z_train.txt")
  names(total_acc_z_train)<-sprintf("Time_window%d",1:128)
  
  
  # Now Import the test data
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset/test")
  subject_test <- read.table("subject_test.txt")
  X_test <- read.table("X_test.txt")
  y_test <- read.table("y_test.txt")
  
  # Create activity column and associate the labels with the activity ids
  y_test <- merge(y_test,activity_labels)
  
  # Change the column names
  names( y_test)<-sprintf(c("activity_id","activity"))
  
  # Store the features in a vector
  name_vect <- as.character(features[,2])
  
  names(X_test) <- sprintf(name_vect)
  
  # Append subject column
  X_test$subject <- subject_test[,1]
  
  # Append activity column
  X_test$activity <- y_test[,"activity"]
  

# I imported the Signal data but failed to understand it's use in the project scope
# Never used these tables
  
  setwd("C:/mahesh/clean_data/UCI HAR Dataset/test/Inertial Signals")
  body_acc_x_test <- read.table("body_acc_x_test.txt")
names(body_acc_x_test)<-sprintf("Time_window%d",1:128)
  body_acc_y_test <- read.table("body_acc_y_test.txt")
names(body_acc_y_test)<-sprintf("Time_window%d",1:128)
  body_acc_z_test <- read.table("body_acc_z_test.txt")
names(body_acc_z_test)<-sprintf("Time_window%d",1:128)
  
  body_gyro_x_test <- read.table("body_gyro_x_test.txt")
names(body_gyro_x_test)<-sprintf("Time_window%d",1:128)
  body_gyro_y_test <- read.table("body_gyro_y_test.txt")
names(body_gyro_y_test)<-sprintf("Time_window%d",1:128)
  body_gyro_z_test <- read.table("body_gyro_z_test.txt")
names(body_gyro_z_test)<-sprintf("Time_window%d",1:128)
  
  total_acc_x_test <- read.table("total_acc_x_test.txt")
names(total_acc_x_test)<-sprintf("Time_window%d",1:128)
  total_acc_y_test <- read.table("total_acc_y_test.txt")
names( total_acc_y_test)<-sprintf("Time_window%d",1:128)
  total_acc_z_test <- read.table("total_acc_z_test.txt")
names(total_acc_z_test)<-sprintf("Time_window%d",1:128)
  
# Merge training and test data.
big_table_features <- rbind(X_train,X_test)


# Process to identify only those columns with mean and std in their names
features_c <- features[,2]
features_c <- as.character(features_c)
features_c_mean <- grep("mean",features_c,value=TRUE)
features_c_std <- grep("std",features_c,value=TRUE)
features_selection <- c(features_c_mean,features_c_std,"subject","activity")

# Subset only on the above selected columns + subject + activity
big_table_features_lite <- big_table_features[,features_selection]

# Use data.table package
library(data.table)

#coerce data frame
DT <- data.table(big_table_features_lite)

# Another tidy data set with mean and standard deviation for all columns for subject and activity
DT_wide <-setnames(DT[, sapply(.SD, function(x) list(mean=mean(x), sd=sd(x))), by=list(activity,subject)],c( sapply(names(DT)[-1], paste0, c(".men", ".SD"))))

#Export the dataframe as a .csv file
write.table(DT_wide, "C:/mahesh/clean_data.txt", sep="|",row.name=FALSE)
}