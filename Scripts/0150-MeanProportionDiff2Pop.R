# 0140-Two population proprotion difference
#
###########################################################
# This script shows hot estimated the mean difference in  #
# population proportions  when two indepdent samples are # 
# drawn. We will use the mean drive time between males    #
# and females for the Commute Atlanta data file.          #
###########################################################
#
#
###########################################################
# Rasmussen Reports’ latest national telephone survey     #
# finds that 52% of Likely Republican Voters still        #
# believe Trump is likely to be their party’s             #
# presidential nominee, including 17% who say it’s Very   #
# likely. But the overall finding is down from 58% last   #
# week and from a high of 66% at the beginning of this    #
# month.  At that time, 26% said Trump was Very Likely to # 
# be the nominee.                                         #
#                                                         #  
###########################################################
# Rasmussen: 
# http://www.rasmussenreports.com/public_content/politics/elections/election_2016/trump_change



rm(list=ls() )
#
#
###########################################################
# The sample size and the proprtions for this current     #
# wkka and the prior week are listed bvelow.              #
###########################################################
#
plst <- 0.58
pcur <- 0.52
n    <- 1000
#
#
###########################################################
# Create the sample results for last week and current     #
# Week.                                                   #
###########################################################
#
Yes <- rep( 1, 1000 *  plst  )
No  <- rep( 0, 1000 - 580 )
LastWeek <- c( Yes, No )
#
Yes <- rep( 1, n* pcur  )
No <- rep( 0, n * ( 1 - pcur))
CurrentWeek <- c(Yes, No  )



# Create bootstrap sampling distribution.                 #
###########################################################
#
require( simpleboot )                  # Simple bootstrap 
#                                      functionality.
#
bootOut <- two.boot( LastWeek,          # Bootstarp      
                     CurrentWeek, 
                     mean, 
                     R=1000 )

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

