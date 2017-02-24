# Final Project for Getting and Cleaning Data class in Coursera
Description and Explanation of the contained R script

## Assignment Overview
The assignment asks students the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each      subject.

source: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

It aslo asks us to assume that the Samsuing data is in the working directory. I take this to assume that the "UCI HAR Data" folder is present in the working directory, not each file contained within. 

## Script Overview

The instructions for this assignment force us to make some assumptions about which variables to include in our final dataset. There seem to be several interpretations. 

We are asked to look for only variables that reflect the "mean" and "standard deviation" for each set of measurements. 

**Assumption 1:**

According to "features_info.txt", the XYZ measurements for each read has been combined into magnitude variables (labeled with "Mag"). Therefore, to get the mean and std for all measurements, all we need are the mean and std of the magnitude data and not each XYZ mean & std variable. **This means my regular expression looking for the variables I want to retain only looks for these kinds of variables.** I noticed that each of these Mag variables ended in eitehr mean() or std() and NOT mean()-[XYZ], etc. So I chose to look only for those variables, along with my "subjectid" variable and "activities" variable that were added to the dataset earlier in the script.

**Assumption 2:**

My understanding is that meanFreq variables should not be included. David Hood (whose article is linked to in a pinned discussion topic for week 4) thinks that either keeping meanFreq or getting rid of it is a fine way to interpret the instructiosn. **So keep in mind that I have specifically decided not to include meanFreq.**

Source: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

## Script Detail Walkthrough
Note: A VERSION OF THESE DETAILS CAN ALSO BE FOUND AS COMMENTS DIRECTLY WITHIN THE SCRIPT

1. I start off with "require("dplyr",quietly = TRUE)" so that future calls to this package work correctly
2. I then read in the 'features' file, which will contain all measurement variables in the two datasets. I played around with both read.table and readLines to get this info, and ultimately I found read.table easier for getting ONLY the variable names and not the position numbers (using features<-features$V2)
3. Next I loaded in the large datasets: X_test.txt and X_train.txt
4. I chose to immediately add the variables defined in features to each dataset
5. I then brought in  the y_train.txt and x_train.txt files into the datasets as variables called "activities"
6. Then I did the same thing for the "subject" data for both test and train
7. Now that I have two datasets with identical variables, I use rbind() to bring them together into one dataset called "allData"
8. Next, I subset allData to include only the variables I desire. **It's important you read the two "assumptions" earlier in this README in order to understand the decisions I made that resulted in 20 variables**
9. I then pulled the activity descriptors from "activity_labelts.txt" into a separate object, mapped those descriptors to the corresponding activity identifiers in the allData$activities variable, and then tidied up the names of the activities in case anyone ever wants to use these as variables themselves.
10. Unfortunately, step 9 results in changing $activites from a factor to a character vector, so I have to reclass this variable as a factor in order for later functions to work.
11. Then I decided to get rid of any objects I don't need so as not to clutter up the workspace once the script is complete
12. Next, I want to make the measurement variables conform to tidy data standards. My understanding is that we should not use capital letters, spaces, underscores, or dashes in tiny variables, and that we should avoid as many abbreviations as possible. This results in some pretty long variable names. I'm not thrilled with that, but so be it.
13. Almost done! Now we finally do the work of condensing the information in the measurement variables down in a new dataset called "allMeans." To do this, we pass the allData dataset to "group_by" (and grouping by subjectid and activities, in that order), then passing that grouped dataset to "summarize_each" which performs the function "mean" on each grouped chunk of data. This results in a dataset that only shows each activity once per subject, and takes the mean of all of the observations related to that subject+activity from the larger dataset.
14. Finally, we write the resulting dataset to a file called "TidySamsingdata.txt" 
