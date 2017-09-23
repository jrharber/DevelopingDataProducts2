#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

defaultValue <- 30000

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Demand versus Supply Demonstration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("quanitySupplied",
                   "Quantity supplied:",
                   "defaultValue",
                   min = 10000,
                   max = 50000,
                   value = defaultValue,
                   step = 2500),
      h3("Instructions:"),
      h4("1.	Move the slider bar to adjust the quantity supplied."),
      h4("2.	The graph will adjust showing the new equilibrium point between supply and demand."),
      h4("3.	The default graph at startup is retained to show the effect of the adjustment."),
      h4("4.	The adjusted supply curve is shown as the dashed line."),
      h4("5.	The equilibrium point for price and supply is where the demand and supply curves intersect.")
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("distPlot"),
       h4(textOutput("equilibriumSupply")),
       h4(textOutput("equilibriumPrice")),
       h4(textOutput("conclusions")),
       h5(textOutput("conclusions1")),
       h5(textOutput("conclusions2"))
    )
  )
))
