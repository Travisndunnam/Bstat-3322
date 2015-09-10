# 0000-Download stock data

rm( list=ls())

require( quantmod )
require( data.table )

stockList <-
    
  
getSymbols( "BRK.A", src="google")

BRK.A <- data.frame( BRK.A )
n <- dim( BRK.A )[1]
last <- n
first <- n - 260L

priorClose <- BRK.A[ first- 1, 4]

BRK.A <- BRK.A[first:last,]

n <- dim( BRK.A )[1]

Return <- rep(NA, n)

Return[1] <- log( BRK.A[1, 4] ) - log( priorClose )

for( i in 2:n){
    Return[i] <- log( BRK.A[i,4] ) - log( BRK.A[i-1,4] )
}

BRK.A <- cbind( BRK.A, Return )

wd <- getwd();
fileName <- "BerkshireHathawayA.csv"
path <- file.path( wd, 
                   "data", 
                   fileName )

write.csv( BRK.A, file=path )




