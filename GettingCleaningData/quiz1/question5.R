library(XML)
setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz1')
if (!file.exists("./housingidaho.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(url, dest="housingidaho.csv", method="curl")
}

DT <-fread(input="./housingidaho.csv")
#print(head(DT))
time <- system.time( replicate(100, sapply(split(DT$pwgtp15,DT$SEX),mean) ) )
print(time)
print(sapply(split(DT$pwgtp15,DT$SEX),mean))

means <-function() {
    c(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
}
time <- system.time(replicate(100, means() ) )
print(time)
print(means())

time <- system.time(replicate(100,DT[,mean(pwgtp15),by=SEX]))
print(time)
print(DT[,mean(pwgtp15),by=SEX])

time <- system.time(replicate(100,tapply(DT$pwgtp15,DT$SEX,mean)))
print(time)
print(tapply(DT$pwgtp15,DT$SEX,mean))