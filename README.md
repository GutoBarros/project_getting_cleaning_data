project_getting_cleaning_data
=============================

script and code book for the course project assignment

This script takes as input the data from "Human Activity Recognition Using Smartphones Data Set" that can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. It aims to solve the project assignment for Getting and Cleaning Data, from Coursera.

The citation request for the data:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

At first, it downloads and assigns to local variables the content of files in folder "train", except for the "Inertial signals". Then it assembles a data frame by joining subject, activity and variables.

The same procedure is taken to folder "test".

The two data frames are stacked. "data" is the first complete dataset.

Aiming a meaningful data set, the codes for "activity" are changed to its descriptions. The variables columns names are setted by using the file "features", appended by "subject" and "activity" naming the two first columns.

A new data frame "data_selected"  is made by subsetting only the measures from "data" with means() and std().

The columns names of the "data_selected" are tweaked to understandable names as stated in the Code Book in this same repo. This is the data frame that answers the part 4 of the assignment.

To create the data set with the average of each variable for each activity and subject, the package "reshape2" must be installed.

A vector with the variable names to be melted is created to ease the next step.

The "data_selected" data frame is melted using "subject" and "activity" as id variables and the vector passing the measure variable names.

Using "dcast", the "averaged" data frame is created by using the melted data set, "activity" and "subject" as casting attributes and "mean" as summarization method.

At last, this data frame is exported as txt file named "averaged_tidy.txt" (tab delimited)

NOTE: "averaged_tidy.txt" is a tidy data set because its accomplish with the rules "each variable forms a column", " each observation forms a row" and "there is only one kind of observations in this file".





 
