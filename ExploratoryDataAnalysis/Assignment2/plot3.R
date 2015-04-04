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
    data <- readRDS("summarySCC_PM25.rds")
    data
}
PM25 <- loadData()
years <- 1999:2008
fips.baltimore <- "24510"

# pick only the relevant years, 1999 to 2008
YRS <- subset(PM25, is.element(year, years) & fips == fips.baltimore)


#factorizing type
YRS$type <- factor(YRS$type)
#this puts all factor names inlowecase and alphanumeric only
types <- sapply(levels(YRS$type), function(x) str_replace_all(tolower(x), "[^[:alnum:]]", ""))
#this puts all factor names inlowecase and alphanumeric only
levels(YRS$type) <- types

extractRows <- function(data, pollutantType) {
    #get only data about a single type
    dataSubset <- subset(data, type == pollutantType)
    #adding all emissions up, for each year
    summa <- tapply(dataSubset$Emissions, dataSubset$year, sum)
    #rebuilding at table
    summa <- cbind(rownames(summa), pollutantType, summa)
    #names on items are annoying
    rownames(summa) <- NULL
    # at this point, the matrix looks like
    #            pollutantType summa          
    #[1,] "1999" "point"       "296.795"      
    #[2,] "2002" "point"       "569.26"       
    #[3,] "2005" "point"       "1202.49"      
    #[4,] "2008" "point"       "344.975183943"
    summa
} 
# set type as factor (label)
applied <- lapply(types, function(t) extractRows(YRS, t))

# creating a proper data frame, since
# looks the ggplot can only work with those
data.df <- data.frame(do.call("rbind", applied) , stringsAsFactors = FALSE)
names(data.df) <- c("year","type", "emission")

#number-izing some of the columns to enable proper plotting
data.df$year <- as.integer(data.df$year)
data.df$emission <- as.numeric(data.df$emission)

#plotting (about time)
a <- ggplot(data = data.df, aes(x = year, y = emission, colour = type))
a <- a + geom_line()
ggsave(file="plot3.png", width=6.0, height=3.0)
print(a)
