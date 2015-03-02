#
#
#

download.projectdata <- function() {
    
    if (!file.exists("./data")) { dir.create("./data") }
    
    if(!file.exists("./data/UCI HAR Dataset")) {
        file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_url, destfile="Data.zip", method="curl", quiet=TRUE)
        unzip(zipfile="Data.zip", exdir="./data")
        unlink("Data.zip")
    }
}

buildTidy <- function() {
    
    # first pass through (from project directory) in shell:
    # cd ./data raw/UCI HAR Dataset
    # cat ./test/X_test.txt ./train/X_train.txt > ../../data temp/X_all.txt
    #
    # then in R:
    # allData <- read.table("data temp/X_all.txt")
    #
    # replaced with following to make less platform dependant.
    
    allData <- read.table("./data raw/UCI HAR Dataset/test/X_test.txt")    
    keepList <- read.table("./data tidy/keep features.txt")    
    
    allData <- allData[,keepList$V1]
    names(allData) <- keepList$V2
    
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
    names(allData) <- keepList$V2
    
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
    
    #     action <- action[,2]
#     
#     allData <- cbind(subjects, action, allData)
#     
#     allData
}

makeSummary <- function(allData) {
    
    summaryTable <- ddply(allData, allData[3:62], mean)
    
    #summaryTable <- aggregate(allData[,3:62], by=allData[c("subject", "activity")], FUN=mean)
    write.table(summaryTable, "summaryByActSubj.txt")
    
    summaryTable
}
