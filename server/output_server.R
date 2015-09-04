if("LIMMA" %in% methods()) {
  output$table_limma <<- renderDataTable({
  temp <- limma_de_table_res()
  temp <- cbind(ID = rownames(temp), temp)
  exp <- dat()[filter(),]
  exp <- cbind(ID = rownames(exp), exp)
  merge(exp,temp, by = "ID")
  })
  
  output$figure_voom_limma <<- renderPlot(limma_voom_figure(limma_ob()))
  output$figure_qt_limma <<- renderPlot(limma_qt_figure(limma_fit_res()))

}

if("DESeq" %in% methods()) {
  output$figure_disp_deseq <<- renderPlot(DESeq::plotDispEsts(cds()))
  output$figure_MA_deseq <<- renderPlot(DESeq::plotMA(res()))
  output$table_deseq <<- renderDataTable({
    temp <- as.data.frame(res())
    exp <- dat()
    exp <- cbind(ID = rownames(exp), exp)
    merge(exp, temp, by.x = "ID", by.y = "id")
  })
}



if("DESeq2" %in% methods()) {
  output$figure_disp_deseq2 <<- renderPlot(DESeq2::plotDispEsts(dds()))
  output$figure_MA_deseq2 <<- renderPlot(DESeq2::plotMA(res2()))
  output$table_deseq2 <<- renderDataTable({
    temp <- as.data.frame(res2())
    temp <- cbind(ID= rownames(temp), temp)
    exp <- dat()
    exp <- cbind(ID = rownames(exp), exp)
    merge(exp, temp, by = "ID")
  })
  
}

