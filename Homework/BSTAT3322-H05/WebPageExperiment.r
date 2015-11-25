# WPE.r
# Run web page experioment.

rm(list=ls())

pC <- runif( 1, 0.001, 0.010 )
effect <- runif( 1, 0, 0.005 )
pN <- pC + effect 
treatments <- c( "Current", "New" )
probs <- c(  pC, pN )

n <- round( runif( 1, 15000, 250000 ))

Treatment <- rep( NA, n )
Binary    <- rep( NA, n )

for( i in 1:n ){
   t <- rbinom( 1, 1, 0.5 ) + 1
   Treatment[i] <- treatments[t] 
   Binary[i]      <- rbinom( 1, 1, probs[t] )
}



Treatment <- as.factor( Treatment ) 
Sale      <- ifelse( Binary == 0, "No", "Yes" )
Sale      <- as.factor( Sale  ) 

WPE <- data.frame( Treatment, Sale, Binary  )

write.csv( WPE, file="WPE.csv" )

head( WPE )
tail( WPE )

rm( list=ls() )

