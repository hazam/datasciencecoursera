library(data.table)
if (!file.exists("./gdp.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url, dest="gdp.csv", method="curl")
}
DT <- read.csv(file="./gdp.csv")
n <- gsub(",", "", DT$X.3[-(0:4)])
integerized <- rm.na(as.integer(n[0:190]))
mean <- mean(integerized)

numberOfStatesThatstartWithUnited <- grep("^United",DT$X.2)