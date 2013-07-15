library(shiny)
library(datasets)

# use the mtcars dataset
mpgData <- mtcars
mpgData <- mpgData[,-9]

shinyServer(function(input, output) {
  
  output$contents <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile)) return(NULL);
    
    read.csv(inFile$datapath, header = input$header, sep = input$sep, quote = input$quote)
  })
  
  output$table <- renderTable({
    if (input$cntr_scl) {
      mpgData <- center.and.scale(mpgData)
    }
    cor(mpgData[ ,-9], method = input$cor_method)
  })
  
  output$summary <- renderPrint({
    if (input$cntr_scl) {
      mpgData <- center.and.scale(mpgData)
    }
    
    for (i in 2:ncol(mpgData)) {
      print(cor.test(mpgData$mpg, mpgData[,i], 
                     alternative = input$Ha, method = input$cor_method,
                     conf.level = input$conf_lvl))
    }
  })
})






