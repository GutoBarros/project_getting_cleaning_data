
## this script is intended to solve the course project from Getting and Cleaning Data
## course from Coursera. 


# opening the training data, activity numbers and subjects
X_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")

# attaching subjects and activity numbers to train data
data <- cbind(subject_train,y_train,X_train)

# opening the test data, activity numbers and subjects
X_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")

# attaching subjects and activity numbers to test data
data1 <- cbind(subject_test,y_test,X_test)

# 'merging' the datasets
data <- rbind(data,data1)

# changing activity numbers to names
for (i in 1:10299) {
      if (data[i,2]=="1"){
            data[i,2] <- "walking"
      }else if (data[i,2]=="2"){
            data[i,2] <- "walking upstairs"
      }else if (data[i,2]=="3"){
            data[i,2] <- "walking downstairs"
      }else if (data[i,2]=="4"){
            data[i,2] <- "sitting"
      }else if (data[i,2]=="5"){
            data[i,2] <- "standing"
      }else if (data[i,2]=="6"){
            data[i,2] <- "laying"
      }
}

# naming columns of data
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")
names <- as.vector(features[,2])
names <- c("subject","activity",names)
names(data) <- names

# selecting means and standard deviations
subject <- data[,1]
activity <- data[,2]
data_selected <-cbind(subject,activity,data[,grep("mean()",names,fixed=TRUE)])
data_selected <- cbind(data_selected,data[,grep("std()",names,fixed=TRUE)])

# changing features names to meaningful ones
names1 <- names(data_selected)
names1<-gsub("mean()","mean",names1, fixed=TRUE)
names1<-gsub("std()","standard_deviation",names1, fixed=TRUE)
names1<-gsub("BodyAcc-","body_acceleration-",names1, fixed=TRUE)
names1<-gsub("GravityAcc-","gravity_acceleration-",names1, fixed=TRUE)
names1<-gsub("BodyAccJerk-","body_acceleration_jerk-",names1, fixed=TRUE)
names1<-gsub("BodyGyro-","body_angular_velocity-",names1, fixed=TRUE)
names1<-gsub("BodyGyroJerk-","body_angular_velocity_jerk-",names1, fixed=TRUE)
names1<-gsub("BodyAccMag-","body_acceleration_magnitude-",names1, fixed=TRUE)
names1<-gsub("GravityAccMag-","gravity_acceleration_magnitude-",names1, fixed=TRUE)
names1<-gsub("BodyAccJerkMag-","body_acceleration_jerk_magnitude-",names1, fixed=TRUE)
names1<-gsub("BodyGyroMag-","body_angular_velocity_magnitude-",names1, fixed=TRUE)
names1<-gsub("BodyGyroJerkMag-","body_angular_velocity_jerk_magnitude-",names1, fixed=TRUE)
names1<-gsub("Bodybody_","body_",names1, fixed=TRUE)
names1<-gsub("tbody_","time_body_",names1, fixed=TRUE)
names1<-gsub("tgravity_","time_gravity_",names1, fixed=TRUE)
names1<-gsub("fbody_","frequency_body_",names1, fixed=TRUE)
names(data_selected) <- names1

## creating the second dataset with average of each variable to each subject and activity

library("reshape2")

# creating a vector with variables names
names2 <-names(data_selected)
names2 <-names2[3:68]

# melting the data_set to the combination of subject and activity
melted <- melt(data_selected, id.vars=c("subject","activity"), measure.vars=names2)

# casting to a narrow dataset with the averages
averaged <- dcast(melted, subject+activity ~ variable, mean)

# saving to a txt file
write.table(averaged,sep="\t","averaged_tidy.txt")