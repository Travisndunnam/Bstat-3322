FrenchDraftHeights.rS
rm( list=ls())
df <- sample.int( 30, 1 )
N <- floor( runif( 1, 10000, 50000 ))
MU    <- rnorm( 1, 65, 1 )
SIGMA <- abs( runif( 1, 1, 2 ))
limit <- floor( MU - 1.5 * SIGMA  )
height <- rnorm( N, MU, SIGMA )
dodger <- rbinom( N, 1, 0.01 )
height <- ifelse(  dodger==0,
                   height,
                   height - (height-limit) - 0.5)
Draft <- data.frame( height )
write.csv( Draft, file="Draft.csv")
rm( list=ls())

