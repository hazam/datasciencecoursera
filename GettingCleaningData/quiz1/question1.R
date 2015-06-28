source('~/workspace/datasciencecoursera/GettingCleaningData/quiz1')
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, dest="houses.csv", method="curl")
data <- read.csv(file="houses.csv")
print( length(which(data$VAL=='24')) )
