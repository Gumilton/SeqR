library(shiny)


shinyServer(function(input, output) {
  
  
  
  
  observeEvent(input$dataIn, {
    source("./dataIn_server.R", local=TRUE)
    source("./EDA.R")
    source("./EDA_server.R", local=TRUE)
    observeEvent(input$controlSet, {
      observeEvent(input$methodSet, {
        if("LIMMA" %in% methods()) {
          source("./limma.R")
          source("./limma_server.R", local=TRUE)
        }
        
        if("DESeq" %in% methods()) {
          source("./deseq.R")
          source("./deseq_server.R", local=TRUE)
        }
        
        if("DESeq2" %in% methods()) {
          source("./deseq2.R")
          source("./deseq2_server.R", local=TRUE)
        }
      })
      
      })
    
    observeEvent(input$showRes, {
      source("./overlap_server.R", local=TRUE)
      
    })
    
  })
  
  
 
})






