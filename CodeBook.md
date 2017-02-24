#Code Book for Getting & Cleaning Data peer review project

The oringal dataset has 561 variables. Of those, I retained 18, each related to one of the "magnitude" variables in the original dataset. These "magnitude" variables represent the combination of the XYZ data related to each measurement type, thus we get the overall mean of the measurement by looking only at the magnitude for each. 

Also inluded are two additional variables that indicate the subject being observed and the activity being observed. This results in 20 variables.

1. subjectid

Indicates the subject being oserved

There are 30 unique subjects

2. activities

Indicates the activity observed

There are 6 unique activities: laying, sitting, standing, walking, walkingdownstairs, walkingupstairs

NOTE: for variables 3-20, the variable name contains is converted to plain English, so each should be self explanatory. You will see references to "magnitude" and "jerk" show up repeatedly. 

From the original "features_info" for the originating data: "Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)."
 
Note2: The only abreviation that was retained is "std," which means "standard deviation". 

Note3: Finally, while some variables end in "mean" and others in "std," each numerical value in the resulting dataset represents the mean of all calculations for the subject who performed the observed action. For instance, there were many original observations of subject "1" performing the activity "walkingdownstairs," and the mean and std was calculated for each of those actions, but THIS dataset means all of those original observations into one value. So we are literally seeing the "mean of the mean" and the "mean of the std" in the final dataset.

3. timedbodilyaccelerationmagnitudemean
4. timedbodilyaccelerationmagnitudestd
5. timedgravityaccelerationmagnitudemean
6. timedgravityaccelerationmagnitudestd
7. timedbodilyaccelerationjerkmagnitudemean
8. timedbodilyaccelerationjerkmagnitudestd
9. timedbodilygyroscopicmagnitudemean
10. timedbodilygyroscopicmagnitudestd
11. timedbodilygyroscopicjerkmagnitudemean
12. timedbodilygyroscopicjerkmagnitudestd
13. frequencybodilyaccelerationmagnitudemean
14. frequencybodilyaccelerationmagnitudestd
15. frequencybodilyaccelerationjerkmagnitudemean
16. frequencybodilyaccelerationjerkmagnitudestd
17. frequencybodilygyroscopicmagnitudemean
18. frequencybodilygyroscopicmagnitudestd
19. frequencybodilygyroscopicjerkmagnitudemean
20. frequencybodilygyroscopicjerkmagnitudestd
