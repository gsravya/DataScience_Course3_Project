run_analysis <- function(){
  
  setwd("~/Documents/Summer/Summer2017/Data Science/3_Getting and Cleaning Data/Course_Project/UCI HAR Dataset/")
  features <- read.table("./features.txt")
  
  # Read train data
  X_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  
  # Step 4: Give descriptive names to the columns
  names(X_train) <- features$V2
  names(y_train) <- "activity"
  names(subject_train) <- "subject"
  
  # Read test data
  X_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  
  # Step 4: Give descriptive names to the columns
  names(X_test) <- features$V2
  names(y_test) <- "activity"
  names(subject_test) <- "subject"
  
  ######## Step 1. Merging train and test datasets
  # Binding all train data into a ds_train1 dataset
  ds_train1 <- cbind(subject_train, y_train, X_train)
  
  # Binding all test data into a ds_test1 dataset
  ds_test1 <- cbind(subject_test, y_test, X_test)
  
  # Binding ds_train1 and ds_test1 into ds1 dataset. This is merging train and test datasets
  ds1 <- rbind(ds_train1, ds_test1)
  #print(dim(ds1)) # 10299, 563
  
  
  ###### Step 2. Only mean and std columns
  ds2 <- cbind(subject = ds1$subject, activity = ds1$activity, ds1[grep("[Mm]ean|[Ss]td", names(ds1))])
  #print(dim(ds2))
  #print(names(ds2))


  ######## Step 3. Use the descriptive names for the activities in the data set
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
  
  ds2$activity <- sapply(ds2$activity, label_function)
  #print(dim(ds2))
  #print(head(ds2[, 1:5], 5))
  

  ######## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  ds3 <- aggregate(. ~ subject + activity, ds2, mean)
  ds3 <- ds3[order(ds3$subject, ds3$activity), ]
  
  #print(dim(ds3))
  write.table(ds3, "final_ds.txt", row.name=FALSE)
  #print(head(ds3[, 1:5], 10))
}