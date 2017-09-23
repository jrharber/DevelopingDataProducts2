#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlotly({
    
    # generate bins based on input$bins from ui.R
    ##_x    <- faithful[, 2] 
    ##_quanitySupplied <- seq(min(x), max(x), length.out = input$quanitySupplied + 1)
    
    # draw the histogram with the specified number of bins
    ##_hist(x, breaks = quanitySupplied, col = 'darkgray', border = 'white')
    
    ## Pe = Price at Equilibrium
    ## Qs = Quantity Supplied (x coordinates on the supply curve)
    ## Ps = Price Supplied Supplied (y coordinates on the supply curve)
    ## before_bS = Slope of the supply curve before if is adjusted
    ## bS = Slope of the supply curve before if is adjusted
    
    df <- data.frame(x = c(10000,50000,10000,50000), y = c(10, 1,1,10), type=c("Demand", "Demand", "Supply", "Supply"))
    
    xS <- df[3:4,1]
    yS <- df[3:4,2]
    
    xD <- df[1:2,1]
    yD <- df[1:2,2]
    
    ## slope and intercept used for predicting price given supply
    bD <- (yD[2] - yD[1]) / (xD[2]-xD[1])
    bS <- (yS[2] - yS[1]) / (xS[2]-xS[1])
    aD <- yD[1] -bD*xD[1]
    aS <- yS[1]- bS*xS[1]
    
    a <- matrix(c(1,1,-bS,-bD), nrow=2,ncol=2)
    b <- c(aS,aD)
    e <- solve(a,b)
    
    ## Request another supply line in which the user has increased via the slider bar
    
    
      ## Another line with the Quanity supplied increased
      defaultValue <- 30000
      xS1 <- xS + (input$quanitySupplied - defaultValue)*2
      yS1 <- yS
      aS1 <- yS1[1]- bS*xS1[1]
      
      ## a is a matrix of coefficients from equations in the form;
      ##		y = intercept +bx
      ##		y - bx = intercept
      ##
      ##		a = [yS, -bSx
      ##			yD, -bDx ]
      ##
      ##		a = [1, -bS
      ##			1, -bD ]
      ##
      ##		b = [interceptS, interceptD]
      ##		  = [aS, aD]  
      ##
      a <- matrix(c(1,1,-bS,-bD), nrow=2,ncol=2)
      b <- c(aS1,aD)
      e1 <- solve(a,b)
      
      aAnnot <- list(
        x = e[2],
        y = e[1],
        text = paste("(", round(as.numeric(e[2]),0)/1000, "K ", ",",sprintf("$%3.2f", e[1]), ")", sep=""),
        xref = "x",
        yref = "y",
        showarrow = TRUE,
        arrowhead = 7,
        ax = 20,
        ay = -35)
      aAnnot2 <- list(
        x = e1[2],
        y = e1[1],
        text = paste("(", round(as.numeric(e1[2]),0)/1000, "K ", ",", sprintf("$%3.2f", e1[1]), ")", sep=""),
        xref = "x",
        yref = "y",
        showarrow = TRUE,
        arrowhead = 7,
        ax = 20,
        ay = -35)
      
      output$equilibriumSupply <- renderText({
        paste("Equilibrium Supply:  ",round(as.numeric(e1[2],0)) / 1000, "K", sep="")
      })
      
      output$equilibriumPrice <- renderText({
        paste("Equilibrium Price:  ", sprintf("$%3.2f", e1[1]))
      })
      
      output$conclusions <- renderText({
        "Conclusions:"
      })
      output$conclusions1 <- renderText({
        "1. As the quantity supplied is increased and quantity demanded remains the same, the price decreases (i.e., less demand for the new larger supply)."
      })
      output$conclusions2 <- renderText({
        "2. As the quantity supplied is decreased and quantity demanded remains the same, the price increases (i.e., more demand for the new smaller supply)."
      })

      plot_ly(data = df, x = ~xD, y = ~yD, name = "Demand", type = "scatter", mode="lines", line = list(color = "red")) %>%
        add_trace(x = ~xS, y = ~yS, name = "Supply (Default)", line = list(color = "blue")) %>%
        add_trace(x = ~xS1, y = ~yS1, name = "Supply (Adjusted)", line = list(color = "black", dash = "dash")) %>%
        layout(annotations = list(aAnnot, aAnnot2),
               ##title = "Demand versus Supply",
               xaxis = list(title = "Gallons of milk", range = c(10000, 50000)),
               yaxis = list (title = "Price of Milk", range = c(0.5, 10.5)))
    })

})
