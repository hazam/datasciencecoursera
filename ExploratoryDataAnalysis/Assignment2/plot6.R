library(ggplot2)
library(stringr)

## GENERAL ASSUMPTION is that you have the data files
##
## summarySCC_PM25.rds
## Source_Classification_Code.rds
##
## unpacked in the current working directory

# this function is useful to encapsulate 
# data loading process which can be slow, so I can iterate
# faster to achieve the right plot
loadData <- function() {
    readRDS("summarySCC_PM25.rds")
}
PM25 <- loadData()

#this is fast to load
SCC <- readRDS("Source_Classification_Code.rds")

#get all relevant SCCs
extractMotorSCC <- function(data) {
    #get only data about a single type
    dataSubset <- subset(data)
    #grepping over "coal" for a bunch of columns
    fields <- c("Short.Name", "EI.Sector", "SCC.Level.One", "SCC.Level.Two", "SCC.Level.Three", "SCC.Level.Four")
    indexes <- do.call("c", sapply(fields, function(x) grep("motor", ignore.case = T, dataSubset[,x])))
    
    #just normal massage
    indexes <- unique(indexes)
    indexes <- indexes[order(indexes)]
    ids <- data[indexes, "SCC"]
    ids
}
years <- seq(1999, 2008, 1)
SCCids <- extractMotorSCC(SCC)
fips.baltimore <- "24510"
fips.lacounty <- "06037"

#getting all data (no matter the location fips) for the relevant years
# and for the SCC that are related to Coal
YRS <- subset(PM25, is.element(year, years) & (fips == fips.baltimore | fips == fips.lacounty) & SCC %in% SCCids)

YRS$type <- factor(YRS$type)
#this puts all factor names inlowecase and alphanumeric only
types <- sapply(levels(YRS$type), function(x) str_replace_all(tolower(x), "[^[:alnum:]]", ""))
levels(YRS$type) <- types

extractRows <- function(data, place) {
    #get only data about a single type
    dataSubset <- subset(data, fips == place)
    #adding all emissions up, for each year
    summa <- tapply(dataSubset$Emissions, dataSubset$year, sum)
    #rebuilding at table
    summa <- cbind(rownames(summa), place, summa)
    #names on items are annoying
    rownames(summa) <- NULL
    colnames(summa) <- c("year", "fips", "emission")
    summa
} 
#set type as factor (label)
rowsBaltimore <- extractRows(YRS, fips.baltimore)
rowsLacounty <- extractRows(YRS, fips.lacounty)
applied <- rbind(rowsBaltimore, rowsLacounty)
data.df <- data.frame(applied , stringsAsFactors = FALSE)
data.df$year <- as.integer(data.df$year)
data.df$emission <- as.numeric(data.df$emission)
data.df$fips <- as.factor(data.df$fips)
levels(data.df$fips) <- c("LA County", "Baltimore")
#usual plot
a <- ggplot(data = data.df, aes(x = year, y = emission, color = fips))
a <- a + geom_line()
ggsave(file="plot6.png", width=6.0, height=3.0)
print(a)
