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
years <- seq(1999, 2008, 3)

#getting only the Baltimore ones
YRS <- subset(NEI, is.element(year, years) & fips == "24510")
summation <- tapply(YRS$Emissions, YRS$year, sum)


png(filename = "plot2.png", width = 600, height = 600, bg =rgb(0,0,0,0))
#barplot looks fine to plot the "amount" of PM2.5 in a simple viz
barplot(summation, 10 , xlab="Year", ylab="Total PM In baltimore", ylim=c(0,3500), yaxt="n")
axis(1,at=years)
#trying to get readable labels
axis(2,at=c(0,3000000,6000000,9000000), labels=c("0", "3M", "6M", "9M"))
dev.off()