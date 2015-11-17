# diagnose.r

require(ggplot2)
source( "ggQQ.r")
source( "multiplot.r" )

diagnose <-  
    function( y )
{
        DF <- data.frame( y )
        
        p1 <- ggplot( DF,
                      aes( x=y)) +
            geom_histogram( 
                aes( y =..density..),
                color="black",
                fill="white" ) +
            geom_density( color= "red" ) +
            xlab( "Variable")
        p2 <- ggQQ( y )
        
        multiplot( p1, p2, cols=2)
}