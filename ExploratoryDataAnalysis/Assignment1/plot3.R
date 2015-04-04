loadData <- function() {
    columns <- c(rep('character',2), rep('numeric', 7))
    power <- read.table('household_power_consumption.txt', sep = ';', 
                        header = TRUE, stringsAsFactors = FALSE)
    power <- subset(power, Date == '1/2/2007' | Date == '2/2/2007')
    sapply(3:9, function(i) {
        power[,i] <<- as.numeric(power[,i])
    })
    moments <- paste(power[,1], power[,2])
    parsedMoments <- strptime(moments, '%d/%m/%Y %H:%M:%S')
    cbind(parsedMoments, power[3:9])
}

plot3 <- function(data, toFile = FALSE) {
    if (toFile) png(filename = "plot3.png", width = 480, height = 480, bg =rgb(0,0,0,0))
    plot(data[,1], data[,6], type="n", xlab="", ylab="Energy sub metering")
    lines(data[,1], data[,6])
    lines(data[,1], data[,7], col = "red")
    lines(data[,1], data[,8], col = "blue")
    legend("topright",legend=names(data)[6:8], col=c("black", "red", "blue"), lty=c(1,1))
    if (toFile) dev.off()
}

power <- loadData()
plot3(power, TRUE)