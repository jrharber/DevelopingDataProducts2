Demand versus Supply Demonstration. A Shiny Application
========================================================
author: J Harber
date: September 23, 2017
autosize: true

========================================================
Executive Summary

This application demonstrates how Demand and Supply curves interact in setting prices for a particular commodity. The commodity used for this demonstration is milk.

From the demonstration using the shiny app (see url = https://jrhcourseraprojects9.shinyapps.io/JrhShinyAssignment ), the following conclusions can be made;

- As the quantity supplied is increased and quantity demanded remains the same, the price decreases (i.e., less demand for the new larger supply).
- As the quantity supplied is decreased and quantity demanded remains the same, the price increases (i.e., more demand for the new smaller supply).

Algorithm for finding the intersection of the supply and demand lines
========================================================
- The equilibrium point for the supply and demand curves is where the 2 lines intersect.

- Since the supply curve and demand curve in this case were straight lines, in order to get the equilibrium point, the solution is to find where the 2 lines intersect.

- Using the R solve() function, I was able to find the equilibrium point.

========================================================
Calculations
- In the matrix below, the y coefficients of the linear equations (i.e., supply and demand lines) are = 1
- bS and bD are the slopes for the supply and demand lines.
- aS and aD are the intersects for the supply and demand lines.
- The default values at start up are:

```r
bS <- 0.000225; bD <- -0.000225; aS <- -1.25; aD <- 12.25
a <- matrix(c(1,1,-bS,-bD), nrow=2,ncol=2)
b <- c(aS,aD)
solve(a,b)
```

```
[1]     5.5 30000.0
```
The calculated equilibrium point is [5.5, 30000] where 5.5 is the y coordinate and 30000 is the x coordinate from the equilibrium point at start up.

========================================================
Conclusion
- Using R and Shiny was easy to produce a web application
- Documentation on the solve() function was very poor. Only by trial and error was I able to understand the matrix setup required for input to solve()
- I was not able to get my plotting function, plot_ly, to work correctly in the R Presenter

