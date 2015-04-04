rankall <- function(outcome, num = "best") {
    data_outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (is.element(outcome, outcomes) == FALSE) {
        stop("invalid outcome")
    }
    
    ##select relevant columns
    data_outcomes <- data_outcomes[c(2,7,11,17,23)]
    names(data_outcomes) <- c("name", "state", 
             "mortality_heart_attack", "mortality_heart_fail", "mortality_pneumonia")
    data_outcomes[,3:5] <- sapply(data_outcomes[,3:5], as.numeric)
    
    
    
    ##get the col IDX
    col <- match(outcome, outcomes) + 2
    ##reorder by state
    data_outcomes <- data_outcomes[order(data_outcomes$name),]
    data_outcomes <- data_outcomes[order(data_outcomes[col], na.last = NA),]
    
    rank_by_state <- tapply(data_outcomes$name, data_outcomes$state, c)
    options(stringsAsFactors = FALSE)
    result <- data.frame()
    for (key in names(rank_by_state)) {
        state_rank <- rank_by_state[[key]]
        if (num == "best") {
            toappend <- c(state_rank[1], key)
        } else if (num == "worst") {
            toappend <- c(state_rank[length(state_rank)], key)
        } else {
            toappend <- c(state_rank[num], key)
        }
        result <- rbind(result, toappend)
    }
    names(result) <- c("hospital","state")
    result
}