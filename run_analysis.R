
#PART 1: MERGE DATA
subject_train <- read.table("train/subject_train.txt", header = FALSE)
activity_train <- read.table("train/y_train.txt", header = FALSE)
features_train <- read.table("train/X_train.txt", header = FALSE)

subject_test <- read.table("test/subject_test.txt", header = FALSE)
activity_test <- read.table("test/y_test.txt", header = FALSE)
features_test <- read.table("test/X_test.txt", header = FALSE)

features_nm <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", header = FALSE)

#combine the test and training subjects
subjects<-rbind(subject_test,subject_train)
activity<-rbind(activity_test,activity_train)
feature<-rbind(features_test,features_train)

#name the columns
colnames(feature) <- t(features_nm[2])
colnames(subjects)[1]<-"Subject"  
colnames(activity)[1]<-"Activity"  

#combine feature, activity, subject
tidydata<-cbind(subjects,activity,feature)

#PART 2: MEAN/SD EACH MEASUREMENT
meansd <- grep("mean|std", names(tidydata), ignore.case=TRUE)
extractmeansd <- cbind(tidydata[,1], tidydata[,2],tidydata[,meansd])
colnames(extractmeansd)[1]<-"Subject"  
colnames(extractmeansd)[2]<-"Activity"  

#PART 3: MAKE ACTIVITY NUMBERS INTO DESCRIPTIVE NAMES
#I dont know if I am supposed to do this for the extracted data or all data
#So I'll do it for both 
extractmeansd$Activity <- as.character(extractmeansd$Activity)
extractmeansd$Activity[extractmeansd$Activity==1] <- as.character(activity_labels[1,2])
extractmeansd$Activity[extractmeansd$Activity==2] <- as.character(activity_labels[2,2])
extractmeansd$Activity[extractmeansd$Activity==3] <- as.character(activity_labels[3,2])
extractmeansd$Activity[extractmeansd$Activity==4] <- as.character(activity_labels[4,2])
extractmeansd$Activity[extractmeansd$Activity==5] <- as.character(activity_labels[5,2])
extractmeansd$Activity[extractmeansd$Activity==6] <- as.character(activity_labels[6,2])
tidydata$Activity <- as.character(tidydata$Activity)
tidydata$Activity[tidydata$Activity==1] <- as.character(activity_labels[1,2])
tidydata$Activity[tidydata$Activity==2] <- as.character(activity_labels[2,2])
tidydata$Activity[tidydata$Activity==3] <- as.character(activity_labels[3,2])
tidydata$Activity[tidydata$Activity==4] <- as.character(activity_labels[4,2])
tidydata$Activity[tidydata$Activity==5] <- as.character(activity_labels[5,2])
tidydata$Activity[tidydata$Activity==6] <- as.character(activity_labels[6,2])

#PART 4: Appropriately label the data set with descriptive variable names
names(tidydata)
names(extractmeansd)
#look descriptive to me


#part 5:
final <- aggregate( . ~Subject + Activity, extractmeansd, mean)
write.table(final,"finaldata.txt",row.names=F)


