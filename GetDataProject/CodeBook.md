# Getting and Cleaning Data: course project CodeBook

The final project summarizes and tidy the data into a table exported in the file `output.txt`. This document is the Code Book for the summarized data.

The summarized data reports the average and standard deviation values of the various acceleromenter data sources, grouped by the **subject** that performed the test and the **activity** that was manually labeled corresponding to that data set.

The data set was meant to be used in a Machine Learning competition/set up, so it is defined in terms of *features* and *labels*, and it was split into a train and test set.

As a part of this analysis, all data was gathered and analyzed together.

Here following the full explanation of the 68 columns names and meaning:

* `subject` the subject ID that performed the test. Served as a factor, since numerical value doesn't really make sense
* `activity` the readable activity label assigned manually to the user performing the test

All the columns starting with "t" denote raw values sampled at a 50 hz frequency

* `tbodyacc.mean.x` mean accelerometer data of the body over x
* `tbodyacc.mean.y` mean accelerometer data of the body over y
* `tbodyacc.mean.z` mean accelerometer data of the body over z
* `tbodyacc.std.x` stddev of accelerometer data of the body over x            
* `tbodyacc.std.y` stddev of accelerometer data of the body over y 
* `tbodyacc.std.z` stddev of accelerometer data of the body over z
* `tgravityacc.mean.x` mean gravity accel over x
* `tgravityacc.mean.y` mean gravity accel over y
* `tgravityacc.mean.z` mean gravity accel over z
* `tgravityacc.std.x` stddev of gravity accel over x        
* `tgravityacc.std.y` stddev of gravity accel over y
* `tgravityacc.std.z` stddev of gravity accel over z
* `tbodyaccjerk.mean.x` (not really sure if it makes sense to go on)
* `tbodyaccjerk.mean.y` [...]
* `tbodyaccjerk.mean.z` [...]
* `tbodyaccjerk.std.x` [...]
* `tbodyaccjerk.std.y` [...]
* `tbodyaccjerk.std.z` [...]
* `tbodygyro.mean.x` [...]
* `tbodygyro.mean.y` [...]
* `tbodygyro.mean.z` [...]
* `tbodygyro.std.x` [...]           
* `tbodygyro.std.y` [...]
* `tbodygyro.std.z` [...]
* `tbodygyrojerk.mean.x` [...]
* `tbodygyrojerk.mean.y` [...]
* `tbodygyrojerk.mean.z` [...]
* `tbodygyrojerk.std.x`  [...]      
* `tbodygyrojerk.std.y` [...]
* `tbodygyrojerk.std.z` [...]
* `tbodyaccmag.mean.` [...]
* `tbodyaccmag.std.` [...]
* `tgravityaccmag.mean.` [...]
* `tgravityaccmag.std.` [...]       
* `tbodyaccjerkmag.mean.` [...]
* `tbodyaccjerkmag.std.` [...]
* `tbodygyromag.mean.` [...]
* `tbodygyromag.std.` [...]
* `tbodygyrojerkmag.mean.` [...]
* `tbodygyrojerkmag.std.` [...]

All the columns starting with "f" denote frequency values computed via Fast Fourier Transform
    
* `fbodyacc.mean.x` [...]
* `fbodyacc.mean.y` [...]
* `fbodyacc.mean.z` [...]
* `fbodyacc.std.x` [...]
* `fbodyacc.std.y` [...]
* `fbodyacc.std.z`   [...]          
* `fbodyaccjerk.mean.x` [...]
* `fbodyaccjerk.mean.y` [...]
* `fbodyaccjerk.mean.z` [...]
* `fbodyaccjerk.std.x` [...]
* `fbodyaccjerk.std.y` [...]
* `fbodyaccjerk.std.z`  [...]       
* `fbodygyro.mean.x` [...]
* `fbodygyro.mean.y` [...]
* `fbodygyro.mean.z` [...]
* `fbodygyro.std.x` [...]
* `fbodygyro.std.y` [...]
* `fbodygyro.std.z`  [...]          
* `fbodyaccmag.mean.` [...]
* `fbodyaccmag.std.` [...]
* `fbodybodyaccjerkmag.mean.` [...]
* `fbodybodyaccjerkmag.std.` [...]
* `fbodybodygyromag.mean.` [...]
* `fbodybodygyromag.std.`  [...]    
* `fbodybodygyrojerkmag.mean.` [...]
* `fbodybodygyrojerkmag.std.` [...]