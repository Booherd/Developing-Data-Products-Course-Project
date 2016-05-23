library(shiny)
shinyUI(pageWithSidebar(
headerPanel("BMI Calculator"),

        sidebarPanel(
        numericInput("htft","Patient Height (feet)",5,min=0,max=8),   
        numericInput("htin","Patient Height (inches)",0,min=0,max=12),
        sliderInput("wt","Patient Weight in Pounds:",160,min=40,max=400),
        radioButtons("gender", "Patient Gender", c("Male","Female"), inline = TRUE),
        
        #documentation
        br(),
        h4('Documentation'),
        h5('This app is designed to estimate Body Mass Index based on height and weight.'),
        h5('Users should enter height as feet then inches, then use the slidebar to select the appropriate weight.'),
        h5('The BMI results are calculated using the forumal: weight/height in inches squared times 703.'),
        h5('The chart shows patient Height and weight compared to the standards for underweight, overwieight, and obesity'),
        h5('Results falling outside the range of the chart are shown along the perimeter.'),
        h6('*While BMI si a useful data point, it cannot be used on its own as a reliable measure of health.  All patients should consult with their doctor about their results.')
        
        
        ),        
     
              
              
mainPanel(
        h4('Body Mass Index:'),
        verbatimTextOutput("BMI"),
        h4('Status:'),
        verbatimTextOutput("WtClass"),
        plotOutput("BmiChart")
)
)
)