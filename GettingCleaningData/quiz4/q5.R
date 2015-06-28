library(quantmod)
library(lubridate)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)


sampleDates <- ymd(sampleTimes)

only2012 <- sampleDates[which(year(sampleDates) == 2012)]
only2012Sundays <- only2012[which(wday(only2012) == 2)]