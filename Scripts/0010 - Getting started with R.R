# 0010 - Getting started with R Part 1

########################################################################
# This script covers the same material as covered ny Marin in his      #
# second lecture.                                                      #
########################################################################

# Assigning a value to a variable

price <- 10.50
quantity <- 3
extension <- price * quantity
product <- "widget"

# Economic order quantity.

# Suppose that we have the following data converning a intem in inventory:
    
demand <- 10000        # Units per year
costPerOrder <- 2      # Cost per order
holdingCost <- 0.16   #Cost to hold an item in inverntory per year

# We compute the EOQ using the following expression:

( EOQ <- sqrt( 2 * demand * costPerOrder / holdingCost ) )


          
   