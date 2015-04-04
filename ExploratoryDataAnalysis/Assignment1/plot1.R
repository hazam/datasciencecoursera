loadData <- function() {
    columns <- c(rep('character',2), rep('numeric', 7))
    power <- read.table('household_power_consumption.txt', sep = ';', 
                        header = TRUE, stringsAsFactors = FALSE)
    power <- subset(power, Date == '1/2/2007' | Date == '2/2/2007')
    sapply(3:9, function(i) {
        power[,i] <<- as.numeric(power[,i])
    })
    power
}

plot1 <- function(data, toFile = FALSE) {
    if (toFile) png(filename = "plot1.png", width = 480, height = 480, bg =rgb(0,0,0,0))
    hist(data[,3], xlim = c(0,6), main = "Global Active Power", 
         col = 'red', xlab = 'Global Active Power (kilowatts)', freq = TRUE,
         xaxp  = c(0, 6, 3))
    if (toFile) dev.off()
}

power <- loadData()
plot1(power, TRUE)