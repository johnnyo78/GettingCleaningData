# Download and unzip the data. Store the timestamp of the data download
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
download.file(url, destfile = "./data/data.csv");
dateDownloaded <- date();
unzip("./data/data.csv");

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="SubjectID");
#x_train <- read.table("./UCI HAR Dataset/train/X_train.txt");
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="ActivityID");
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="SubjectID");
#x_test <- read.table("./UCI HAR Dataset/test/X_test.txt");
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="ActivityID");
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("ActivityID","ActivityName"));

# The features file looks to be the features in the data; Let's assign these as headers
features <- read.table("./UCI HAR Dataset/features.txt");
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

# Filter the data for mean and standard deviation by grepping the header rows
interestingCols <- grep("mean\\(\\)|std\\(\\)",names(x_train))
interesting_train <- x_train[,interestingCols]
interestingCols <- grep("mean\\(\\)|std\\(\\)",names(x_test))
interesting_test <- x_test[,interestingCols]

# Merge subject ID and activity columns at the front of each dataset
complete_train<-cbind(subject_train,y_train,interesting_train)
complete_test<-cbind(subject_test,y_test,interesting_test)

# We should merge the test datasets and training datasets using rebind
merged <- rbind(complete_train,complete_test)
# Then add/merge descriptive names for the activity ids
complete_merged<-merge(activity_labels,merged,sort=FALSE)

# Fix some header names to be more readable
# Then add these nice user-friendly names back to the data frame
temp1 <- sub("^t","Time",names(complete_merged))
temp2 <- sub("^f","FFT",temp1)
temp3 <- sub("-mean","Mean",temp2)
temp4 <- sub("-std","StdDev",temp3)
temp5 <- sub("\\(\\)","",temp4)
temp6 <- sub("Acc","Accel",temp5)
names(complete_merged) <- temp6

# Finally produce tidy datasets summarizing by activity first and subject second
dmelt <- melt(complete_merged,id=c("ActivityID","ActivityName","SubjectID"), measure.vars=names(complete_merged[4:69]))
dcast <- dcast(dmelt,ActivityName+SubjectID~variable,mean)
# Write the output to file
write.table(dcast,"output.txt", row.names=FALSE)