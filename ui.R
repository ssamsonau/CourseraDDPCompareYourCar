library(shiny)

shinyUI(pageWithSidebar(
    
    headerPanel("Compare your's car mpg to others"),
    
    sidebarPanel(
        selectInput("iTr", "Transmission", levels(DFs$Trans), selected="A" ),
        selectInput("iCyl", "Number of Cylinders",
                    sort( unique(DFs$X..Cyl) ), selected=4),
        
        numericInput("iCarMPG", "Enter City mpg of your car", 15, 0, 230),
        
        actionButton('estimateButton', "Refresh Plot"),
        
        h3("_______"),
        h3("You entered:"),
        h4('Type of transmission'),
        verbatimTextOutput("oTr"),
        h4('Number of cylinders'),
        verbatimTextOutput("oCyl"),
        h4('City mpg of your car'),
        verbatimTextOutput("oCarMPG")
    ),
    
    mainPanel(
        h4("! How to use the app"),
        helpText("
            Please choose on the left a transmisiion type of your car and a number of cylinders. After that please enter mpg of your car.
            Press 'Refresh button' to compare mpg to average mpg from other brands in the year 2014 with the same number of cylinders and transmission type.
            This application uses the data from http://www.fueleconomy.gov/feg/epadata/14data.zip ."
        ),
        helpText("On the plot color helps you to see which manufacturers make cars with a better mpg"),
        helpText("This model is oversimplified to keep algorithm small and clear for reviews."),
        plotOutput("mpgPlot")
    )
))