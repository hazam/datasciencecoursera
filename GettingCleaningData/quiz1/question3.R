library(xlsx)

setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz1')
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, dest="gas.xlsx", method="curl")

colIndex <- 7:15
rowIndex <- 18:23

dat <- read.xlsx(file="./gas.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)

print(sum(dat$Zip*dat$Ext,na.rm=T))