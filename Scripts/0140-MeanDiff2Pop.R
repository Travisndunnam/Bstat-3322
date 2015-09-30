# 0140-Two population mean difference
#
###########################################################
# This script shows hot estimated the mean difference in  #
# population means when two indepdent samples are drawn.  #
# We will use the mean drive time between males and       #
#females for the Commute Atlanta data file.               #
###########################################################
#
rm(list=ls() )
#
#
###########################################################
# We directly read the comma seperated file over the      #
# internet.                                               #
###########################################################

URL <- "http://www.lock5stat.com/datasets/CommuteAtlanta.csv"
CommuteAtlanta <- read.csv( URL )
head( CommuteAtlanta )
tail( CommuteAtlanta )
#
###########################################################
# As alwsays we start with graphics.  Since we are        #
# comparing the drive times we will use comparitive       #
# boxplot.                                                #
###########################################################
#
require( ggplot2 )          # For graphics grammar package.

ggplot( CommuteAtlanta,
        aes( x=Sex, y=Time )) +
    geom_boxplot( ) +
    xlab( "Gender" ) +
    ylab( "Time (minutes)" ) +
    ggtitle( "Commute Atlanta \nCommute Times by Gender" )
#
#
###########################################################
# We revise the x-axis labels frpm "F" and "M" to         #
# "Female" and "Male".                                    #
###########################################################
#
ggplot( CommuteAtlanta,
        aes( x=Sex, y=Time )) +
    geom_boxplot( ) +
    scale_x_discrete(breaks=c("F", "M"),
                     labels=c("Female", "Male")) +
    xlab( "Gender" ) +
    ylab( "Time (minutes)" ) +
    ggtitle( "Commute Atlanta \nCommute Times by Gender" )
#
#
############################################################
# Divide the random sample into two numeric vectors by     #
# Sex.                                                     #
############################################################
#
Females <-CommuteAtlanta$Time[CommuteAtlanta$Sex=="F"]
head( Females )
#
Males <-CommuteAtlanta$Time[CommuteAtlanta$Sex=="M"]
head( Males )
#
#
###########################################################
# Create bootstrap sampling distribution.                 #
###########################################################
#
require( simpleboot )                  # Simple bootstrap 
#                                      functionality.
#
bootOut <- two.boot( Females,          # Bootstarp      
                     Males, 
                     mean, 
                     R=2000 )

hist( bootOut )                        # Check sampling distribution
#
qqnorm( bootOut$t )                    # PLot normal probability plot.
qqline( BootOut$t )                    # Add theoretical reference line.
#
require( nortest )                     # For Anderson-Darling normality
#                                      # hypthesis test for normality.
#
ad.test( bootOut$t )                   # Carry out test

############################################################
# Compute the bootstrap distribution and the standard      #
# error of the bootstrap sampleing distribution.           #
############################################################

bsMean <- mean( bootOut$t )
se     <- sd( bootOut$t)
bias <- bsMean - bootOut$t0
apb <- abs( bias / bootOut$t0  ) * 100

cat( "\nOrginal Sample Mean:        ", bootOut$t0,
     "\nBootstrap distribution mean:", bsMean,
     "\nBootstrap bias:             ", bias,
     "\nAbsolute percent bais:      ", apb,
     "\nBootstrap Standard error:   ", se )

############################################################
# Since the bootstrap sampling distribution appear to be   #
# normally distributed we use the normal distribution to   #
E# compute the 98% confidence interval.                    #
############################################################

boot.ci( bootOut, 
         conf=0.98,
         type="norm" )

