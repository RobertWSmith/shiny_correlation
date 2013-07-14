library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Correlation"),
  
  sidebarPanel(
    selectInput("cor_method", "Choose a Correlation Method:",
                choices = list("Pearson's rho" = "pearson",
                               "Kendall's tau" = "kendall",
                               "Spearman's rho" = "spearman")),
    
    selectInput("Ha", "Alternative Hypothesis:",
                choices = list("Two-Tailed" = "two.sided", 
                               "Less Than" = "less", 
                               "Greater Than" = "greater")),
    
    sliderInput("conf_lvl", "Confidence Level:",
                min = 0.5, max = 0.99, value = 0.95, step = 0.01),
    
    radioButtons("cntr_scl", "Center and Scale:",
                 choices = list("Yes" = TRUE,
                                "No" = FALSE),
                 selected = "No")
  ),
  

  
  
  #   selectInput("predictor", "Predictor Variable:",
  #               choices = colnames(output$table)),
  
  mainPanel(
    tabsetPanel(
#       tabPanel("Correlation Plots", plotOutput("plot")),
      tabPanel("Correlation Matrix", tableOutput("table")),
      tabPanel("Summary", verbatimTextOutput("summary"))
    )
  )
))

