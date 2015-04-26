library(dplyr)
library(tidyr)

root.data.folder = "UCI\ HAR\ Dataset/"

# Read in the feature names
features = read.table(paste(root.data.folder, "features.txt", sep=""))
features.names = as.character(features[ , 2])

# Read in the test data and activity labels
test.data.set = read.table(paste(root.data.folder, "test/X_test.txt", sep=""), col.names=features.names)
test.data.set.activities = read.table(paste(root.data.folder, "test/y_test.txt", sep=""))
test.data.set.subject = read.table(paste(root.data.folder, "test/subject_test.txt", sep=""))
test.data.set$activityLabelNumber = test.data.set.activities[, 1]
test.data.set$subjectLabel = test.data.set.activities[ , 1]

#Read in the training data and activity labels
train.data.set = read.table(paste(root.data.folder, "train/X_train.txt", sep=""), col.names=features.names)
train.data.set.activities = read.table(paste(root.data.folder, "train/y_train.txt", sep=""))
train.data.set$activityLabelNumber = train.data.set.activities[, 1]
train.data.set.subject = read.table(paste(root.data.folder, "train/subject_test.txt", sep=""))
train.data.set$subjectLabel = train.data.set.activities[ , 1]

# Combine the two data sets
total.data.set <- rbind(test.data.set, train.data.set)

# Read in the activity labels
activity.labels = read.table(paste(root.data.folder, "activity_labels.txt", sep=""), col.names=c("activityLabelNumber", "activityLabel"))

# Reshape the data set to make it skinny
final.data.set <- total.data.set %>%
  left_join(activity.labels, by="activityLabelNumber") %>%
  select(activityLabel, subjectLabel, contains("mean"), contains("std")) %>%
  gather(measurement.name, measurement.value, everything(), -activityLabel, -subjectLabel)

step.five = <- final.data.set <- %>% 
  group_by(subjectLabel, activityLabel, measurment.name) %>%
  summarize(average.value=mean(measurement.value))
