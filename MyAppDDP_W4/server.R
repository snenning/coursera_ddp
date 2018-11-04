#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 

  # calculate predicton models for indicators
    model1 <- lm(Fertility ~ Agriculture, data = swiss)
    model2 <- lm(Fertility ~ Education, data = swiss)

    
   #Predict Fertility based on indicator input value
    modelpred1 <-  reactive({
      IndicatorInput <- input$sliderIndicator 
      predict(model1, newdata = data.frame(Agriculture = IndicatorInput))
    })

    modelpred2 <-  reactive({
      IndicatorInput <- input$sliderIndicator 
      predict(model2, newdata = data.frame(Education = IndicatorInput))
    })

      
    # draw the plot with swiss data and prediction for selected indicator and indicator value
    output$distPlot <- renderPlot({
      #if statement to plot selected model data
      if(input$radio == 1){ 
        plot(swiss$Fertility, swiss$Agriculture, xlab = "% of males involved in agriculture as occupation", 
             ylab = "Fertility", bty = "n", pch = 16) 
        abline(model1, col = "red", lwd = 2) 
        points(input$sliderIndicator , modelpred1(), col = "red", pch = 16, cex = 2) 
      } 
   
      if(input$radio == 2){ 
        plot(swiss$Fertility, swiss$Education, xlab = "% education beyond primary school for draftees", 
             ylab = "Fertility", bty = "n", pch = 16) 
        abline(model2, col = "blue", lwd = 2) 
        points(input$sliderIndicator , modelpred2(), col = "blue", pch = 16, cex = 2) 
      }     
    }) 
    
      
    # Print predicted fertility measure value for selected indicator value
      output$pred <- renderText({ 
        if(input$radio == 1){ 
            round(modelpred1(),2)
        }
        
        else if(input$radio == 2){ 
            round(modelpred2(),2)
        }
      })
    
})
