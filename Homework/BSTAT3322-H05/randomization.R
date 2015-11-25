# randomization.r
#
# This function computes the randomization distribution for a completely
# randomized experimental design with a single treatment with two levels.  
# # The function returns a vector consisiting of the values of the 
# randomization distribution.  
#
# The argument of this distribution are:
#
# y1 - values of the experimental response variable for treatment level 1.
# y2 - values of the experimental response variable for treatment level 2.
# reps - the number of replications in the randomization distribution. This
#        has a default value of 10,000.

randomization <-
    function( Response1, Response2, reps=10000 ){
        n1 <- length( Response1 )
        n2 <- length( Response2 )
        
        n <- n1 + n2
        
        Response <- c( Response1, Response2 )
        meanDif  <- rep( NA, reps )
        
        for( i in 1:reps ){
            j <- sample.int( n, size=n1, replace=FALSE )
            y1 <- Response[j]
            y2 <- Response[-j]
            meanDif[i] <- mean(y1) - mean(y2)
        }
        
        meanDif
    }
       
       
