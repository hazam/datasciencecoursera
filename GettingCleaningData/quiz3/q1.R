library(dplyr)
library(XML)
setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz3')
if (!file.exists("./housingidaho.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, dest="housingidaho.csv", method="curl")
}
housing <- tbl_df(read.csv("./housingidaho.csv"))

agricultureLogical <- ifelse(housing$ACR == 3 & housing$AGS == 6, TRUE, FALSE)

print(housing)
print(which(agricultureLogical))

