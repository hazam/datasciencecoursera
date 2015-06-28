library(dplyr)

#reading in all the data
X_test <- tbl_df(read.table("./data/test/X_test.txt"))
Y_test <- tbl_df(read.table("./data/test/y_test.txt"))
subject_test <- tbl_df(read.table("./data/test/subject_test.txt"))
X_train <- tbl_df(read.table("./data/train/X_train.txt"))
Y_train <- tbl_df(read.table("./data/train/y_train.txt"))
subject_train <- tbl_df(read.table("./data/train/subject_train.txt"))
features <- tbl_df(read.table("./data/features.txt"))

#assign the right label for the colums
names(X_test) <- features$V2
names(X_train) <- features$V2

#get only columns with "mean()" or "std()" in the name
onlyCol <- grep("mean\\(\\)|std\\(\\)",names(X_test))

#wasn't possible to use select due to malformed column names
X_test <- tbl_df(X_test[,onlyCol])
X_train <- tbl_df(X_train[,onlyCol])


#packing all togheter with reasonalbe labels
testSet <- bind_cols(subject_test, Y_test, X_test)
trainSet <- bind_cols(subject_train, Y_train, X_train)
names(testSet)[1:2] <- c("Subject", "Activity")
names(trainSet)[1:2] <- c("Subject", "Activity")
fullSet <- bind_rows(testSet, trainSet)

#Subject is not really an int
fullSet <- mutate(fullSet, Subject = as.factor(Subject))

#Labeling Activities
activity_labels <- tbl_df(read.table("./data/activity_labels.txt"))
fullSet <- merge(fullSet, activity_labels, by.x = "Activity", by.y = "V1")
fullSet <- mutate(fullSet, Activity = V2)
fullSet <- select(fullSet, -V2)

#Group by Subject and Activity
fullSet <- group_by(fullSet, Subject, Activity)
#compute for each column the mean (summarise takes care of doing it group-wise)
summary <- summarise_each(fullSet, funs(mean))

#fixing the column names a bit
names(summary)<- gsub(pattern = "\\.+", replacement = "\\.", x = tolower(make.names(names(summary))))

#done, flushing out data
write.table(summary, "output.txt", row.name=FALSE)
