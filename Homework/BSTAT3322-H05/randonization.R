# randonization.r
#
# This function computes the randomization distribution for a completely
# randomized experimental design with a single treatment with two levels.  
# # The function returns a vector consisiting of the values of the 
# randomization distribution.  
#
# The argument of this distribution are:
#
# y - values of the experimental response variablle.
#
# n1 - The number of the first treatment level in the experiment,  If this
#      is NULL then the design is condiered to be completely randomized 
#      and balanced and is set equal to n / 2.  
#
# reps - The number of replicaltions used to create the ran

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
       
       
