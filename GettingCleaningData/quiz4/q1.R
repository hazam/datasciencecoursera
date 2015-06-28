library(data.table)
if (!file.exists("./housingidaho.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, dest="housingidaho.csv", method="curl")
}
DT <- read.csv(file="./housingidaho.csv")

