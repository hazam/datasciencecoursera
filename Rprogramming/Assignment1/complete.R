complete <- function(directory, id = 1:332) {
    result <- data.frame() 
    for (idx in id) {
        fileName = paste(directory, "/", sprintf("%03d", idx), ".csv", sep="")
        data <- read.csv(fileName)
        data <- subset(data, !is.na(nitrate) & !is.na(sulfate))
        result <- rbind(result, data.frame(id=idx, nobs=nrow(data)))
    }
    return(result)
}