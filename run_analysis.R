#  DSS3 - Getting and Cleaning Data 
#  Code for course project
#  J Harrop

#  This file contains a combination of functions followed by commands that
#  would be executed on source() to generate what is needed for the project.
#  (These lines may be commented out so they can be run manually from the 
#  command line for debugging.)  I'm still getting used to the best mix
#  of functions versus sourcing a script in R that enhances readability.

download.projectdata <- function() {
    
    # create directory for raw data is needed.  This should hold only data as
    # received, prior to any local processing.
    
    if (!file.exists("./data raw")) { dir.create("./data raw") }
    
    # This style file structure comes from how we set up work flow
    # in my companies - with some influance from the DSS course.
    
    # The directories in the local data flow are, in order of flow:
    # raw -> temp -> tidy -> working (with "data" inserted before 
    # each name to keep them together in an ls.)  Raw and tidy are 
    # effectively read only except for the data manager.  Temp holds work
    # during cleaning until a tidy (and frozen) version is ready.
    # Working holds the filtered selections from tidy data for specific
    # tasks.  If multiuser the working directory could be the user name.
    
    if (!file.exists("./data temp")) { dir.create("./data temp") }
    if (!file.exists("./data tidy")) { dir.create("./data tidy") }
    if (!file.exists("./data working")) { dir.create("./data working") }
    
    # Check if the raw data appears to be on disk.  Downloading is a long(ish) 
    # operation that is worth avoiding if already completed.  This is a 
    # simplistic check and could use...
    # TODO: add more complete check for downloaded data.
    
    if(!file.exists("./data raw/UCI HAR Dataset")) {
        file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_url, destfile="Data.zip", method="curl", quiet=TRUE)
        unzip(zipfile="Data.zip", exdir="./data raw")
        unlink("Data.zip")  # no need to keep both zipped and unzipped data
    }
}

build.tidy <- function() {
    
    # Prior to running build.tidy() 
    
    allData <- read.table("./data raw/UCI HAR Dataset/test/X_test.txt")    
    keepList <- read.table("./data tidy/keep features.txt")    
    
    allData <- allData[,keepList$V1]
    names(allData) <- keepList$V3
    
    action <- read.table("./data raw/UCI HAR Dataset/test/y_test.txt")
    names(action) <- "code"    
   
    subjects <- read.table("./data raw/UCI HAR Dataset/test/subject_test.txt")
    names(subjects) <- "subject"
    
    cases <- cbind(subjects, action)
    
    activity <- read.table("./data raw/UCI HAR Dataset/activity_labels.txt")
    names(activity) <- c("code", "activity")
    
    cases2 <- merge(cases, activity, by="code", all.x=TRUE, sort=FALSE)
    
    cases2[1] <- NULL
    
    readyData <- cbind(cases2, allData)
    
    #------------------------------------------------------------------------------
    
    allData <- read.table("./data raw/UCI HAR Dataset/train/X_train.txt")    
    #keepList <- read.table("./data tidy/keep features.txt")    
    
    allData <- allData[,keepList$V1]
    names(allData) <- keepList$V3
    
    action <- read.table("./data raw/UCI HAR Dataset/train/y_train.txt")
    names(action) <- "code"    
    
    subjects <- read.table("./data raw/UCI HAR Dataset/train/subject_train.txt")
    names(subjects) <- "subject"
    
    cases <- cbind(subjects, action)
    
    #activity <- read.table("./data raw/UCI HAR Dataset/activity_labels.txt")
    #names(activity) <- c("code", "activity")
    
    cases2 <- merge(cases, activity, by="code", all.x=TRUE, sort=FALSE)
    
    cases2[1] <- NULL
    
    readyData2 <- cbind(cases2, allData)
    
    rbind(readyData, readyData2)
}


make.summary <- function(allData) {
    
    library(plyr)
    
    #summaryTable <- ddply(allData, allData[3:62], mean)
    
    summaryTable <- aggregate(allData[,3:62], by=allData[c("subject", "activity")], FUN=mean)
    write.table(summaryTable, "summaryByActSubj.txt", row.name=FALSE)
    
    summaryTable
}


# main() code here to perform the assignment task.

# download.projectdata()
# allData <- build.tidy()
# make.summary(allData)
