# 0000-Download stock data

rm( list=ls())

require( quantmod )
require( data.table )

getSymbols( "BRK.A", src="google")
BRK.A <- data.frame( data.frame( BRK.A ))
n <- dim( BRK.A )[1]
last <- n
first <- n - 261L


BRK.A <- BRK.A[first:last,]
n <- dim( BRK.A )[1]

rBRK.A <- rep(NA, n)

for( i in 2:n ){
    rBRK.A[i] <- log( BRK.A[i,4]) - log( BRK.A[i-1,4])
}

rBRK.A <- rBRK.A[2:n]

write.csv( BRK.A, file=path )

getSymbols( "SP500", src="FRED" )  

SP500 <- data.frame( SP500 )
head( SP500 )
tail( SP500 )

last  <- dim(SP500)[1]
first <- last - 261L

SP500 <- SP500[ first:last,1]


length(SP500)
dim( BRK.A  )

rSP500 <- rep( NA, n)

for( i in 2:n){
    rSP500[i] <- log( SP500[i] ) - log(SP500[i-1])
}

rSP500 <- rSP500

CAPM <- data.frame( rSP500, rBRK.A )

filePath <- file.path( getwd(),
                       "data",
                       "capmBrk.A.csv" )
write.csv( CAPM, file=filePath )

