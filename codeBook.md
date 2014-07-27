CodeBook
========================================================

This document briefly describes the procedures applied for creating the tidy data set as required in the project.

The pieces of information utilized to create a tidy data frame from training data:
- features from feature.txt
- activity labels from activity_labels.txt
- observations/samples for features from X_train.txt 
- activity labels for all the observations/samples from y_train.txt
- subject identification for each observation/sample from subject_train.txt

There is also corresponding same set of information for test data.


The process for creating a tidy dataset:
- first identify the features which have "-mean" and "-std" in their names.
- distill these identified feature observations from X_train.txt into a set of variables.
- get the label variable from y_trian.txt file, translate it to label strings based on
activity_labels.txt.
- get the subject varible from subject_train.txt file
- combine all the above variables together in to separate columns in a dataframe.

follow the same process for test data.

Now after creating the above two tidy datasets (training and testing), combine these two together to form the tidy dataset (**tidyDataSetA**) using the *rbind* commmand. the result is a dataframe with 10299 observations and 81 variables.

The final step is to process **tidyDataSetA** to calculate another tidydataset with a summary statistic (**average of each variable for each activity and each subject **). This is done using subsetting approach of data.frame and carefully extracting only the data thats needed. The results is a data.frame which has 180 observations and 81 variables. where each observation is a set of average values for each variable (selected features) for each activity and each subject.
