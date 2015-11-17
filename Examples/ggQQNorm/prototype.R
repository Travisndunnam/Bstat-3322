# Prototype normal QQ plot
rm( list=ls())

require( ggplot2 )
require( nortest )

y <-rnorm(75, 70, 9)

    zs <-   qqnorm( y, plot.it=FALSE )
    z <-   zs$x
    y <-   zs$y
    
 ZY <- data.frame( z, y ) 
 
 m <- diff( quantile( y, c(0.25,0.75))) /
      diff( quantile( z, c(0.25,0.75)))
 b <- y[1L] - m * z[1L]

ggplot( ZY, 
        aes( x=z, y=y)) +
    geom_point() +
    geom_abline( intercept=b,
                 slope=m,
                 color="red" ) +
    xlab( "Standardard Normal Qunatiles" ) +
    ylab( "Sample Quantiles" ) +

    ggtitle( "Normal Quantile Plot")