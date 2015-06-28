library(data.table)
if (!file.exists("./gdp.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url, dest="gdp.csv", method="curl")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(url, dest="countries.csv", method="curl")
}

gdp <- read.csv(file="./gdp.csv")
countries <- read.csv(file="./countries.csv")

merged <- merge(gdp,countries, by.x = "X", by.y = "CountryCode")

length(grep("Fiscal year end: June 30", merged$Special.Notes))
