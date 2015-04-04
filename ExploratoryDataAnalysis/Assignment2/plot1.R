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
NEI <- loadData()

years <- c(1999, 2002, 2005, 2008)
YRS <- subset(NEI, is.element(year, years))

summation <- tapply(YRS$Emissions, YRS$year, sum)

png(filename = "plot1.png", width = 600, height = 600, bg =rgb(0,0,0,0))
#barplot seems fine
barplot(summation, xlab="Year", ylab="Total PM", ylim=c(0,10000000), yaxt="n")
axis(1,at=years)
#trying to get readable labels
axis(2,at=c(0,3000000,6000000,9000000), labels=c("0", "3M", "6M", "9M"))
dev.off()