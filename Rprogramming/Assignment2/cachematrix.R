## This function will return a list implementing
## methods to store a matrix and cached result for the inverse
makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    set <- function(y) {
        x <<- y
        inverse <<- NULL
    }
    get <- function() x
    setinverse <- function(inve) inverse <<- inve
    getinverse <- function() inverse
    list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This method takes as parameter the outcome
## of call to makeCacheMatrix and solve the matrix
## eventually storing as a cache inverse
cacheSolve <- function(x, ...) {
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}
