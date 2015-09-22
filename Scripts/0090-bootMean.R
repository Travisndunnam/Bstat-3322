# 0090-bootMean.r
#
# We demonstrate the bootstrapping of the sample mean of the average
# commute time in Atlanta Georgia using the data provided at the
# LOck5 Wed site: 
# 
# http://www.lock5stat.com/datasets/CommuteAtlanta.csv

rm( list=ls())                         # Clear environment

###########################################################
# We directly read the comma seperated file over the      #
# internet.                                               #
###########################################################

URL <- "http://www.lock5stat.com/datasets/CommuteAtlanta.csv"
CA <- read.csv( URL )
head( CA )
tail( CA )

###########################################################
# As usual we should plot the data prior to begining any  #
# analysis.                                               #
###########################################################

require( ggplot2 )            # For ggplot2 fubctionality

ggplot( CA, 
        aes( x=Time)) +
    geom_histogram( aes( y=..density.. ),
                    binwidth=10,
                    color="black",
                    fill="yellow") +
    geom_density() +
    xlab( "Time (minutes)") +
    ylab( "Density") +
    ggtitle( "Allanta Commute Time Distributio\n")


############################################################
# We are going to use the R-package simpleboot.  You will  #
# need to install tghe package.                            #
############################################################

require( simpleboot )

############################################################
# We will run 1000 bootstrap replications using the Time   #
# variable in the CA data frame.  The statistical finction #
# is the sample mean.                                      #
############################################################

bootObject <- 
one.boot( CA$Time,    # The variable of interest
          mean,       # The desired statistical function
          R=1000 )    # Number of replications
          
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

############################################################
# We now check the shape of the boot strap sampling        #
# to determine the type of confidence intervals we should  #
# use.                                                     #
############################################################

hist( bootObject,
      xlab = "Bootstrap samples", 
      main = "Commpute Atlanta \nMean Bootstrap Sampling distribution")

###########################################################
# The bootstrap distribution appears to have a slightly   #
# positive skew.  Therefore, we should probably not use   #
# The normal confidence intervals are not appropriate.    #
# We can use the boot.ci confdence intervals in the R-    #
# package boot.  YOu will need to install this package    #
###########################################################

require( boot )
     
boot.ci( bootObject,
         conf =c( 0.90, 0.95, 0.98, 0.99 ),
         type="all" )

##########################################################
# Conclusion                                             #
# The bootstrap sampling distribution is mounded shaped  #
# and slight skewed under these conditions we shpould    #
# use the BCa confidence intervals.                      #
##########################################################