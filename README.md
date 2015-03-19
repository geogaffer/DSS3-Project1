## DSS3-Project1
### Project for DSS3 - Getting and Cleaning Data

The contents of this repo were generated in the completion of a 
project assignment for DSS3 - Getting and Cleaning Data.  Thse notes 
describe the data, processsing and products of that assignment. They
are intended to describe some of the subjective thinking behind the 
solution rather than a flat, pragmatic summary.

## Introduction

This assignment uses accelerometer and gyroscopic data collected from
smartphones worn by a number of subjects.  The activity of these subjects
was recorded for the purpose of investigating motion patterns across
activities and subjects.
Data used in the assignment was from the 
<a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine Learning Repository</a>.

Due to the large volume of data it is not stored 
in this Github repository and must be downloaded for each site
where analysis is performed.  

Data was downloaded from:</p>
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
</p> Last accessed: 5 Mar 15

A description of the full dataset is available at the original site: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The project involved creating a clean and tidy subset of the data followed by processing and display of summary.

## Methods

Though provoking concepts in DSS3 have started to influence how we manage data
on mineral exploration projects.  Some of our requirements have filtered into 
DSS projects and as we look at applying the course concepts in industry.  One
example of this is the directory structure used here which is influenced by
multiuser, distributed GIS work we routinely perform.  Directory names mirror 
workflow and version control goals:</p>

1. <b><i>./data raw</b></i></br>
2. <b><i>./data temp</b></i></br>
3. <b><i>./data tidy</b></i></br>
4. <b><i>./data working</b></i></p>

All directory names begin with "data" to keep them adjacent and associated
in a directory listing.  Directories "raw" and "tidy" are controled my the 
project data manager and are read only to others.  Everyone on the project
has directories "temp" and "working" which they own and share read only. 
In addition (but not used here) are "Products Maps" and "Products Graphics"
which hold report or presentation ready products derived from subsets of 
data in working directories.

The R coding 

## Products
 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

