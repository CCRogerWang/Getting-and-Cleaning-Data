#1. Merges the training and the test sets to create one data set.
setwd("D:\\R learning\\Getting and Cleaning Data\\project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train")
train_x <- read.table("X_train.txt")
train_y <- read.table("y_train.txt")
train_s <- read.table("subject_train.txt")

setwd("D:\\R learning\\Getting and Cleaning Data\\project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test")
test_x <- read.table("X_test.txt")
test_y <- read.table("y_test.txt")
test_s <- read.table("subject_test.txt")

mTrain <- cbind.data.frame(train_x,train_y)
mTrain <- cbind.data.frame(mTrain,train_s)

mTest <- cbind.data.frame(test_x,test_y)
mTest <- cbind.data.frame(mTest,test_s)

mData <- rbind.data.frame(mTrain,mTest)

#4. Appropriately labels the data set with desmcriptive variable names.
setwd("D:\\R learning\\Getting and Cleaning Data\\project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")
m_feature <- read.table("features.txt")
m_fm_flbl<-m_feature[,2]
colnames(mData) <- m_fm_flbl
colnames(mData)[562] <- "Label"
colnames(mData)[563] <- "Subject"

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
setwd("D:\\R learning\\Getting and Cleaning Data\\project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")
f_txt <- read.table("features.txt")
matchS <- c("mean()", "std()")
idx_MeanStd <- grep(paste(matchS,collapse="|"), f_txt$V2)
idx_MeanStd <- c(idx_MeanStd,562,563)
m2Step<-mData[,idx_MeanStd]

#3. Uses descriptive activity names to name the activities in the data set
act_lbl <- read.table("activity_labels.txt")
lv <- act_lbl[,1]
lbl <- act_lbl[,2]
tmpCol_1 <- dim(m2Step)[2]
m2Step[,tmpCol_1-1] <- factor(m2Step[,tmpCol_1-1],levels = lv,labels = lbl)



#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.csv(m2Step, 'data.csv')
