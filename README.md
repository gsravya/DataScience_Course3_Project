# DataScience_Course3_Project
The objective is to clean and tidy up the raw datasets into a neat dataset ready for analysis.

This repo contains the R script 'run_analysis.R' that tidies up the raw data from different files and creates a clean dataset 'final_ds.txt' which is ready to be analyzed. The following are the steps that are followed to arrive at the tidy set:

* X, y and subject files from train and test folders are read correspondingly. The 561 columns in X tables are named from the 'features.txt' file.
* fhbsdk
1. 
All the files are read using 'read.table()' function
2. To merge train and test data sets, train and test datasets are assembled separately and merged using rbind with train being the first part of the merged dataset and the test being the last part.
  2.1 Train dataset is created by binding the columns in the order: total_acc_x_train, total_acc_y_train, total_acc_z_train, 
                                                                    body_acc_x_train, body_acc_y_train, body_acc_z_train, 
                                                                    body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, 
                                                                    X_train, y_train, subject_train
  2.2 Test dataset is created similarly, but with test data
3. The dataset with only mean and std variables is also created by finding out the column numbers and extracting those columns and binding them together to create a dataset named ds2
4. For introducing descriptive names to the dataset 'ds2', a new column is added to it with the corresponding description found from the 'activity_labels.txt' file. A function 'label_function' is created to assign different values to different labels and it is used in sapply over the label column of the dataset 'ds2'.
5. To introduce labels to the column names, colnames() function is used and the columns are named.
6. The Part 5 in the question is solved as two parts:
  6.1 Average over label activities: The label activities are grouped and averaged using 'aggregate()' function and the average is over every column
  6.2 Average over subject: The subject numbers are grouped and averaged using 'aggregate()' function and the average is over every column as above.
  6.3 These two above datasets are combined to form a final dataset, which is written as a table named 'final_ds.txt'. This is formed by row binding the subject average dataframe with activity average data frame and the columns in the dataframe are the same as the original dataset 'ds2', but without act_desc, act_label and subject columns.
