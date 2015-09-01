library(shiny)


shinyServer(function(input, output) {
  
  
  dat <- reactive({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    
    temp <- read.csv(inFile$datapath, header = T, stringsAsFactors = F)
    rownames(temp) <- make.unique(temp[,1], sep = "_")
    temp <- temp[,-1]
    temp <- na.omit(temp)
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
  
  controls <- reactive(as.character(input$controlSamples))
  
  source("./helper.R")
  
  output$densityPlot <- renderPlot({
    
    DensityPlot(dat(), cutoff = input$cutoff)
    
    })
  
  filter <- reactive({
    geneMeans <- rowMeans(dat())
    qt <- quantile(geneMeans, as.numeric(input$cutoff)/100)
    return(geneMeans > qt)
  })
  
  output$PCAPlot <- renderPlot(PCAPlot(dat(), controls(), filter()))
  
  output$LibSizePlot <- renderPlot(libSizePlot(dat()))
  
  
  source("./limma.R")
  source("./limma_server.R", local=TRUE)
  
  
  
  #   source("./deseq.R")
  #   source("./deseq2.R")
  #   res_deseq <- reactive(deseq(dat(), controls(), filter()))
  #   res_deseq2 <- reactive(deseq2(dat(), controls()))
  
  
})






