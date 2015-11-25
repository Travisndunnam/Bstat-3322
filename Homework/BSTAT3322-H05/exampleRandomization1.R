# exampleRandomization1.r

y <- round( rnorm( 50, 75, 5 ), 0 )
Treatment <- 
  c( rep( "Control", 25 ) ,
     rep(( "Treatment", 25")) 
    
    