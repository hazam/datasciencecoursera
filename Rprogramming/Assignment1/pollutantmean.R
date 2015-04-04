pollutantmean <- function(directory, pollutant, id = 1:332) {
  data = matrix()
  for (idx in id) {
    fileName = paste(directory, "/", sprintf("%03d", idx), ".csv", sep="")
    tempFile <- file(fileName, "r")
    if (nrow(data) <= 1) {
      data <- read.csv(tempFile)
      data <- subset(data, !is.na(data[[pollutant]]))
    } else {
      temp <- read.csv(tempFile)
      temp <- subset(temp, !is.na(temp[[pollutant]]))
      data <- rbind(data, temp)
    }
    close(tempFile)
  }
  return(mean(data[[pollutant]]))
}