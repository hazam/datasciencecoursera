corr <- function(directory, threshold = 0) {
  data <- complete(directory, 1:332)
  data <- subset(data, nobs > threshold)
  if (nrow(data) == 0) return(vector("numeric"))
  correlations <- numeric()
  for (monitor in data[,1]) {
    fn = paste(directory, "/", sprintf("%03d", monitor), ".csv", sep="")
    thisMonitor = read.csv(fn)
    thisMonitor <- subset(thisMonitor, !is.na(nitrate) & !is.na(sulfate))
    correlation <- cor(thisMonitor[,2:3])[1,2]
    correlations <- append(correlations, correlation) 
  }
  return(correlations)
}