run_analysis <- function(){
  
  # Read train data
  X_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  
  body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
  body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
  body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
  
  body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
  body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
  body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
  
  total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
  total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
  total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
  
  
  # Read test data
  X_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  
  body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
  body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
  body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
  
  body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
  body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
  body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")
  
  total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
  total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
  total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")
  
  ######## 1. Merging train and test datasets
  # Binding all train data into a ds_train dataset
  ds_train1 <- cbind(total_acc_x_train, total_acc_y_train, total_acc_z_train, 
                    body_acc_x_train, body_acc_y_train, body_acc_z_train, 
                    body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, 
                    X_train, y_train, subject_train)
  
  # Binding all test data into a ds_test dataset
  ds_test1 <- cbind(total_acc_x_test, total_acc_y_test, total_acc_z_test, 
                   body_acc_x_test, body_acc_y_test, body_acc_z_test, 
                   body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, 
                   X_test, y_test, subject_test)
  
  # Binding ds_train and ds_test into ds1 dataset. This is merging train and test datasets
  ds1 <- rbind(ds_train1, ds_test1)
  #print(dim(ds1))
  
  
  ###### 2. Only mean and std columns
  
  mean_std_train <- X_train[, c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,294,295,296,345,346,347,373,374,375,424,425,426,452,453,454,503,
                          513,516,526,529,539,542,552,555,556,557,558,559,560,561,4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,
                          350,427,428,429,504,517,530,543)]
  
  ds_train2 <- cbind(total_acc_x_train, total_acc_y_train, total_acc_z_train, 
                     body_acc_x_train, body_acc_y_train, body_acc_z_train, 
                     body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, 
                     mean_std_train, y_train, subject_train)
  
  mean_std_test <- X_test[, c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,294,295,296,345,346,347,373,374,375,424,425,426,452,453,454,503,
                              513,516,526,529,539,542,552,555,556,557,558,559,560,561,4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,
                              350,427,428,429,504,517,530,543)]
  
  ds_test2 <- cbind(total_acc_x_test, total_acc_y_test, total_acc_z_test, 
                         body_acc_x_test, body_acc_y_test, body_acc_z_test, 
                         body_gyro_x_test, body_gyro_y_test, body_gyro_z_test,
                         mean_std_test, y_test, subject_test)
  
  ds2 <- rbind(ds_train2, ds_test2) # ds2 dataset has all the training data and test data but with features that are only mean and std
  #print(dim(ds2))
  
  
  ######## 3. Use the descriptive names for the activities in the data set
  # The column act_desc is added to ds2
  
  # This function returns the corresponding descriptive variable according to the number in the labels of the dataset
  label_function <- function(x){
    if(as.numeric(x) == 1){
      return("WALKING")
    }
    else if(as.numeric(x) == 2){
      return("WALKING_UPSTAIRS")
    }
    else if(as.numeric(x) == 3){
      return("WALKING_DOWNSTAIRS")
    }
    else if(as.numeric(x) == 4){
      return("SITTING")
    }
    else if(as.numeric(x) == 5){
      return("STANDING")
    }
    else if(as.numeric(x) == 6){
      return("LAYING")
    }
    else{
      return("NA")
    }
  }
  
  ds2$act_desc <- sapply(ds2[, 1239], label_function)
  #print(dim(ds2))
  #print(ds2[10299, 1239:1241])
  
  ######## 4. Label the dataset with descriptive variable names
  
  colnames(ds2) <- c(rep("total_acc", 384), rep("body_acc", 384), rep("ang_acc", 384), c(1:86), "act_label", "subject", "act_desc")
  #print(ds2[1,1:10])
  #print(ds2[1, 385:395])
  #print(ds2[1, 769:779])
  #print(ds2[1, 1153:1163])
  #print(ds2[1, 1239:1241])
  
  
  ######## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  ds3_activity <- aggregate(ds2[, 1:1238], list(ds2$act_desc), mean)
  ds3_subject <- aggregate(ds2[, 1:1238], list(ds2$subject), mean)
  
  #print(dim(ds3_activity))
  #print(dim(ds3_subject))
  
  ds3 <- rbind(ds3_activity, ds3_subject)
  write.table(ds3, "final_ds.txt", row.name=FALSE)
  #print(dim(ds3))
}