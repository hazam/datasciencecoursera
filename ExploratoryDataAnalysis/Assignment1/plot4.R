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

plot4 <- function(data, toFile = FALSE) {
    if (toFile) png(filename = "plot4.png", width = 480, height = 480, bg =rgb(0,0,0,0))
    par(mfrow = c(2,2))
    plot(data[,1], data[,2], type = "l",
         ylab = "Global Active Power",
         xlab = "")
    plot(data[,1], data[,4], type = "l", ylab=names(data)[4], xlab = "datetime")
    plot(data[,1], data[,6], type="n", xlab="", ylab="Energy sub metering")
    lines(data[,1], data[,6])
    lines(data[,1], data[,7], col = "red")
    lines(data[,1], data[,8], col = "blue")
    legend("topright",legend=names(data)[6:8], col=c("black", "red", "blue"), lty=c(1,1))
    
    plot(data[,1], data[,3], type = "l", ylab=names(data)[3], xlab = "datetime")
    if (toFile) dev.off()
}

power <- loadData()
plot4(power, TRUE)