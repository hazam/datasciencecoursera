printbest <- function(state, outcome) {
    ## Read outcome data
    data_outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    # data_hospital <- read.csv("hospital-data.csv", colClasses = "character")
    ## Check that state and outcome are valid
    
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (is.element(outcome, outcomes) == FALSE) {
        stop("invalid outcome")
    }
    
    ##subset only state data
    data_outcomes <- subset(data_outcomes, data_outcomes$State == state)
    if (nrow(data_outcomes) == 0) {
        stop("invalid state")
    }
    
    ##select relevant columns
    data_outcomes <- data_outcomes[c(2,7,11,17,23)]
    data_outcomes[,3] <- sapply(data_outcomes[,3], as.numeric)
    data_outcomes[,4] <- sapply(data_outcomes[,4], as.numeric)
    data_outcomes[,5] <- sapply(data_outcomes[,5], as.numeric)
    ##get the col IDX
    col <- match(outcome, outcomes) + 2
    
    ##reorder by hospital name
    data_outcomes <- data_outcomes[order(data_outcomes[1]),]
    
    ##reorder by outcome
    data_outcomes <- data_outcomes[order(data_outcomes[col]),]
    data_outcomes[1,1]
}

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data_outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    # data_hospital <- read.csv("hospital-data.csv", colClasses = "character")
    ## Check that state and outcome are valid
    
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (is.element(outcome, outcomes) == FALSE) {
        stop("invalid outcome")
    }
    
    ##subset only state data
    data_outcomes <- subset(data_outcomes, data_outcomes$State == state)
    if (nrow(data_outcomes) == 0) {
        stop("invalid state")
    }
    
    ##select relevant columns
    data_outcomes <- data_outcomes[c(2,7,11,17,23)]
    data_outcomes[,3] <- sapply(data_outcomes[,3], as.numeric)
    data_outcomes[,4] <- sapply(data_outcomes[,4], as.numeric)
    data_outcomes[,5] <- sapply(data_outcomes[,5], as.numeric)
    
    ##get the col IDX
    col <- match(outcome, outcomes) + 2
    
    ##reorder by hospital name
    data_outcomes <- data_outcomes[order(data_outcomes[1]),]
    
    ##reorder by outcome
    data_outcomes <- data_outcomes[order(data_outcomes[col], na.last = NA),]
    if (num == "best") {
        data_outcomes[1,1]
    } else if (num == "worst") {
        data_outcomes[nrow(data_outcomes),1]
    } else {
        data_outcomes[num,1]
    }
}