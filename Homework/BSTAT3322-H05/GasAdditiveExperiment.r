# runExperiment.r
rm(list=ls())
n <- floor( runif( 1, 10, 25 ))
effects <- seq( from=0, to=3, by=0.5 )
ie <- sample.int( 7, 1, replace=TRUE )
effect <- effects[ie]

MU <- rnorm( 1, 28.5, 1 )
SIGMA <-runif( 1, 1,  3 )

Treatment <-
    c( rep( "Control",  n ),
       rep( "Additive", n))

MPG <- c(  rnorm( n, MU,SIGMA ),
           rnorm( n, MU + effect, SIGMA ))

GAE <- data.frame( Treatment, MPG )

GAE <- data.frame( Control, Additive )
write.csv( GAE,file="GAE.csv")
