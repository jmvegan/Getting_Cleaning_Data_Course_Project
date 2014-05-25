# unzip files in the work directory from coursera zip file
#import plyr

require(plyr)
library('plyr')

get_data  <- function(folders = 'train'){
  ### Merge data from folders train and test
  ### Argument folder can be test or train (default)
  folder_tmp <- folders
  X_path <- paste0(folder_tmp, '/X_', folder_tmp, '.txt')
  y_path <- paste0(folder_tmp, '/y_', folder_tmp, '.txt')
  path_subject <-paste0(folder_tmp, '/subject_', folder_tmp, '.txt')
 
  # read files and put info in tables X, y
  # directory/X_.txt': Data set.
  # directory/y_.txt': Data labels.
  
  X <- read.table(X_path, header = F)
  y <- read.table(y_path, header = F,  sep = ' ')
  
  # 'subject': identifier of the subject who carried out the experiment.
  
  subject <- read.table(path_subject, header = F,  sep=' ')
  colnames(subject) <- 'subject'
  
  #  'features.txt': List of all features.
  
  feature_names <-
    read.csv2(paste0('features.txt'), sep=' ', header = F)
  
  # the description name of each feature is in the 2nd column
  
  colnames(X) <- feature_names[, 2]
  colnames(y) <- 'y'
  
  return(data.frame(subject = subject, y = y, X))
}

# Import into separate data frames the train and test data sets
# Merge  both data frames using rbind()

Train_dataset <- get_data('train')
Test_dataset <- get_data('test')
DF_data <- rbind(Train_dataset, Test_dataset)
dim(DF_data)
head(DF_data)

# Extract only the mean and standard deviation for each measures. I use pattern matching with grep

col_data <- colnames(DF_data)
id_mean_std <- grep('mean[^F]|std', col_data, ignore.case = T)

# Truncated vector in order to ignore the angle

DF_tmp1 <- DF_data[, c(1, 2, id_mean_std[1:66])]

# I use ddply() Split data frame , calculate a function with the mean to each column
# and return results in a data frame

calc_mean_Col <- function(x){unlist(lapply(x, mean, na.rm = T))}

DF_tmp2 <- ddply(DF_tmp1, .(subject, y),calc_mean_Col)
  
exercise <- read.csv('activity_labels.txt',sep = ' ', header = F)
DF_tmp2$y <- exercise[DF_tmp2$y, 2]
colnames(DF_tmp2)[2] <- 'activity'
write.csv(DF_tmp2, file = 'tidy_Samsung.csv')
