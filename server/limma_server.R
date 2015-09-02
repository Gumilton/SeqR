
limma_ob <- reactive(limma(dat(), controls(), filter()))
limma_fit_res <- reactive(limma_fit(limma_ob()))

limma_de_table_res <- reactive(limma_de_table(limma_fit = limma_fit_res(), 
                                              limma_ob = limma_ob()))
output$table_limma <- renderDataTable({
  temp <- limma_de_table_res()
  temp <- cbind(ID = rownames(temp), temp)
  exp <- dat()[filter(),]
  exp <- cbind(ID = rownames(exp), exp)
  merge(exp,temp, by = "ID")
})
  
output$figure_voom_limma <- renderPlot(limma_voom_figure(limma_ob()))
output$figure_qt_limma <- renderPlot(limma_qt_figure(limma_fit_res()))
  
