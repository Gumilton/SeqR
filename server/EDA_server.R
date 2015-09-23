output$densityPlot <- renderPlot({
  
  DensityPlot(dat(), cutoff = input$cutoff)
  
})

filter <- reactive({
  geneMeans <- rowMeans(dat())
  qt <- quantile(geneMeans, as.numeric(input$cutoff)/100)
  return(geneMeans > qt)
})

output$PCAPlot <- renderPlot(PCAPlot(dat(), controls(), filter()))

output$PCA_click_info <- renderPrint({
  # this was a base graphics plot, we'd need to supply xvar or yvar
  # nearPoints(mtcars2, input$plot1_click, addDist = TRUE)
})

output$PCA_brush_info <- renderPrint({
  # brushedPoints(mtcars2, input$plot1_brush)
})

output$LibSizePlot <- renderPlot(libSizePlot(dat()))
