library(shiny)
library(datasets)

# use the mtcars dataset
mpgData <- mtcars
mpgData <- mpgData[,-9]

center.and.scale <- function(inputDF) {
  num.vec <- logical(length = ncol(inputDF))
  for (i in 1:length(num.vec)) {
    num.vec[i] <- is.numeric(inputDF[1,i])
  }
  
  tempDF <- inputDF[ ,num.vec]
  inputMean <- colMeans(tempDF, na.rm=TRUE)
  inputSD <- apply(tempDF, 2, sd, na.rm=TRUE)
  
  for (i in 1:ncol(inputDF)) {
    tempDF[,i] <- tempDF[,i] - inputMean[i] / inputSD[i]
  }
  
  count <- 0 
  for (i in 1:length(num.vec)) {
    if (num.vec[i]) {
      count <- count + 1
      inputDF[,i] <- tempDF[,count]
    }
  }
  return(inputDF)
}

shinyServer(function(input, output) {
  
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
    cor.test(mpgData$mpg, mpgData$wt, 
             alternative = input$Ha, method = input$cor_method,
             conf.level = input$conf_lvl)
  })
})

