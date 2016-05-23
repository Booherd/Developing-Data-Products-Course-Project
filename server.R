library(shiny)
library(ggplot2)

BmiCalc <-function(htin,htft,wt){
        ht <- (htin + htft*12)
        BMI <- ((wt*703)/(ht*ht))
        BMI
}
BmiClass <-function(bmi){
        if(bmi<=18.5) {wtclass<-"Underweight"}
        else if(bmi<=25) {wtclass<-"Normal"}
        else if(bmi<=30) {wtclass<-"Overweight"}
        else wtclass<-"Obese"
        wtclass
        
}
uw <- function(x) sqrt((703*x)/18.5)
nm <- function(x) sqrt((703*x)/25)
ow <- function(x) sqrt((703*x)/30)
fixht <-function(htin,htft){
        ht <- (htin + htft*12)
        if(ht<48)ht<-48
        if(ht>84)ht<-84
        ht
}
fixwt <-function(wt){
        if(wt>300)wt<-300
        if(wt<80)wt<-80
        wt
}

shinyServer(function(input, output) {
        
        output$BMI<-renderText({BmiCalc(input$htin,input$htft,input$wt)})
        output$WtClass <- renderText({BmiClass(BmiCalc(input$htin,input$htft,input$wt))})
        
        output$BmiChart <- renderPlot({
                suppressWarnings(print(ggplot(data.frame(x = c(80, 300)), aes(x))
                + stat_function(fun = uw, colour = "green") +
                        stat_function(fun = nm, colour = "blue") +
                        stat_function(fun = ow, colour = "red") +
                        theme_bw()+
                        scale_y_continuous(name="Height in Inches",expand = c(0,0),limits=c(48,84)) + 
                        scale_x_continuous(name="Weight in Pounds",expand = c(0,0)) +
                        annotate("text", x = 105, y = 80, label = "Underweight",size=5) +
                        annotate("text", x = 185, y = 80, label = "Normal",size=5) +
                        annotate("text", x = 250, y = 80, label = "Overweight",size=5)+
                        annotate("text", x = 265, y = 70, label = "Obese",size=5)+
                        annotate("point",x=(fixwt(input$wt)),y=(fixht(input$htin,input$htft)),size=6,color="red")
                ))
        })
        })