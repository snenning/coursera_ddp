#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting Swiss Fertility measure on socio-economic indicators"),
  h4("The application is for predicting fertility based on prediction model using either Agriculture or Education as indicator."),
  h6("Data for prediction used is standardized fertility measure and socio-economic indicators for each of 47 French-speaking provinces of Switzerland at about 1888."),
  h6("Indicators in percentage are Agriculture, Examination (army), Education, Catholic, and Infant Mortality"),
   # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Select Indicator for Prediction Model"),
                   choices = list("Agriculture"= 1, "Education"= 2),
                   selected = 1),
      sliderInput("sliderIndicator", "Select population percentage for selected indicator for fertility prediction", 0, 100, value = 50),
      h4("Click Submit to run application and update plot and prediction"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       h4("Predicted Fertility for selected population percentage:"),
       textOutput("pred") 
    )
  )
))
