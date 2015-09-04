library(shiny)
source("./function/EDA.R")
source("./function/limma.R")
source("./function/deseq.R")
source("./function/deseq2.R")


shinyServer(function(input, output) {
  
  

  
  observeEvent(input$dataIn, {
    source("./server/dataIn_server.R", local=TRUE)
    source("./server/EDA_server.R", local=TRUE)
    observeEvent(input$controlSet, {
      observeEvent(input$methodSet, {
        if("LIMMA" %in% methods()) {
          source("./server/limma_server.R", local=TRUE)
        }
        
        if("DESeq" %in% methods()) {
          source("./server/deseq_server.R", local=TRUE)
        }
        
        if("DESeq2" %in% methods()) {
          source("./server/deseq2_server.R", local=TRUE)
        }
      })
      
      })
    
    observeEvent(input$methodSet, {
      source("./server/output_server.R", local=TRUE)
    })
    
    
    observeEvent(input$showRes, {
      source("./server/overlap_server.R", local=TRUE)
      
    })
    
  })
  
  
 
})






