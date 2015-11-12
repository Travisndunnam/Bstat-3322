# Stock.r
#

rm( list=ls())

DF <- c( rep( 1, 32 ),
         rep( 2, 64 ),
         rep( 3, 128),
         rep( 4, 256 ),
         seq( 5, 512,1 ))
j <- sample.int( length(DF), 1 )
df <- DF[j]

price <- 100
MU    <- 0
SIGMA <- 0.001

n <- round( runif( 1, 30, 260 ))

dailyReturn <- MU + SIGMA * rt( n, df )
day         <- 1:length( dailyReturn )
Stock       <- data.frame( day, dailyReturn  )
write.csv( Stock, file="Stock.csv")
rm( list=ls())
