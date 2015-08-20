---
title: "ReadMe"
author: "daniel carlos"
date: "20 de agosto de 2015"
output: html_document
---

Getting and Cleaning Data Project
===========
Project for getdata-002 on Coursera.

# Original instructions:
You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Steps in run_analysis.R:
1. download the UCI HAR Dataset into ./data
2. expand the compressed dataset
3. load the label codes key from activity_labels.txt
4. load the feature key from features.txt
5. determine the indices of desired features (those containing -mean() or -std())
6. load the training and test data sets and only retain data columns determined by indices from step #5
7. merge the training and test data sets
8. replace label codes in the dataset with text labels determined by step #3
9. reshape data to use label and subject as identifiers
10. produce a tidy data set (HARUSD_means.txt) with the average of each variable for each activity/subject combination
11. produce CodeBook.md with a list of column names (which were taken from features.txt)

# Notes:
* For descriptions of data types and how data was collected, check these files included with the original data: README.txt, features_info.txt

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
