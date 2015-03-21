## DSS3-Project1
### Project for DSS3 - Getting and Cleaning Data

The contents of this repo were generated in the completion of a 
project assignment for DSS3 - Getting and Cleaning Data.  These notes 
describe the data, processsing and products of that assignment. They
are intended to describe some of the subjective thinking behind the 
solution rather than a flat, pragmatic summary.

## Introduction

This assignment uses accelerometer and gyroscope data collected from
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
</p> <i>Last accessed: 5 Mar 15</i>

A description of the full dataset is available at the original site: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and 
in a thesis (Reyes Ortiz, 2014) located at http://www.tdx.cat/handle/10803/284725 </p>

The DSS3 project involved creating a clean and tidy subset of the data followed by 
processing and display of a summary table of means grouped by subject and activity, 
which itself forms a tidy data set.  The data subset included only those variable 
from the original data that are "means" or "standard deviations".

## Methods

Thought provoking concepts in DSS3 have started to influence how I manage data
on projects with junior mineral exploration companies.  Conversely, some of our 
styles at work have filtered into how I implement DSS project solutions.  One
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

The R coding style uses functions to build logical parts of the assignment.
R code is in <b>run_analysis.R</b> with 
command line style script to apply the functions and complete the assignment
goals at the end of the file.  (They might be commented out.  I tend to do that 
when I'm debugging, but still keep them there as comments to indicate how to
used the code.  I find that for me function are more reusable than source() 
scripts.  Reusable tools are essential for effective use on projects - for me, 
typically geochemical interpretation as lab data is coming in while we are still 
in the field.</p>

####Downloading Data

Data is downloaded from the source site if needed by <b>download.projectdata()</b>
which takes no arguments.  A very simple check is made to decide if the data should
be downloaded - a longish operation that shold be avoided if not needed.  The existence
of a directory <i>./data raw/UCI HAR Dataset</i> is used to indicate that the data is
available.  If the directory does not exist then the data is downloaded from the 
source site as a zip file and extracted into <i>./data raw/UCI HAR Dataset</i>.  In
addition, checks are made for the other standard directories (this is a local
convention and not part of the DSS3 assigned project).</p>

####Building the Tidy Data

A data frame meeting the requirements of tidy data is returned by <b>build.tidy()</b>.
The function does not take arguments, but assumes data is located in 
<i>./data raw/UCI HAR Dataset</i> and subdirectories.</p>

Prior to processing, a copy of <i>./data raw/UCI HAR Dataset/features.txt</i> was edited
manually to form a list of those fields that should be kept in the project subset.  
Rows relating to fields not being kept were deleted.  Original variable names were found 
to not be R friendly for some packages and new names were selected.  The new file was 
stored as <i>./ data tidy/keep features.txt</i> and is useful as a record of which original
variables were used in the subset.</p>

Test data is read from <i>./data raw/UCI HAR Dataset/test/X_test.txt</i> and the list of 
variables to keep from <i>./ data tidy/keep features.txt</i>.  Columns are selected from 
the test data using the first column of the keep list and the columns are then named using the third colum of the keep list (the new names).  The action and subject parameters
are then read from <i>./data raw/UCI HAR Dataset/test/y_test.txt</i> and
<i>./data raw/UCI HAR Dataset/test/subject_test.txt</i> and these are bound as colunns to 
the a cases data frame.  Names of the respective action codes are read from 
<i>./data raw/UCI HAR Dataset/activity_labels.txt</i> and merged with the cases frame
using the action code.  With a column containing human readable action names the code column
is deleted and the two case describing columns bound to the subset of 60 variables.
This process is repeated for the training data in <i>./data raw/UCI HAR Dataset/train</i>
and the two sets combined row wise.  The result is returned by the function.</p>

####Making the Summary Table of Means

A summary table is generated by <b>make.summary(allData)</b> which takes the data frame
with previously created subset as an argument.  The function uses aggregate() to 
calculate averages for each combination of subject and action.  These are saved to
<i>./summaryByActSubj.txt</i> and also returned.

