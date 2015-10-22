
n <- 404678
phat <- 0.678
s <- round( n * phat, 0 )
f <- n - s
x <- c( rep(1, s), rep(0, f) )

require(simpleboot)

bootObject <- one.boot( x,
                        mean, 
                        R=1000 )
bootObject

bootObject$t0
hist( bootObject )
require( boot )
boot.ci(  bootObject, conf=0.99, type="norm" )

