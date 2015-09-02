library(shiny)


shinyServer(function(input, output) {
  
  
  
  
  observeEvent(input$dataIn, {
    source("./server/dataIn_server.R", local=TRUE)
    source("./function/EDA.R")
    source("./server/EDA_server.R", local=TRUE)
    observeEvent(input$controlSet, {
      observeEvent(input$methodSet, {
        if("LIMMA" %in% methods()) {
          source("./function/limma.R")
          source("./server/limma_server.R", local=TRUE)
        }
        
        if("DESeq" %in% methods()) {
          source("./function/deseq.R")
          source("./server/deseq_server.R", local=TRUE)
        }
        
        if("DESeq2" %in% methods()) {
          source("./function/deseq2.R")
          source("./server/deseq2_server.R", local=TRUE)
        }
      })
      
      })
    
    observeEvent(input$showRes, {
      source("./server/overlap_server.R", local=TRUE)
      
    })
    
  })
  
  
 
})






