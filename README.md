# DataScience_Course3_Project
The objective is to clean and tidy up the raw datasets into a neat dataset ready for analysis.

This repo contains the R script 'run_analysis.R' that tidies up the raw data from different files and creates a clean dataset 'final_ds.txt' which is ready to be analyzed. The following are the steps that are followed to arrive at the tidy set:

* X, y (activity label) and subject files from train and test folders are read correspondingly. The 561 columns in X tables are named from the 'features.txt' file.
* A training set datafrane is created by column binding the train subject, y and X dataframes in that order. A test set is also created similarly.
* A new dataset 'ds1' is created by row binding the train and test dataframes created in the previous step.
* Another dataset 'ds2' is created which extracts columns that have 'mean' or 'std' in their names along with the subject and y columns using 'grep' function. 'ds2' column order is the same as that of ds1 i.e., subject, y and features that have 'mean' or 'std' in their column names.
* For introducing descriptive names to the dataset 'ds2', its 'activity' column is updated with the corresponding description found from the 'activity_labels.txt' file. A function 'label_function' is created to assign different values to different labels and it is used in sapply over the 'activity' column of the dataset 'ds2'.
* Finally, a new tidy dataset 'ds3' is created by using an 'aggregate' function by grouping the 'subject' and 'activity' columns of the 'ds2' dataset and applying mean to all other columns in 'ds2'. The 'ds3' is then ordered according to the 'subject' and 'activity' and then written out to a txt file named 'final_ds.txt', which is the final dataset.
