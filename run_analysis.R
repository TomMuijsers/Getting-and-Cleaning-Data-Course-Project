# Load required packages

library(dplyr)


# Store all folder and file paths in variables.
# When the paths, folder names, and/or file names on disk are changed,
# this script can easily be updated.

root_folder_path <- "./UCI HAR Dataset/"

activity_labels_file_path <- paste0(root_folder_path, "activity_labels.txt")
features_file_path <- paste0(root_folder_path, "features.txt")

train_folder_path <- paste0(root_folder_path, "train/")
test_folder_path <- paste0(root_folder_path, "test/")

subject_train_file_path <- paste0(train_folder_path, "subject_train.txt")
X_train_file_path <- paste0(train_folder_path, "X_train.txt")
y_train_file_path <- paste0(train_folder_path, "y_train.txt")

subject_test_file_path <- paste0(test_folder_path, "subject_test.txt")
X_test_file_path <- paste0(test_folder_path, "X_test.txt")
y_test_file_path <- paste0(test_folder_path, "y_test.txt")


# Read the data into data.frames

activity_labels <- read.table(file = activity_labels_file_path)
features <- read.table(file = features_file_path)

subject_train <- read.table(file = subject_train_file_path)
X_train <- read.table(file = X_train_file_path)
y_train <- read.table(file = y_train_file_path)

subject_test <- read.table(file = subject_test_file_path)
X_test <- read.table(file = X_test_file_path)
y_test <- read.table(file = y_test_file_path)


# Add names to data

subject_name <- "Subject"
activity_ID_name <- "Activity_ID"
activity_Label_name <- "Activity_Label"

feature_ID_name <- "Feature_ID"
feature_Label_name <- "Feature_Label"

names(activity_labels) <- c(activity_ID_name, activity_Label_name)
names(features) <- c(feature_ID_name, feature_Label_name)

names(subject_train) <- subject_name
names(X_train) <- features[,2]
names(y_train) <- c(activity_ID_name)

names(subject_test) <- subject_name
names(X_test) <- features[,2]
names(y_test) <- c(activity_ID_name)

# Filter on mean and standard deviation features

mean_std_features <- grepl("(mean|std)\\(\\)", features$Feature_Label)
X_train <- X_train[,mean_std_features]
X_test <- X_test[,mean_std_features]


# Add activity labels to activity IDs

y_train[, activity_Label_name] <-
    activity_labels[match(y_train$Activity_ID, activity_labels$Activity_ID),
                    activity_Label_name]

y_test[, activity_Label_name] <-
    activity_labels[match(y_test$Activity_ID, activity_labels$Activity_ID),
                    activity_Label_name]


# Merge data

train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
total_data <- rbind(train_data, test_data)

# Tidy data

tidy_data <- tbl_df(total_data) %>%
    group_by(Subject, Activity_Label) %>%
    summarise_each(funs(mean), -(Subject:Activity_Label))

names(tidy_data)[-(1:2)] <- paste0("Mean_", names(tidy_data)[-(1:2)])

write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)