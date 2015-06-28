library(XML)
setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz1')
if (!file.exists("./restaurant.xml")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(url, dest="restaurant.xml", method="curl")
}

doc <- xmlTreeParse('./restaurant.xml', useInternal = T)
root <- xmlRoot(doc)
zips <- xpathSApply(root,"//zipcode", xmlValue )
data <- cbind("pino", zips)
print(head(data[,2]) )
howmany <- which(data[,2] == 21231)
print(length(howmany))