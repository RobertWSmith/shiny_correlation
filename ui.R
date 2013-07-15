library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Correlation"),
  
  sidebarPanel(
    
    checkboxInput("advanced", "Advanced Options"),
    
    conditionalPanel("input.advanced == true",
                     
                     selectInput("cor_method", "Choose a Correlation Method:",
                                 choices = list("Pearson's rho" = "pearson",
                                                "Kendall's tau" = "kendall",
                                                "Spearman's rho" = "spearman"),
                                 selected = "Pearson's rho"),
                     
                     selectInput("Ha", "Alternative Hypothesis:",
                                 choices = list("Two-Tailed" = "two.sided", 
                                                "Less Than" = "less", 
                                                "Greater Than" = "greater"),
                                 selected = "Two-Tailed"),
                     
                     selectInput("pred", "Predictor:",
                                 choices = colnames(mpgData),
                                 selected = colnames(mpgData)[1]),
                     
                     selectInput("conv_lvl", "Confidence Level:",
                                 choices = list("0.50" = 0.5,
                                                "0.90" = 0.9,
                                                "0.95" = 0.95,
                                                "0.99" = 0.99),
                                 selected = "0.95"),
                     
                     radioButtons("cntr_scl", "Center and Scale:",
                                  choices = list("Yes" = TRUE,
                                                 "No" = FALSE),
                                  selected = "No")
    )
  ),
  

  
  mainPanel(
    tabsetPanel(
      #       tabPanel("Correlation Plots", plotOutput("plot")),
      tabPanel("Correlation Matrix", tableOutput("table")),
      tabPanel("Summary", verbatimTextOutput("summary"))
    )
  )
))

