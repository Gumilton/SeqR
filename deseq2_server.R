dds <- reactive(deseq2(dat(), controls(), filter()))
res2 <- reactive(deseq2_de(dds()))

output$table_deseq2 <- renderDataTable({
  temp <- as.data.frame(res2())
  temp <- cbind(ID= rownames(temp), temp)
  exp <- dat()
  exp <- cbind(ID = rownames(exp), exp)
  merge(exp, temp, by = "ID")
})

output$figure_disp_deseq2 <- renderPlot(DESeq2::plotDispEsts(dds()))
output$figure_MA_deseq2 <- renderPlot(DESeq2::plotMA(res2()))
