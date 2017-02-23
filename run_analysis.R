# start by loading in the dplyr package, as it'll be needed later on
require("dplyr",quietly = TRUE)

# The "features" file which contains all variable names fo future steps
features<-read.table("./UCI HAR Dataset/features.txt")
features<-features$V2

# Next, we will load the 'test' and the 'train' datasets and apply the variable names from 'features'
testData<-read.table("./UCI HAR Dataset/test/X_test.txt")
trainData<-read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(testData)<-features
colnames(trainData)<-features

# Then, we bring in the activity tags to each dataset
trainActivities<-readLines("./UCI HAR Dataset/train/y_train.txt")
testActivities<-readLines("./UCI HAR Dataset/test/y_test.txt")

testData$activities<-testActivities
trainData$activities<-trainActivities

# Next, bring in the subject IDs into each data set, first by introducting them as vectors,
# then by adding them to a "subjectid" variable to each dataset
# note: activities and subjectid will both need to eventually be factors in order to group_by
# but since we won't transform subjectid after we bring it in, we can just bring
# it in as a factor instead of waiting until later

subjtrain<-readLines("./UCI HAR Dataset/train/subject_train.txt")
subjtest<-readLines("./UCI HAR Dataset/test/subject_test.txt")

trainData$subjectid <-as.factor(subjtrain)
testData$subjectid <-as.factor(subjtest)

# and then combine the datasets
allData<-rbind(trainData,testData)

# According to "features_info.txt", the XYZ measurements for each read has been combined into
# magnitude variables. Therefore, to get the mean and std for all measurements, all we need  
# are the mean and std of the magnitude data and not each XYZ mean & std variable.
#
# I HAVE ALSO DECIDED TO OMIT THE "meanFreq()" variables because my understanding of the 
# "features_info.txt" indicates that these variables are unnecessary! If one were so inclined to
# include these variables, they could add "meanFreq\\(\\)$" to the list of possible regular
# expressions. 
#
# The end result will be 18 measurements variables, subjectid variable, and activities variable.
# This equals 20 variables. We can grab all of these items with one regular expression.

allData<-allData[,grep("mean\\(\\)$|std\\(\\)$|subject|activities",colnames(allData))]


# Pull the activity descriptors, remove numeric prefixes (since they're not descriptive), 
# and then apply them to the activity variable in allData
# then get rid of the underscore and lowercase everything in case we ever want to use these
# activity descriptions as variables in a tidy dataset

activities<-readLines("./UCI HAR Dataset/activity_labels.txt")
activities<-strsplit(activities," ")
activities<-sapply(activities,"[",2)
allData$activities<-sub("1",activities[1],allData$activities)
allData$activities<-sub("2",activities[2],allData$activities)
allData$activities<-sub("3",activities[3],allData$activities)
allData$activities<-sub("4",activities[4],allData$activities)
allData$activities<-sub("5",activities[5],allData$activities)
allData$activities<-sub("6",activities[6],allData$activities)
allData$activities<-gsub("_","",allData$activities)
allData$activities<-tolower(allData$activities)

# Finish off by transforming this variable into a factor so we can group_by later on
allData$activities<-factor(allData$activities)

# Then we'll clean up all objects exept for allData, just to keep our workspace clean
rm(list=c("features","testActivities","testData",
          "trainActivities","trainData","subjtrain","subjtest","activities"))

# next we have to rename the measurement variables to comply with tidy data standards

colnames(allData)<-sub("BodyBody","Body",colnames(allData))
colnames(allData)<-sub("tBodyAcc","timedbodilyacceleration",colnames(allData))
colnames(allData)<-sub("tBodyGyro","timedbodilygyroscopic",colnames(allData))
colnames(allData)<-sub("fBodyAcc","frequencybodilyacceleration",colnames(allData))
colnames(allData)<-sub("fBodyGyro","frequencybodilygyroscopic",colnames(allData))
colnames(allData)<-sub("tGravityAcc","timedgravityacceleration",colnames(allData))
colnames(allData)<-sub("Mag-","magnitude",colnames(allData))
colnames(allData)<-sub("Jerk","jerk",colnames(allData))
colnames(allData)<-sub("\\()","",colnames(allData))

# and then create a new tidy dataset called allMeans by passing allData into a group_by
# function and a summarise_each function

allMeans<-allData %>% group_by(subjectid,activities) %>% summarize_each(funs(mean))

# and then we output the appropriate file

write.table(allMeans,"TidySamsungData.txt")
