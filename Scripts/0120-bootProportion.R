# 0110-bootProportion.r
#
# We demonstrate the bootstrapping of the sample proprtion of 
# number of female commuters in the Commute Atlanta study.
#
# The URL for the data set is:
#
# http://www.lock5stat.com/datasets/CommuteAtlanta.csv

rm( list=ls())                         # Clear environment

###########################################################
# We directly read the comma seperated file over the      #
# internet.                                               #
###########################################################
#
URL <- "http://www.lock5stat.com/datasets/CommuteAtlanta.csv"
CA <- read.csv( URL )
head( CA )
tail( CA )
#
###########################################################
# We will create a new variable called Gender which will  #
# have c value of 0 if the variable Sex is a male and a   #  
# value of 0 if the variable sex is a male.               #
###########################################################
#
CA$Gender <-                     # Add gender to
    ifelse( CA$Sex=="F", 1, 0 )  # data frame.
#
head( CA )                       # Comfirm GEnder.
head( CA )
#
##########################################################
# Always plot raw data.  We will plot a bar-chart of the #
# raw data using the Sex variable.                       #
##########################################################
#
require( ggplot2 )        # For graphics grammar plotting
#
ggplot( CA, 
        aes( x=Sex)) +
    geom_bar( color="black",
              fill="blue" ) +
    scale_x_discrete("Cut", 
                     labels = 
                         c( "F" = "Female",
                            "M" = "Male")) +
    xlab( "Gender" ) +
    ylab( "Frequency" ) +
    ggtitle( "Commute Atlanta \nGender of Commuters" )

########################################################
# The sample proportion is simple the sample mean of   #
# binary datata (0 or one).  Therefore we can use the  #
# the sample mean of the one.boot function to boot-    #
# strap the sample proportion.                         #
########################################################

require( simpleboot )

bootObject <- one.boot(  CA$Gender,
                         mean,
                         R=1000 )

#######################################################
# Now we priont the bootstrap sample statistics.  The #
# smple statistic we are bootstraping is the sample   #
# proprtion.                                          #
#######################################################

phat   <- bootObject$t0
bsPhat <- mean( bootObject$t )
bias   <- bsPhat - phat
apb    <- abs( bias / phat ) * 100
se     <- sd( bootObject$t )
#
cat( "\nSample Proprtion Bootstrap  Statistics", 
    "\nOrginal Sample Proportion:   ", phat,
     "\nBootstrap distribution mean:", bsPhat,
     "\nBootstrap bias:             ", bias,
     "\nAbsolute percent bais:      ", apb,
     "\nBootstrap Standard error:   ", se )
#
#####################################################
# Confirm theta the bootstrap sampling distribution #
# Is approximately moundshaped.                     #
#####################################################
#
hist( bootObject,
      xlab = "Bootstrap samples", 
      main = "Compute Atlanta \nProprtion Bootstrap Sampling distribution")
#
#####################################################
# The bootstrap sampling distribution looks to be   #
# mound-shaped and close to a normal distribution   #
#####################################################
#
#
#####################################################
# Analysis:                                         #
# The bootstraped sampling distribution appear to   #
# approximately normally distributed.               #
#####################################################
#
require( boot )

boot.ci( bootObject,
         conf =c( 0.90, 0.95, 0.98, 0.99 ),
         type="all" )
#
#####################################################
# Because the sampling distribution appears to be   #
# approximately noirmally distributed we will use   #
# The normal confidence interval.  Therefore our    #
# point estimate is 0.492 or 49.2%.  The 98% confi- #
# dence interval us from 0.440 through 0.54440 or   #
# from 44.0% to 54.4%.                              #
#####################################################


