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
    #grepping over "coal" for a bunch of columns
    fields <- c("Short.Name", "EI.Sector", "SCC.Level.One", "SCC.Level.Two", "SCC.Level.Three", "SCC.Level.Four")
    indexes <- do.call("c", sapply(fields, function(x) grep("motor", ignore.case = T, data[,x])))
    
    #just normal massage
    indexes <- unique(indexes)
    indexes <- indexes[order(indexes)]
    ids <- data[indexes, "SCC"]
    ids
}

years <- seq(1999, 2008, 1)
SCCids <- extractMotorSCC(SCC)
fips.baltimore <- "24510"

#getting all data (no matter the location fips) for the relevant years
# and for the SCC that are related to Coal
YRS <- subset(PM25, is.element(year, years) & fips == fips.baltimore & SCC %in% SCCids)

YRS$type <- factor(YRS$type)
#this puts all factor names inlowecase and alphanumeric only
types <- sapply(levels(YRS$type), function(x) str_replace_all(tolower(x), "[^[:alnum:]]", ""))
levels(YRS$type) <- types

extractRows <- function(dataSubset) {
    summa <- tapply(dataSubset$Emissions, dataSubset$year, sum)
    summa <- cbind(rownames(summa), summa)
    rownames(summa) <- NULL
    colnames(summa) <- c("year", "emission")
    summa
} 
#set type as factor (label)
applied <- extractRows(YRS)
data.df <- data.frame(applied , stringsAsFactors = FALSE)
data.df$year <- as.integer(data.df$year)
data.df$emission <- as.numeric(data.df$emission)

#usual plot
a <- ggplot(data = data.df, aes(x = year, y = emission))
a <- a + geom_line()
ggsave(file="plot5.png", width=6.0, height=3.0)
print(a)
