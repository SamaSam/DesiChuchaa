ReadMe 
========================================================

This document briefly describes the workings of run_analysis.R script.


The script assumes to be placed in parallel to the data directory.So place it in a directory, and then place the data directory in parallel. for example: place *analysis.R* in a directory which has an unpacked data directory **/UCI HAR Dataset//** (which includes **test**, **train** subdirectories and also **feature.txt** and **labels** etc)


The script is divided in to four parts:
- Reading the feature.txt, and activity_labels.txt,and calculating
the indices for features for interest (features containing strings :*"-mean"* and *"-std"*).

- Reading in the training data, and creating a tidy data.frame for it

- Reading in the testing data, and creating a tidy data.frame for it.

- Merging the the two above to create  a tidy data.frame

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject
- Finally writing the newly created tidy dataset to a .txt file, named **newTidyDataSetWithMeans.txt**.
