library(shiny)
# library(xlsx)
source("./function/EDA.R")
source("./function/limma.R")
source("./function/deseq.R")
source("./function/deseq2.R")
source("./function/overlap.R")
library(shinyjs)
library(V8)
library(scales)
library(dendextend)

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
      output$figure_UP <- renderPlot(drawVenn(res_list()$up, 
                                              title = "Overlap of UP Regulated Genes"),
                                     width = 300, height = 300)
      output$figure_DN <- renderPlot(drawVenn(res_list()$dn, 
                                              title = "Overlap of DOWN Regulated Genes"),
                                     width = 300, height = 300)
      observeEvent(input$showHeatmap, {
        
        output$de_heatmap <- renderPlot(drawHeatmap(data = dat(), genes = res_list(),
                                                    xmar = input$xmar, ymar = input$ymar,
                                                    title = input$heat_title, 
                                                    ksample  = input$heat_NoSampleCl, 
                                                    kgene = input$heat_NoGeneCl, 
                                                    unsupre = input$heat_unsup),
                                        width = input$heat_x, height = input$heat_y)
      })
      
      
      # methods <- reactive(as.character(input$methods))
      output$showInterTableBox <<- renderUI({
        checkboxGroupInput('interTableMethods',
                           'Choose Analysis Methods',
                           methods())
        
              })
      
      
    })
    
    
    observeEvent(input$showResTable, {
      source("./server/inter_table_server.R", local=TRUE)
      
      output$interTableRes <- renderDataTable(intersect_table())
#       output$downloadExcel <- downloadHandler(
#         filename = function() { paste('summary.xlsx') },
#         content = function(file) {write.xlsx(intersect_table(), file, row.names = F)}
#       )
      
      output$downloadCSV <- downloadHandler(
        filename = function() { paste('summary.csv') },
        content = function(file) {write.csv(intersect_table(), file, row.names = F)}
      )
      
      output$downloadTXT <- downloadHandler(
        filename = function() { paste('summary.txt') },
        content = function(file) {write.table(intersect_table(), file, row.names = F,
                                              sep = "\t", quote = F)}
      )
      
      
    })
    
    
    output$DAVID_up <- renderUI({
      tags$a(href = "#", "DAVID")
    })
    
    output$DAVID_dn <- renderUI({
      tags$a(href = "#", "DAVID")
    })
    
    output$DAVID_both <- renderUI({
      tags$a(href = "#", "DAVID")
    })
    
    
   
    
    observeEvent(input$goAnalyze, {
      
      observeEvent(input$Enrichr_both, {
        
        genes <- paste(splitUPDN(intersect_table(),"both"), collapse = "\n")
        js$enrichr(list = genes)
        
      })      
      observeEvent(input$Enrichr_up, {
        
        genes <- paste(splitUPDN(intersect_table(),"up"), collapse = "\n")
        js$enrichr(list = genes)
        
      })      
      observeEvent(input$Enrichr_dn, {
        
        genes <- paste(splitUPDN(intersect_table(),"dn"), collapse = "\n")
        js$enrichr(list = genes)
        
      })
      
      output$DAVID_up <- renderUI({
        
        genes <- paste(splitUPDN(intersect_table(),"up"), collapse = ",")
        
        link <- paste0("http://david.abcc.ncifcrf.gov/api.jsp?type=",
                       input$david_type, "&ids=",genes,"&tool=summary")
        if(nchar(link) < 2048 & length(strsplit(x = genes, split = ",")) < 400) {
          tags$a(href = link, "DAVID for UP", target = "_blank")
        }
        else {tags$a(href = "#", "Too Many Genes to Perform")}
        
      })
      
      
      output$DAVID_dn <- renderUI({
        
        genes <- paste(splitUPDN(intersect_table(),"dn"), collapse = ",")
        link <- paste0("http://david.abcc.ncifcrf.gov/api.jsp?type=",
                       input$david_type, "&ids=",genes,"&tool=summary")
        
        if(nchar(link) < 2048 & length(strsplit(x = genes, split = ",")) < 400) {
          tags$a(href = link, "DAVID for Down", target = "_blank")
        }
        else {tags$a(href = "#", "Too Many Genes to Perform")}
        
      })
      
      
      output$DAVID_both <- renderUI({
        
        genes <- paste(splitUPDN(intersect_table(),"both"), collapse = ",")
        link <- paste0("http://david.abcc.ncifcrf.gov/api.jsp?type=",
                       input$david_type, "&ids=",genes,"&tool=summary")
        
        if(nchar(link) < 2048 & length(strsplit(x = genes, split = ",")) < 400) {
          tags$a(href = link, "DAVID for Both", target = "_blank")
        }
        else {tags$a(href = "#", "Too Many Genes to Perform")}
      })
      
    })
    
  })
  
  
 
})






