# runExperiment.r
rm(list=ls())
n <- floor( runif( 1, 10, 16 ))
effects <- seq( from=0, to=3, by=0.5 )
ie <- sample.int( 7, 1, replace=TRUE )
effect <- effects[ie]

MU <- rnorm( 1, 30, 1 )
SIGMA <-runif( 1, 0.50, 1.50  )

Control <- rnorm( n, MU,SIGMA )
Additive <- rnorm( n, MU, SIGMA) + effect
Experiment <- data.frame( Control, Additive )
write.csv( Experiment,file="Experiment.csv")
