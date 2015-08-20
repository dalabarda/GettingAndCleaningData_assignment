##create directory to store the raw data from web
###########################################################################

directory <- "run_analysisR"
fileUrl1 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
destfile1 <- "./run_analysisR/dataset.zip"

if(!file.exists(directory)){  ## nameappropriately the folder according the project
        dir.create(directory)
}
if(!file.exists(destfile1)){
        download.file(fileUrl1, destfile = destfile1, method = "internal", mode="wb")
        dateDownloaded <- date()
}
if(!file.exists("./run_analysisR/UCI HAR Dataset")){
        unzip(destfile1, exdir = "run_analysisR")
}

###########################################################################
## LOADING FILES
###########################################################################
require("data.table")
require("reshape2")

featureNames <- read.table("run_analysisR/UCI HAR Dataset/features.txt")
activityLabels <- read.table("run_analysisR/UCI HAR Dataset/activity_labels.txt", header = FALSE)

subjectTrain <- read.table("run_analysisR/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("run_analysisR/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("run_analysisR/UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjectTest <- read.table("run_analysisR/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("run_analysisR/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("run_analysisR/UCI HAR Dataset/test/X_test.txt", header = FALSE)

###########################################################################
## Part 1
###########################################################################

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

colnames(features) <- t(featureNames[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)


###########################################################################
## Part 2
###########################################################################

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

extractedData <- completeData[,requiredColumns]
dim(extractedData)


###########################################################################
## Part 3
###########################################################################

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
        extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

extractedData$Activity <- as.factor(extractedData$Activity)

###########################################################################
## Part 4
###########################################################################

names(extractedData)



###########################################################################
## Part 5
###########################################################################

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)


tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

