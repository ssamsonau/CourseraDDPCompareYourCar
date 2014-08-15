
library(shiny)
library(ggplot2)
library(plyr)

DFtemp <- DFs # make this variable available in every function of this file

shinyServer(
    function(input, output) {
        
        output$oCyl <- renderPrint({input$iCyl})
        output$oTr <- renderPrint({ input$iTr })
        output$oCarMPG <- renderPrint({ input$iCarMPG })
        
        G <-reactive({
            DFtemp <- subset(DFs, Trans == {input$iTr} & X..Cyl == {input$iCyl})

            DFtemp <- ddply(DFtemp, "Mfr.Name", summarise, 
                            City.MPG=mean(City.MPG))   
            
            DFtemp$compare <- "better"
            DFtemp[DFtemp$City.MPG < {input$iCarMPG}, "compare"] <- "worse"
            
            ggplot(data=DFtemp, aes(x=reorder(Mfr.Name, City.MPG), 
                                    y=City.MPG, col = compare)) +                
                geom_bar(stat="identity") +
                coord_flip() + xlab("") + ylab("City MPG")
        })

        output$mpgPlot <- renderPlot({
            input$estimateButton            
            isolate( G() )
        })
        
    }
)
