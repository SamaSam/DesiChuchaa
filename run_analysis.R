## run_analysis.R
###############################################
###############################################
# read in the feature.txt
features=read.table(paste(getwd(), "/UCI HAR Dataset/features.txt",sep = ""), sep="\n",col.names=c("FeatureName"));
# read in the activity labels
activityLabels=read.table(paste(getwd(), "/UCI HAR Dataset/activity_labels.txt",sep = ""), sep=" ",col.names=c("ActivityID","ActivityName"));

# selected features indices
selectedFeatureIndices <- grep("*-mean|-std*", features[,1],ignore.case=TRUE)

###############################################
###############################################
# read in the training data
trainingData_selectedMeasurements=data.frame();
{
  subject_training=read.table(paste(getwd(), "/UCI HAR Dataset/train/subject_train.txt",sep = ""), sep="\n",col.names=c("SubjectID"));
  
  X_train= read.table(paste(getwd(), "/UCI HAR Dataset/train/X_train.txt",sep = ""), sep="\n");
  Y_train= read.table(paste(getwd(), "/UCI HAR Dataset/train/y_train.txt",sep = ""), sep="\n",col.names=c("Label"));
  
  #translate Y_train from numbers to activity strings
  Y_trainStrings=rep("",length(Y_train))
  for (iAct in activityLabels[,1])
  {
    Y_trainStrings[which(Y_train[,1] == iAct)] = as.character(activityLabels[iAct,2]);
  }
  
  dimsX_train<-dim(X_train);
  
  # create a fresh data.frame whihc only stores the selected features
  
  for (iR in dimsX_train[1]) {
    row<-unlist(strsplit(as.character(X_train[iR,1]),split=" "))  
    row=row[row!=""];
    row=row[selectedFeatureIndices];
    trainingData_selectedMeasurements= rbind(trainingData_selectedMeasurements,row)
  }
  colnames(trainingData_selectedMeasurements)<-as.character(features[selectedFeatureIndices,1]);
  #add a column for y labels to the data frame
  #add a column for subjects to the data frame
  trainingData_selectedMeasurements=cbind(Label=Y_trainStrings,trainingData_selectedMeasurements);
  trainingData_selectedMeasurements=cbind(Subject=subject_training,trainingData_selectedMeasurements);
}

###############################################
###############################################
# read in the test data
testingData_selectedMeasurements=data.frame();
{
  subject_testing=read.table(paste(getwd(), "/UCI HAR Dataset/test/subject_test.txt",sep = ""), sep="\n",col.names=c("SubjectID"));
  
  X_test= read.table(paste(getwd(), "/UCI HAR Dataset/test/X_test.txt",sep = ""), sep="\n");
  Y_test= read.table(paste(getwd(), "/UCI HAR Dataset/test/y_test.txt",sep = ""), sep="\n",col.names=c("Label"));
  
  Y_testStrings=rep("",length(Y_test))
  for (iAct in activityLabels[,1])
  {
    Y_testStrings[which(Y_test[,1] == iAct)] = as.character(activityLabels[iAct,2]);
  }
  
  dimsX_test<-dim(X_test);
  
  # create a fresh data.frame whihc only stores the selected features
  
  for (iR in dimsX_test[1]) {
    row<-unlist(strsplit(as.character(X_test[iR,1]),split=" "))  
    row=row[row!=""];
    row=row[selectedFeatureIndices];
    testingData_selectedMeasurements= rbind(testingData_selectedMeasurements,row)
  }
  colnames(testingData_selectedMeasurements)<-as.character(features[selectedFeatureIndices,1]);
  #add a column for y labels to the data frame
  #add a column for subjects to the data frame
  testingData_selectedMeasurements=cbind(Label=Y_testStrings,testingData_selectedMeasurements);
  testingData_selectedMeasurements=cbind(Subject=subject_testing,testingData_selectedMeasurements);
}

# merge the two datasets together
tidyDataSetA<-rbind(trainingData_selectedMeasurements,testingData_selectedMeasurements);
# export/save this dataset in a text file
#write.table(tidyDataSetA,"tidyDataSetA.txt", sep=",");

###############################################
###############################################
# Creates a second, independent tidy data set 
# with the average of each variable for each activity
# and each subject. 
newTidyDataSet=data.frame();
actStringForAllSubs=c();
subIdsForAllSubs=c();
for (iSub in 1:30)
{
  for (iAct in activityLabels[,2])#activityLabels[,2]
  { 
    actString=as.character(iAct);
    print(actString)
    subset<-tidyDataSetA[which(tidyDataSetA[,2] == actString & tidyDataSetA[,1] == iSub), 3:81];
    
    varMeans=numeric(79);
    for (ivar in 1:79){
      varMeans[ivar]=mean(as.numeric(as.character((subset[,ivar]))));
    }
    newTidyDataSet=rbind(newTidyDataSet,varMeans);
    actStringForAllSubs=c(actStringForAllSubs,actString);
    subIdsForAllSubs=c(subIdsForAllSubs,iSub);
  }
}
colnames(newTidyDataSet)<-as.character(features[selectedFeatureIndices,1]);

newTidyDataSet=cbind(Label=actStringForAllSubs,newTidyDataSet);
newTidyDataSet=cbind(Subject=subIdsForAllSubs,newTidyDataSet);

# export/save this dataset in a text file
write.table(newTidyDataSet,"newTidyDataSetWithMeans.txt", sep=",");
