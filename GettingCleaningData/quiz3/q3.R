library(dplyr)
library(jpeg)
library(Hmisc)
setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz3')
if (!file.exists("./gdp.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url, dest="gdp.csv", method="curl")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(url, dest="country.csv", method="curl")
}

gdp <-  tbl_df(read.csv("./gdp.csv", stringsAsFactors = F)) %>%
        filter(nchar(X) > 0, Gross.domestic.product.2012 > 0) %>%
        mutate(GDP = as.integer(Gross.domestic.product.2012))
country <- tbl_df(read.csv("./country.csv"))

#print(gdp)
#print(country)

#Q3
merged <- merge(gdp, country, by.x = "X", by.y="CountryCode", all = T)
merged <- arrange(merged, desc(GDP))
print("13th")
print(merged[13,"Long.Name"])

#Q4
grouped <- merged %>%
        filter(!is.na(GDP)) %>%
        group_by(Income.Group)

#Q5
quanti <- cut(merged$GDP, breaks = 5)
merged <- mutate(merged, quanti = quanti)
print(table(merged$quanti, merged$Income.Group))