# H04-2

rm( list=ls())

curDir <- getwd()
dataFile <- file.path( curDir, 
                       "data", 
                       "Yellowstone Hot Spot Eruptions.csv" )

SV <- read.csv( dataFile )
SV <- SV[-1,]             

require(ggplot2 )

ggplot( SV,
        aes(x=Interval)) +
    geom_histogram( aes( y=..density.. ),
                    binwidth=0.50,
                    color="black",
                    fill="yellow" ) +
    geom_density()


require( simpleboot )

Interval <- SV[,3]

bootObject <-one.boot(  Interval,
                     mean,
                     R=2000 )

hist( BootObject )

ybar <- bootObject$t

qqnorm( ybar )
qqline( ybar )


############################################################
# Compute the bootstrap distribution and the standard      #
# error of the bootstrap sampleing distribution.           #
############################################################

bsMean <- mean( bootObject$t )
se     <- sd( bootObject$t)
bias <- bsMean - bootObject$t0
apb <- abs( bias / bootObject$t0  ) * 100

cat( "\nOrginal Sample Mean:        ", bootObject$t0,
     "\nBootstrap distribution mean:", bsMean,
     "\nBootstrap bias:             ", bias,
     "\nAbsolute percent bais:      ", apb,
     "\nBootstrap Standard error:   ", se )