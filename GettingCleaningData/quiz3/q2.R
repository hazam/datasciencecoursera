library(dplyr)
library(jpeg)
setwd('~/workspace/datasciencecoursera/GettingCleaningData/quiz3')
if (!file.exists("./jeff.jpg")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(url, dest="jeff.jpg", method="curl")
}


the_image <- readJPEG("jeff.jpg", native = TRUE)
print(quantile(the_image, 0.30))
print(quantile(the_image, 0.80))