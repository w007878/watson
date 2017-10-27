f <- function(x) {
    m <- 29
    n <- length(x)
    f <- 0
    t <- 1:29 / 29.
    r <- rep(0, 31)

    for(i in 1:m) {
        tmp <- 0
        for(j in 1:n) {
            r[i] <- r[i] + (j - 1) * t[i]^(j - 2) * x[j]
        }
        for(j in 1:n) {
            tmp <- tmp + t[i]^(j - 1) * x[j]
        }
        r[i] <- r[i] - tmp^2 - 1
        f <- f + r[i]^2
        }
    r[30] <- x[1]
    r[31] <- x[2] - x[1]^2 - 1
#    print(r)
    f <- f + r[30]^2 + r[31]^2
}

gd <- function(x) {
    n <- length(x)
    t <- 1:29 / 29.
    r <- rep(0, 31)
    gd <- rep(0, n)
    
    for(i in 1:29) {
        tmp = 0
        for(j in 1:n) {
            r[i] <- r[i] + (j - 1) * t[i]^(j - 2) * x[j]
        }
        for(j in 1:n) {
            tmp <- tmp + t[i]^(j - 1) * x[j]
        }
        r[i] <- r[i] - tmp^2 - 1
    }
    r[30] <- x[1]
    r[31] <-  x[2] - x[1]^2 - 1
    
    for(j in 1:n) {
        for(i in 1:29) {
            tmp <- 0
            for(k in 1:n) {
                tmp <- tmp + x[k] * t[i]^(j+k-2)
            }
            gd[j] <- gd[j] + 2 * r[i] * ((j - 1) * t[i]^(j - 2) - 2 * tmp)
        }
        if(j == 1) {
            gd[j] <- gd[j] + 2 * r[30] + 2 * r[31] * (-2 * x[1])
        }
        if(j == 2) {
            gd[j] <- gd[j] + 2 * r[31]
        }
    }
    print(gd)
    gd <- gd
}