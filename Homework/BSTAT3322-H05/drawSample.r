# drawSample.r
rm(list=ls())

n <- sample.int( 100, size=23, replace=TRUE )
mu <- c( 35, 34.5, rnorm( 21, 35, 1 ))
cheat <- c( 0, 0, rnorm( 21,  -2, 2 )) * c( 0, 0, rbinom( 21, 1, 0.5 ))
mu <- mu + cheat
sigma <-( 0.05 +runif( 23, -0.01, 0.01  )) * mu

Bottler <- NULL
Owned   <- NULL
Program <- NULL 
Caffeine <- NULL

for( i in 1:23 ){
    b <- rep( i, n[i] )
    Bottler <- c( Bottler, b )
    ow <- ifelse( b <=2, "Yes", "No" )
    Owned <- c( Owned, ow )
    p <- rbinom( n[i], 1, 0.50 )
    p <-ifelse( p==1, "Yes", "No")
    Program <- c( Program, p )
    c <- round( rnorm( n[i], mu[i], sigma[i]),2)
    Caffeine <- c( Caffeine, c )
}

Bottler <- factor( Bottler)
Owned   <- factor( Owned )
Program <- factor( Program )

SuperCola <- data.frame( Bottler, Owned, Program, Caffeine )
head( SuperCola )
tail( SuperCola )
write.csv( SuperCola, file="SuperCola.csv" )
rm(list=ls())
cat( " sample drawn.",
     "\nFiles is in Directory:\n", getwd())
     