# 0090-bootMean.r
#
# We demonstrate the bootstrapping of the sample proprtion when
# only the sample proportion and sample size are given.
#
# The source of this data is:
#
# http://www.gallup.com/poll/185528/trust-judicial-branch-sinks-new-low.aspx?g_source=Politics&g_medium=newsfeed&g_campaign=tiles
#
#
# The data we will use is described below:
#
# PRINCETON, N.J. -- Americans' trust in the judicial 
# branch of the federal government has fallen significantly
# in the past year, and now a record-low 53% say they have 
# "a great deal" or "a fair amount" of trust in it. Trust 
# in the executive and legislative branches also remains 
# near historical lows, but both were up slightly this year.
#
# Results for this Gallup poll are based on telephone 
# interviews conducted Sept. 9-13, 2015, with a random 
# sample of 1,025 adults, aged 18 and older, living in 
# all 50 U.S. states and the District of Columbia.
#
#The poll was taken on SEPTEMBER 18, 2015.
#
#
rm( list=ls())     # Clear environment.
#
#
###########################################################
# We need to convert the summerized sample results into   #
# the tabulated sample data.  That is we need to          #
# determine the number of indiviudals that agree and the  #
# number of iondividuals that did not agree,              #
###########################################################

phat <- 0.530
n    <- 1025
agree <- round( phat * n, 0 )
disagree <- n - agree

###########################################################
# Remark:                                                 #
# Note that the value of agree should be an integer. It   #
# not is equal to 543.25.  We will round to 543 and       #
# recompute agree and disagree.                           #
###########################################################
#
agree    <- round( phat * n, 0 )     # Round to an integer
disagree <- 1025 - agree    
#
#
############################################################
# Now we create a data frame that has the same             #
# Caracteristivs as the sample.  we will also create a     #
# qualatative variable called response so we can draw a    #
# barchart of the orginal sample.                          #
############################################################
#
x         <- c( rep( 1, agree ), 
                rep(0, disagree))
#
Response  <- c( rep( "Agree", agree ),
                rep( "Disagree", disagree ))
#
DF <- data.frame( Response, x )
#
############################################################
# Draw a barchart of the data.                             #
############################################################  
#
require( ggplot2 )          # For graphics grammar plotting.
#
ggplot( DF, 
        aes( x=Response )) +
    geom_bar( aes( y = 100 * ..count.. / sum( ..count.. )),
              color="black",
              fill=" yellow" ) +
    scale_y_continuous(breaks=seq(0,60,5)) +
    ylab( "Percent") + 
    ggtitle( "Trust in U.S. Judicial Branch Sinks to New Low of 53%" )
#
#############################################################
# We now bootstrap the population percentahe using the same #
# technique as before.                                      #
#############################################################
# 
# require( simpleboot )
#
bootObject <- one.boot( DF$x,
                        mean,
                        R=1000 )
#
#############################################################
# We print the bootstrap sample results as before.          #
#############################################################
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
         type="norm" )
#
#####################################################
# Because the sampling distribution appears to be   #
# approximately noirmally distributed we will use   #
# The normal confidence interval.  Therefore our    #
# point estimate is 0.530 or 53.0%.  The 95% confi- #
# dence interval us from 0.50 through 0.55597  or   #
# from 50.0% to 56.9%.                              #
#####################################################

