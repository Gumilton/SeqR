library(shiny)


shinyServer(function(input, output) {
  
  
  dat <- reactive({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    
    temp <- read.csv(inFile$datapath, header = T, stringsAsFactors = F)
    rownames(temp) <- make.unique(temp[,1], sep = "_")
    temp <- temp[,-1]
    return(temp)
  })
  
  output$datatable <- renderDataTable({
    temp <- dat()
    cbind(ID = rownames(temp), temp)
  })
  
  output$controlbox <- renderUI({
    if (!is.null(dat())) {
      checkboxGroupInput('controlSamples',
                         'Choose control samples',
                         colnames(dat())
      )
      }
    })
  
  controls <- reactive(input$controlSamples)
  
  source("./helper.R")
  
  output$densityPlot <- renderPlot(DensityPlot(dat()))
  
  output$PCAPlot <- renderPlot(PCAPlot(dat(), controls()))
  
  
  
  
  
  
  
  
})