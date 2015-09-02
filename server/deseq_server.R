cds <- reactive(deseq(dat(), controls(), filter()))
res <- reactive(deseq_de(cds()))

output$table_deseq <- renderDataTable({
  temp <- res()
  cbind(ID = rownames(temp), dat(), temp)
})

output$figure_disp_deseq <- renderPlot(DESeq::plotDispEsts(cds()))
output$figure_MA_deseq <- renderPlot(DESeq::plotMA(res()))
